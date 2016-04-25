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
        didSelectIndex:(NSInteger)index;

@end



@interface LGBCycleScrollView : UIScrollView

@property (nonatomic, assign) id<LGBCycleScrollViewDelegate> cycleScrollDelegate;

/**
 *  默认2s
 */
@property (nonatomic, assign) NSTimeInterval scrollTimeInterval;

/**
 *  必须组册Cell Class
 *
 *  @param cellClass 必须实现 LGBCycleScrollViewCellDelegate 协议
 */
-(void)registerCellClass:(Class)cellClass;

-(void)configItemsWithData:(NSArray *)data;

-(void)setCycleScrollPageControl:(UIView<LGBCycleScrollViewPageControlDelegate> *)pageControl;

@end
