//
//  NewData.h
//  Demo
//
//  Created by hukezhu on 16/5/10.
//  Copyright © 2016年 hukezhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewData : NSObject
@property(nonatomic,copy)NSString * imgsrc;/**  新闻配图*/

@property(nonatomic,copy)NSString *title;/**  新闻标题*/

@property(nonatomic,copy)NSString *docid;/**  新闻ID*/

@property(nonatomic,copy)NSString *digest;/**  新闻子标题*/

@property(nonatomic,copy)NSString *url;
@end
