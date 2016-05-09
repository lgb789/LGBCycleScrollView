//
//  LGBCycleScrollViewCell.h
//  CycleScrollView
//
//  Created by lgb789 on 16/4/22.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGBCycleScrollViewCell : UICollectionViewCell

//子类重写此方法
-(void)configCellWithData:(id)data;

@end
