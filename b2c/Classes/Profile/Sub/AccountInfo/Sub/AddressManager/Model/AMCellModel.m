//
//  AMCellModel.m
//  TTmall
//
//  Created by wangyuanfei on 3/3/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import "AMCellModel.h"

@implementation AMCellModel
-(instancetype)initWithdictionary:(NSDictionary*)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(NSString *)totalAddress{
    return [NSString stringWithFormat:@"%@%@%@%@",self.province,self.city,self.area,self.detailAddress];
}
@end
