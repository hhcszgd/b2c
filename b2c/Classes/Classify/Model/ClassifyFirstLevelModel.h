//
//  ClassifyFirstLevelModel.h
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyFirstLevelModel : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *child;
@property (nonatomic, copy) NSString *classify_name;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *images;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *childDataArray;
@property (nonatomic, strong) NSArray *SecondChildDataArray;
@end
