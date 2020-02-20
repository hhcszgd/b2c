//
//  SVCGoods.h
//  TTmall
//
//  Created by wangyuanfei on 3/13/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ShopEditing ,
    AllEditing
} ShopingCellEditingStyle;

@interface SVCGoods : NSObject<NSCopying>
/** 购物车中这个商品收藏了多少个 */
@property(nonatomic,assign)NSInteger  number ;
/** 图片链接 */
@property(nonatomic,copy)NSString * img ;
///** 商品id */
//@property(nonatomic,assign)NSInteger  ID ;
/** 价格*/
@property(nonatomic,assign)CGFloat  price ;
/** 产品标题 */
@property(nonatomic,copy)NSString * title ;
/** 对应账号的member_ID */
@property(nonatomic,assign)NSInteger  member_id ;
/** 商品规格(颜色'尺寸) */
@property(nonatomic,copy)NSString * spec ;
/** 当前商品对应的店铺id */
@property(nonatomic,assign)NSInteger  shop_id ;
/** 商品id */
@property(nonatomic,assign)NSInteger  goods_id ;

/** 商品收藏列表中商品的id  (区别于goods_id) 取消商品收藏时给字段goods_id传的是这个值 */
@property(nonatomic,assign)NSInteger  goodsid ;
/** 创建时间(类型暂定为字符串) */
@property(nonatomic,copy)NSString * create_at ;
-(instancetype)initWithDict:(NSDictionary *)dict;

/////////////////////////////////////////

@property(nonatomic,copy)NSString * productSizeOrColor ;
@property(nonatomic,strong)NSIndexPath * currentGoodsIndexPath ;
@property(nonatomic,assign)BOOL  goodsSelect ;
@property(nonatomic,assign)BOOL  showTicket ;
@property(nonatomic,assign)BOOL  goodsEditing ;


@property(nonatomic,strong)NSArray * colors ;
@property(nonatomic,strong)UIColor * chooseColor ;
@property(nonatomic,strong)NSArray * sizes ;
@property(nonatomic,assign)CGFloat  chooseSize ;
@property(nonatomic,assign)NSInteger  storeCount ;
@property(nonatomic,strong)NSArray * productProperties ;
@property(nonatomic,assign) ShopingCellEditingStyle  shopingCellEditingStyle;
@end
