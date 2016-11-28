//
//  MusicListCell.h
//  MusicDemo
//
//  Created by dear on 16/6/15.
//  Copyright © 2016年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Music.h"

@interface MusicListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *musicName;
@property (weak, nonatomic) IBOutlet UILabel *singerName;
@property (weak, nonatomic) IBOutlet UILabel *number;
-(void)setCellWithMusic:(Music *)music;
@end
