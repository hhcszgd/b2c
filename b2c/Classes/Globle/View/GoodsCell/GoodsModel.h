//
//  GoodsModel.h
//  b2c
//
//  Created by 0 on 16/4/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsModel : BaseModel
/**商品介绍*/
@property (nonatomic, copy) NSString *titleStr;
/**价格*/
@property (nonatomic, copy) NSString *priceStr;
/**购买人数*/
@property (nonatomic, copy) NSString *countStr;
/***/
@property (nonatomic, strong) NSMutableArray *goodsModelArr;
@end
