//
//  LGBCycleScrollView.h
//  CycleScrollView
//
//  Created by lgb789 on 16/4/22.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGBCycleScrollViewCell.h"
#import "LGBCycleScrollViewPageControl.h"

@class LGBCycleScrollView;

@protocol LGBCycleScrollViewDelegate <NSObject>

-(void)cycleScrollView:(LGBCycleScrollView *)scrollView
         didSelectItem:(NSInteger)item;

@end



@interface LGBCycleScrollView : UIScrollView

@property (nonatomic, assign) id<LGBCycleScrollViewDelegate> cycleScrollDelegate;

/**
 *  默认3s
 */
@property (nonatomic, assign) NSTimeInterval scrollTimeInterval;

/**
 *  必须注册Cell Class
 *
 *  @param cellClass 必须是 LGBCycleScrollViewCell 以及子类
 */
-(void)registerCellClass:(Class)cellClass;

-(void)configItemsWithData:(NSArray *)data;

-(void)setCycleScrollPageControl:(UIView<LGBCycleScrollViewPageControlDelegate> *)pageControl;

@end
