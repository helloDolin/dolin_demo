//
//  ImageModel.h
//  abinTest
//
//  Created by dolin on 16/8/17.
//  Copyright © 2016年 dolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageModel : NSObject

@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *file;
@property(nonatomic,strong)NSString *thumbnail;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,strong)NSString *resourceableType;
@property(nonatomic,strong)NSString *resourceableId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger size;
@property(nonatomic,strong)NSString *fileType;


@end
