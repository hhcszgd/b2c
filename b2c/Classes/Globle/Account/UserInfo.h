//
//  UserInfo.h
//  TTmall
//
//  Created by wangyuanfei on 16/1/7.
//  Copyright © 2016年 Footway tech. All rights reserved.
//
/**
 用户模型信息和相关获取个人相关信息的方法
 */
#import <Foundation/Foundation.h>
#import "ResponseObject.h"

typedef void(^CallBackBlock)();

//void(^loginSuccessBlock)() = ^() {
//    
//};


@protocol UserInfoDelete <NSObject>

-(void)reloadShoppingCarData;
-(void)whenNetWorkingError;
-(void)whenNetWorkingConnect;

@end

@class PersonalInfo;
@interface UserInfo : NSObject<NSCopying>
@property(nonatomic,weak)id  <UserInfoDelete> delegate ;
/** 自动增长 */
@property(nonatomic,assign)NSInteger  ID ;

/** 用户名 '*/
@property(nonatomic,copy)NSString * name ;
/** 性别 1.男,2.女,3.保密(默认)*/
@property(nonatomic,assign)NSInteger  sex ;
/** 昵称 */
@property(nonatomic,copy)NSString * nickname ;
/** 密码 */
@property(nonatomic,copy)NSString * password ;
/** 密码盐值 */
@property(nonatomic,copy)NSString * saltcode ;
/** 真实姓名 */
@property(nonatomic,copy)NSString * true_name ;
/** 证件类型 */
@property(nonatomic,assign)NSInteger  id_type ;
/** 证件号码 */
@property(nonatomic,copy)NSString * id_number ;
/** 电子邮件 */
@property(nonatomic,copy)NSString * email ;
/** 等级 */
@property(nonatomic,assign)NSInteger  level ;
/** 用户成长值(可提升会员等级level) */
@property(nonatomic,assign)NSInteger  growth ;
/** 用户积分(兑换L币) */
@property(nonatomic,assign)NSInteger  integral ;
/** 用户会员有效期初始时间 */
@property(nonatomic,strong)NSDate * validity_start ;
/** 用户头像 */
@property(nonatomic,copy)NSString * head_images ;
/** 手机号码 */
@property(nonatomic,copy)NSString * mobile  ;
/** 座机号码 */
@property(nonatomic,copy)NSString * telephone ;

/** 分机号码 */
@property(nonatomic,assign)NSInteger telephone_ext ;
/** 国家 */
@property(nonatomic,copy)NSString * country ;
/** 省份 */
@property(nonatomic,copy)NSString * province ;
/** 城市 */
@property(nonatomic,copy)NSString * city ;
/** 区/县 */
@property(nonatomic,copy)NSString * area ;
/** 具体地址 */
@property(nonatomic,copy)NSString * address ;
/** 生日 */
@property(nonatomic,strong)NSDate * birthday ;
/** 兴趣爱好 */
@property(nonatomic,copy)NSString * interested ;
/** 婚姻状况(默认是3保密 , 1 未婚, 2 ,已婚) */
@property(nonatomic,assign)NSInteger  marital_status ;
//@property(nonatomic,copy    )NSString * marital_status ;
/** 学历(1.小学，2.初中，3.高中或中专，4.大专，5.本科，6.研究生或硕士，7博士) */
@property(nonatomic,assign)NSInteger  education ;
/** 所属行业 */
@property(nonatomic,assign)NSInteger industry ;
/** 公司 */
@property(nonatomic,copy)NSString * company ;
/** 所属部门 */
@property(nonatomic,copy)NSString * department ;
/** 职位 */
@property(nonatomic,copy)NSString * position ;
/** 收入（1.2000~5000,2.5000~1万，3.1万以上） */
@property(nonatomic,assign)NSInteger earning ;
/** 会员状态 ,默认是1(1已激活，2锁定) */
@property(nonatomic,assign)NSInteger  status ;
/** 创建时间(服务器格式为timestamp时间戳也就是整形) */
@property(nonatomic,assign)NSInteger create_at ;
/** 最后一次修改时间数据格式同上 */
@property(nonatomic,assign)NSInteger  update_at ;
/** 注册时的ip地址 */
@property(nonatomic,copy)NSString * registration_ip ;
/** 最后一次登录的ip地址 */
@property(nonatomic,copy)NSString * last_login_ip ;
/** 最后一次登录时间 */
@property(nonatomic,assign)NSInteger last_login_time ;
/** 余额 */
@property(nonatomic,assign)NSInteger  balance ;
/** 冻结金额 */
@property(nonatomic,assign)NSInteger  freeze ;
/** 余额支付密码 */
@property(nonatomic,copy)NSString *  balancepwd ;
/** 是否实名认证（0、未认证，1、认证） */
@property(nonatomic,assign)NSInteger  verified ;
/** 银行卡号 */
@property(nonatomic,copy)NSString * bank_card ;
/** token */
@property(nonatomic,copy)NSString * token ;

