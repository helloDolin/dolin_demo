//
//  DolinBannerView.h
//  无线轮播图-少林
//
//  Created by shaolin on 16/7/9.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DolinBannerViewDelegate <NSObject>

- (void)didSelectBannerViewWithDic:(NSDictionary*)dic;

@end

@interface DolinBannerView : UIView

@property (nonatomic,weak)id<DolinBannerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame WithInfoArr:(NSArray *)infoArr;

@end
