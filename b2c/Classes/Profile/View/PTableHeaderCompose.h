//
//  PTableHeaderCompose.h
//  b2c
//
//  Created by wangyuanfei on 4/9/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ActionBaseView.h"

typedef enum : NSUInteger {
    PTableHeaderComposeNumberStyle,
    PTableHeaderComposeImageStyle,
} PTableHeaderComposeStyle;

@interface PTableHeaderCompose : ActionBaseView
@property(nonatomic,assign)NSInteger  composeCount ;
@property(nonatomic,copy)NSString * composeTitle ;
-initWithStyle:(PTableHeaderComposeStyle)style;
@end