/** key值 */
@property(nonatomic,copy)NSString * key ;

/** APPID */
@property(nonatomic,copy)NSString * APPID ;

/** VERSIONID */
@property(nonatomic,copy)NSString * VERSIONID ;

/** VERSIONMINI */
@property(nonatomic,copy)NSString * VERSIONMINI ;

/** DID */
@property(nonatomic,copy)NSString * DID ;

/** member_id */
@property(nonatomic,assign)NSInteger  member_id ;
/** 短信验证码 */
@property(nonatomic,copy)NSString * mobileCode ;
/** newpassword(修改密码时用)*/
@property(nonatomic,copy)NSString * newpassword ;
/** 用户注册时填写的手机号码 */
@property(nonatomic,copy)NSString * registerPhoneNumber ;

/** 用户是否登录 */
@property(nonatomic,assign,readonly)BOOL isLogin ;

/** 早起模拟购物车信息 */
//@property(nonatomic,strong)NSMutableArray * shoppingCarInfo ;
/** 最新网络获取购物车信息 */
@property(nonatomic,strong)NSMutableArray * shoppingCarData ;
/** 购物车商品总数 */
@property(nonatomic,assign)NSInteger  shoppingCarGoodsCount ;
@property(nonatomic,strong)PersonalInfo * personalInfo ;
//@property(nonatomic,strong)NSMutableArray * personalInfo ;
@property(nonatomic,copy)NSString * userName ;
@property(nonatomic,copy)NSString * urlStr ;

/** 登录成功回调 */
//@property(nonatomic,copy) CallBackBlock loginSuccessBlack ;
@property(nonatomic,copy)  void(^loginSuccessBlack)() ;
+(instancetype)shareUserInfo;
//-(void)loadUserInfo;

/** 用户信息初始化, 获取key值 */
-(void )initialization;
//-(void )initializationSuccess:(void(^)(id response))success failure:(void(^)(NSError*error))failure;//加个回调 , 获取key之后再执行登录
/** 登录 */
-(void)loginSuccess:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
/** 获取个人信息 */
-(void)gotPersonalInfoSuccess:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
/** 注册 */
-(void)registerSuccess:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
/** 个人信息归档 */

-(void)save ;
/** 个人信息解档 */
+(instancetype )read;
/** 删除归档信息 */
+(void)deleteUserINfo;
/** 退出登录 */
-(void)loginOut;
/** 获取验证码 */
-(void)gotMobileCodeSuccess:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
/** 添加购物车 */

-(void)addShopingCarWithGoods_id:(NSInteger)goods_id goodsNum:(NSInteger)num Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
/** 获取购物车数据 */
-(void)gotShopingCarSuccess:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
/** 删除购物车 */
-(void)deleteShopingCarWithGoodsID:(NSInteger)goodsID success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;;
/** 获取分类列表*/
-(void)gotClassifySuccess:(void(^)(ResponseObject* response))success failure:(void(^)(NSError*error))failure;


/** 添加商品收藏 */

-(void)addGoodsFavoriteWithGoods_id:(NSInteger)goods_id  Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
/** 获取商品收藏 */
-(void)gotGoodsFavoriteSuccess:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
/** 删除商品收藏 */
-(void)deleteGoodsFavoriteWithGoodsID:(NSInteger)goodsID success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;

#pragma 店铺操作
-(void)addShopFavoriteWithShop_id:(NSInteger)shop_id   Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;
-(void)gotShopFavoriteSuccess:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;

-(void)deleteShopFavoriteWithShop_id:(NSInteger)shop_id success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;

-(void)uploadPictureWithPicData:(NSData*)picData success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;

////////////////////////////////以下方法直接返回网络数据/////////////////////////////////////
-(void)gotProfileDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure;
-(void)gotHomeDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure;
-(void)gotGuessLikeDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure;
@end
