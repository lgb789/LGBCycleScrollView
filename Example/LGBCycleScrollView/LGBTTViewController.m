//
//  LGBTTViewController.m
//  LGBCycleScrollView
//
//  Created by lgb789 on 16/4/25.
//  Copyright © 2016年 lgb789. All rights reserved.
//

#import "LGBTTViewController.h"
#import "LGBCycleScrollView.h"

@interface LGBTTViewController () <LGBCycleScrollViewDelegate>
@property (nonatomic, strong) LGBCycleScrollView *scrollView;
@end

@implementation LGBTTViewController

#pragma mark - *********************** life cycle ***********************

-(void)loadView
{
    [super loadView];
    /* set navigation bar, self.view */
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /* add subviews */
    [self.view addSubview:self.scrollView];
    
    [self layoutSubviews];
    
    [self.scrollView configItemsWithData:@[
                                           @"pic3.jpg",
                                           ]];

#if 1
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.scrollView configItemsWithData:@[
                                               @"pic1.jpg",
                                               @"pic2.jpg",
                                               @"pic3.jpg",
                                               @"pic4.jpg",
                                               ]];
    });
#else
    [self.scrollView configItemsWithData:@[
                                      @"pic1.jpg",
                                      @"pic2.jpg",
                                      @"pic3.jpg",
                                      @"pic4.jpg",
                                      ]];
#endif
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /* add notificatioin */
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    /* remove notificatioin */
}

#pragma mark - *********************** delegate ***********************
-(void)cycleScrollView:(LGBCycleScrollView *)scrollView didSelectItem:(NSInteger)item
{
    NSLog(@"index--->%ld", item);
}

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

-(void)layoutSubviews
{
    self.scrollView.frame = CGRectMake(0, 80, CGRectGetWidth(self.view.bounds), 150);
}

#pragma mark - *********************** getters and setters ***********************
-(LGBCycleScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [LGBCycleScrollView new];
        [_scrollView registerCellClass:[LGBCycleScrollViewCell class]];
        [_scrollView setCycleScrollPageControl:[LGBCycleScrollViewPageControl new]];
        _scrollView.cycleScrollDelegate = self;
    }
    return _scrollView;
}

@end
