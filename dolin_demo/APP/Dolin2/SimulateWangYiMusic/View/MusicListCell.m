//
//  MusicListCell.m
//  MusicDemo
//
//  Created by dear on 16/6/15.
//  Copyright © 2016年 张华. All rights reserved.
//

#import "MusicListCell.h"

@implementation MusicListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellWithMusic:(Music *)music {
    //歌名和歌曲简介
    if (music.musicIntroduce != NULL) {
        self.musicName.text = [NSString stringWithFormat:@"%@(%@)",music.name,music.musicIntroduce];;
    }else{
        self.musicName.text = music.name;
    }
    //歌手和专辑
    self.singerName.text =[NSString stringWithFormat:@"%@ - %@",music.singer,music.theAlbumName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
