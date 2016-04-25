//
//  LGBCycleScrollViewPageControl.h
//  CycleScrollView
//
//  Created by lgb789 on 16/4/25.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LGBCycleScrollViewPageControlDelegate <NSObject>

-(void)setNumberOfPages:(NSInteger)pages;

-(void)setCurrentOfPage:(NSInteger)page;

@end

@interface LGBCycleScrollViewPageControl : UIView <LGBCycleScrollViewPageControlDelegate>

@end
