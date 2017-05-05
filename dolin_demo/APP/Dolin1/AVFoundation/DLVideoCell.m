//
//  DLVideoCell.m
//  dolin_demo
//
//  Created by dolin on 2017/5/5.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "DLVideoCell.h"

@implementation DLVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(VideoModel *)model {
    _model = model;
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:_model.imgUrlStr] placeholderImage:[UIImage imageNamed:@"MT"]];
}

@end
