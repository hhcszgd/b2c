//
//  UserInfoViewModel.h
//  TTmall
//
//  Created by wangyuanfei on 3/2/16.
//  Copyright © 2016 Footway tech. All rights reserved.
/**
 用户模型的ViewModel
 */

#import <Foundation/Foundation.h>
@class UserInfo;
@interface UserInfoViewModel : NSObject
@property(nonatomic,strong)UserInfo * userInfo ;


/** 初始化方法 */
+(instancetype)shareViewModel;
-(void)initializationWithUser:(UserInfo*)user ;
-(void)initializationWithUser:(UserInfo*)user  success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
-(void)loginWithUser:(UserInfo*)user success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
-(void)gotPersonalInfWithUser:(UserInfo*)user success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
-(void)registerWithUser:(UserInfo*)user Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
-(void)gotMobileCodeWithUser:(UserInfo*)user Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;

-(void)gotClassifyWithUser :(UserInfo*)user success:(void(^)(ResponseObject* response))success failure:(void(^)(NSError*error))failure;

#pragma 购物车操作

-(void)addShopingCarWithUser:(UserInfo*)user goods_id:(NSInteger)goods_id goodsNum:(NSInteger)num  Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
-(void)gotShopingCarWithUser:(UserInfo*)user  success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;

-(void)deleteShopingCarWithUser:(UserInfo*)user  goodsID:(NSInteger)goodsID success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;


#pragma 商品收藏操作

-(void)addGoodsFavoriteWithUser:(UserInfo*)user goods_id:(NSInteger)goods_id   Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
-(void)gotGoodsFavoriteWithUser:(UserInfo*)user  success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;

-(void)deleteGoodsFavoriteWithUser:(UserInfo*)user  goodsID:(NSInteger)goodsID success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;

#pragma 店铺收藏操作

-(void)addShopFavoriteWithUser:(UserInfo*)user shop_id:(NSInteger)shop_id   Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
-(void)gotShopFavoriteWithUser:(UserInfo*)user  success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;

-(void)deleteShopFavoriteWithUser:(UserInfo*)user  shop_id:(NSInteger)shop_id success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;

#pragma 上传图像
-(void)uploadPictureWithUser:(UserInfo *)user picData:(NSData*)picData success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////一下方法直返回网络获取的数据//////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)gotProfileDataWithUser:(UserInfo*)user success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure;
-(void)gotHomeDataWithUser:(UserInfo*)user success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure;
-(void)gotGuessLikeDataWithUser:(UserInfo*)user success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure;
@end
