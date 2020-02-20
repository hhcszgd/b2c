//
//  HCellComposeModel.h
//  b2c
//
//  Created by wangyuanfei on 4/12/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HBaseModel.h"

@interface HCellComposeModel : HBaseModel
/** id */
@property(nonatomic,assign)NSInteger  ID ;
/** 图片(对应服务器数据的img字段,背景图,产品图,品牌logo全用这一个字段) */
@property(nonatomic,copy)NSString * imgStr ;
/** 标题字段1 */
@property(nonatomic,copy)NSString * full_name ;
/** 价格 */
@property(nonatomic,assign)CGFloat  price ;
/** actionKay 父类有了 */

-(instancetype)initWithDict:(NSDictionary*)dict;
@end
