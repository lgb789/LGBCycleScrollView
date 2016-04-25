//
//  LGBCycleScrollViewCell.m
//  CycleScrollView
//
//  Created by lgb789 on 16/4/22.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBCycleScrollViewCell.h"

@interface LGBCycleScrollViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LGBCycleScrollViewCell

#pragma mark - *********************** public methods ***********************

#pragma mark - *********************** overwrite methods ***********************

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

#pragma mark - *********************** delegate ***********************

-(void)configCellWithData:(id)data
{
    if (data == nil) {
        return;
    }
    UIImage *img = [UIImage imageNamed:data];
    self.imageView.image = img;
}

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

#pragma mark - *********************** getters and setters ***********************
-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

@end
