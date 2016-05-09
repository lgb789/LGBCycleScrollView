//
//  LGBCycleScrollView.m
//  CycleScrollView
//
//  Created by lgb789 on 16/4/22.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBCycleScrollView.h"

#define Identifier                  @"Identifier"

static NSString * const kStateKey = @"state";

@interface LGBCycleScrollView () <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *viewLayout;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UIView *pageControlContainer;
@property (nonatomic, strong) UIView<LGBCycleScrollViewPageControlDelegate> *control;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentItem;
@end

@implementation LGBCycleScrollView

#pragma mark - *********************** public methods ***********************

-(void)registerCellClass:(Class)cellClass
{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:Identifier];
}

-(void)configItemsWithData:(NSArray *)data
{
    if (data == nil) {
        return;
    }
    [self.items removeAllObjects];
    [self.items addObjectsFromArray:data];
    
    if (data.count > 1) {
        [self.items insertObject:[data lastObject] atIndex:0];
        [self.items addObject:[data firstObject]];
    }

    [self.control setNumberOfPages:data.count];
    
    [self.collectionView reloadData];
    
    [self gotoFirstItem];
    
    if (data.count > 1) {
        [self cancelTimer];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(scrollItems) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
}

-(void)setCycleScrollPageControl:(UIView<LGBCycleScrollViewPageControlDelegate> *)pageControl
{
    [self.control removeFromSuperview];
    [self.pageControlContainer addSubview:pageControl];
    self.control = pageControl;
}

#pragma mark - *********************** overwrite methods ***********************
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview == nil) {
        [self cancelTimer];
    }
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = NO;
        self.scrollTimeInterval = 3;
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControlContainer];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    self.viewLayout.itemSize = self.frame.size;
    
    self.pageControlContainer.frame = self.bounds;
    
    [self.control setFrame:CGRectMake(0, CGRectGetHeight(self.pageControlContainer.bounds) * 0.85, CGRectGetWidth(self.pageControlContainer.bounds), CGRectGetHeight(self.pageControlContainer.bounds) * 0.15)];
    [self gotoFirstItem];
    
}

#pragma mark - *********************** delegate ***********************

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGBCycleScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGBCycleScrollViewCell *c = (LGBCycleScrollViewCell *)cell;
    [c configCellWithData:[self.items objectAtIndex:indexPath.item]];
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.cycleScrollDelegate cycleScrollView:self didSelectItem:indexPath.item];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetX = 0;
    
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollWidth = CGRectGetWidth(scrollView.bounds);
    CGFloat contentWidth = scrollWidth * (self.items.count - 2);
    
    int page = (currentOffsetX + scrollWidth / 2) / scrollWidth - 1;
    int p = page % (self.items.count - 2);
    
    [self.control setCurrentOfPage:p];
    
    self.currentItem = p;
    
    //往左滑动到最后一张
    if (currentOffsetX >= contentWidth + scrollWidth / 2 && currentOffsetX > lastOffsetX) {
        
        lastOffsetX = currentOffsetX - contentWidth;
        scrollView.contentOffset = CGPointMake(lastOffsetX, scrollView.contentOffset.y);
        
    }else if (currentOffsetX < lastOffsetX && currentOffsetX <= scrollWidth / 2){ //向右滑动到第一张
        
        lastOffsetX = currentOffsetX + contentWidth;
        scrollView.contentOffset = CGPointMake(lastOffsetX, scrollView.contentOffset.y);
        
    }else{
        lastOffsetX = currentOffsetX;
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer setFireDate:[NSDate distantFuture]];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.timer setFireDate:[[NSDate alloc] initWithTimeIntervalSinceNow:self.scrollTimeInterval]];
}

#pragma mark - *********************** event response ***********************
-(void)scrollItems
{
    [self.collectionView setContentOffset:CGPointMake(CGRectGetWidth(self.collectionView.bounds) + self.collectionView.contentOffset.x, self.collectionView.contentOffset.y) animated:YES];
}

#pragma mark - *********************** private methods ***********************
-(void)cancelTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)gotoFirstItem
{
    if (self.items.count > 1) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(self.currentItem + 1) inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - *********************** getters and setters ***********************
-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.viewLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;

    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)viewLayout
{
    if (_viewLayout == nil) {
        _viewLayout = [UICollectionViewFlowLayout new];
        _viewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _viewLayout.minimumLineSpacing = 0;
    }
    return _viewLayout;
}

-(NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

-(UIView *)pageControlContainer
{
    if (_pageControlContainer == nil) {
        _pageControlContainer = [UIView new];
        _pageControlContainer.userInteractionEnabled = NO;
    }
    return _pageControlContainer;
}

@end
