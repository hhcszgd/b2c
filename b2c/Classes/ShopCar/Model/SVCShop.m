//
//  SVCShop.m
//  TTmall
//
//  Created by wangyuanfei on 3/13/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import "SVCShop.h"

@implementation SVCShop
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.shopTicket = NO;
        self.shopSelect = NO;
        self.shopEditing = NO;

    }
    return self;

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}


@end
