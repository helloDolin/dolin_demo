//
//  RecommendMusicCell.h
//  dolin_demo
//
//  Created by Dolin on 2019/3/26.
//  Copyright © 2019 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNBaseTableViewCell.h"
#import "DLModel.h"

@class RecommendModel;

NS_ASSUME_NONNULL_BEGIN

@interface RecommendMusicCell : MNBaseTableViewCell

@property(nonatomic,strong) RecommendModel *recommendModel;
@property(nonatomic,strong) DLResultTracksModel *dLResultTracksModel;

@end

NS_ASSUME_NONNULL_END
