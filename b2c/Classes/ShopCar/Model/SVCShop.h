//
//  SVCShop.h
//  TTmall
//
//  Created by wangyuanfei on 3/13/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SVCGoods;
@interface SVCShop : NSObject
/** 店铺id */
@property(nonatomic,assign)NSInteger  shop_id ;
/** 店铺名称 */
@property(nonatomic,copy)NSString * name ;
/** 购物车中收藏的当前店铺的商品的集合 */
@property(nonatomic,strong)NSMutableArray * list ;
-(instancetype)initWithDict:(NSDictionary *)dict;





//////////////////////////////////////////////

@property(nonatomic,assign)BOOL  shopTicket ;
@property(nonatomic,assign)BOOL  shopSelect ;
@property(nonatomic,assign)BOOL  shopEditing ;
@property(nonatomic,assign)BOOL  shopEditButtonHidden ;

@end
