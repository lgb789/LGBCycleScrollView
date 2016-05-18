//
//  ScrollViewCell.m
//  LGBCycleScrollView
//
//  Created by lgb789 on 16/5/9.
//  Copyright © 2016年 lgb789. All rights reserved.
//

#import "ScrollViewCell.h"
#import "YYWebImage.h"

@interface ScrollViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ScrollViewCell

#pragma mark - *********************** public methods ***********************

#pragma mark - *********************** overwrite methods ***********************

-(instancetype)initWithFrame:(CGRect)frame
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
    self.imageView.frame = self.bounds;
}

-(void)configCellWithData:(id)data
{
    if (LocalImage) {
        UIImage *img = [UIImage imageNamed:data];
        NSLog(@"img -->%@", img);
        self.imageView.image = img;
    }else{
        [self.imageView yy_setImageWithURL:[NSURL URLWithString:data] options:YYWebImageOptionProgressiveBlur];
    }
    
}

#pragma mark - *********************** delegate ***********************

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

#pragma mark - *********************** getters and setters ***********************
-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor blackColor];
    }
    return _imageView;
}

@end
