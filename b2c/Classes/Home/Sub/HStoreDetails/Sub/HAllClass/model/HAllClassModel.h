//
//  HAllClassModel.h
//  b2c
//
//  Created by 0 on 16/3/31.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HAllClassBaseModel.h"

@interface HAllClassModel : HAllClassBaseModel
@property (nonatomic, copy) NSString *sectionTitle;
@property (nonatomic, strong) NSArray *cellModelArr;
@property (nonatomic, copy) NSString *detailClass;
@property (nonatomic, assign) BOOL isSelected;
@end
