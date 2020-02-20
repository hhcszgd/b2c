//
//  HCellComposeModel.m
//  b2c
//
//  Created by wangyuanfei on 4/12/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HCellComposeModel.h"

@implementation HCellComposeModel
-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
        return;
    }
    if ([key isEqualToString:@"img"]) {
        self.imgStr = value;
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
