//
//  LinkworkLeftCell.m
//  dolin_demo
//
//  Created by dolin on 2017/3/14.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "LinkworkLeftCell.h"

@interface LinkworkLeftCell()
@end

@implementation LinkworkLeftCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"LinkworkLeftCell.h";
    LinkworkLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LinkworkLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self laoutUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.backgroundColor = RGBCOLOR(46, 139, 87);
    }
    else {
        self.backgroundColor = RGBCOLOR(30, 144, 255);
    }
}

- (void)laoutUI {
    self.titleLbl.textColor = [UIColor whiteColor];
    
    [self addSubview:self.titleLbl];
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc]init];
    }
    return _titleLbl;
}

@end
