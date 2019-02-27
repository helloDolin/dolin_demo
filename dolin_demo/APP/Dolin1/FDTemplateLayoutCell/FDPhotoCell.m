//
//  FDPhotoCell.m
//  dolin_demo
//
//  Created by Dolin on 2019/2/27.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import "FDPhotoCell.h"

@interface FDPhotoCell()

@end

@implementation FDPhotoCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.imgView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imgView];
    self.imgView.backgroundColor = [UIColor blackColor];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

@end
