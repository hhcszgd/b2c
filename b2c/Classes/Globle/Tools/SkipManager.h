//
//  SkipManager.h
//  TTmall
//
//  Created by wangyuanfei on 15/12/18.
//  Copyright © 2015年 Footway tech. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseModel.h"

#import <UIKit/UIKit.h>
@interface SkipManager : NSObject
+(instancetype)shareSkipManager;
-(void)skipByVC:(UIViewController*)vc urlStr:(NSString *)urlStr title:(NSString *)titleStr action:(NSString *)action;
-(void)skipByVC:(UIViewController*)vc withUserInfo:(NSDictionary*)userInfo;
/** 目前是给个人中心跳转定制的跳转方法 */
-(void)skipByVC:(UIViewController*)vc withActionModel:(BaseModel*)model;
@end
