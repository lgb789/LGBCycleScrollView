//
//  LGBCycleScrollViewPageControl.m
//  CycleScrollView
//
//  Created by lgb789 on 16/4/25.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBCycleScrollViewPageControl.h"

@interface LGBCycleScrollViewPageControl ()
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation LGBCycleScrollViewPageControl

#pragma mark - *********************** public methods ***********************

#pragma mark - *********************** overwrite methods ***********************

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.pageControl];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.pageControl.frame = self.bounds;
}

#pragma mark - *********************** delegate ***********************
-(void)setNumberOfPages:(NSInteger)pages
{
    self.pageControl.numberOfPages = pages;
}

-(void)setCurrentOfPage:(NSInteger)page
{
    [self.pageControl setCurrentPage:page];
}

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

#pragma mark - *********************** getters and setters ***********************
-(UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.hidesForSinglePage = YES;
        [_pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    }
    return _pageControl;
}

@end
