//
//  HCellModel.m
//  b2c
//
//  Created by wangyuanfei on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HCellModel.h"

@implementation HCellModel
-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forKey:(NSString *)key{

    if ([key isEqualToString:@"img"]) {
        self.imgStr = value;
        return;
    }
        if ([key isEqualToString:@"key"]) {
            NSString * classKey = value;
            NSString * prefixUpper = [classKey customFirstCharUpper];
             NSMutableString *mutableStr = [NSMutableString string];
            NSString * classNameStr = [mutableStr stringByAppendingFormat:@"H%@Cell",prefixUpper];

            self.classKey = classNameStr;
            return;
        }

    if ([key isEqualToString:@"actionkey"]) {
        self.actionKey = value;
        return;
    }
    [super setValue:value forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
