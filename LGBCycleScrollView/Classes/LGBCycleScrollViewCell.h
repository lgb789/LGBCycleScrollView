//
//  LGBCycleScrollViewCell.h
//  CycleScrollView
//
//  Created by lgb789 on 16/4/22.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LGBCycleScrollViewCellDelegate <NSObject>

-(void)configCellWithData:(id)data;

@end

@interface LGBCycleScrollViewCell : UICollectionViewCell <LGBCycleScrollViewCellDelegate>

@end
