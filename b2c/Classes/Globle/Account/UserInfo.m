//
//  UserInfo.m
//  TTmall
//
//  Created by wangyuanfei on 16/1/7.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "UserInfo.h"
//#import "CellModel.h"

//#import "PersonalInfo.h"
#import "UserInfoViewModel.h"
@implementation UserInfo
static UserInfo * userInfo = nil;
//+(instancetype)shareUserInfo{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        userInfo = [[UserInfo alloc]init];
//    });
//    return userInfo;
//}



+(instancetype)shareUserInfo{
    if (userInfo==nil) {
        userInfo = [[UserInfo alloc]init];
    }

    return userInfo;

}

//-(PersonalInfo * )personalInfo{
//    if(_personalInfo==nil){
//        _personalInfo = [[PersonalInfo alloc]initWithDict:nil];
//    }
//    
//    return _personalInfo;
//}

//-(void)setupNetworkStatus
//{
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkingChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
////    
//    
//    
//    
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown:
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"UnknownNetworking")
//                break;
//                
//            case AFNetworkReachabilityStatusNotReachable:
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"disconnect")
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"mobileNet")
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"wifi")
//                break;
//            default:
//                break;
//        }
//    } ];
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//}

/**
-(void)setupNetworkStatus
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"UnknownNetworking")
                userInfo.networkingStatus = NETERROR;
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"disconnect")
                userInfo.networkingStatus = NETERROR;
                //            [self viewWhenNetWorkingError];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //            [self.viewWhenNetWorkingError removeFromSuperview];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"mobileNet")
                userInfo.networkingStatus = NETMOBILE;
                //            [self reloadWhenNecworkingReconnect];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //            [self.viewWhenNetWorkingError removeFromSuperview];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"wifi")
                userInfo.networkingStatus = NETWIFI;
                //            [self reloadWhenNecworkingReconnect];
                break;
            default:
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"sssssssss")
                break;
        }

    } ];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

}
-(void)netWorkingChangeWithStatus:(AFNetworkReachabilityStatus)status
{
    switch (status) {
        case AFNetworkReachabilityStatusUnknown:
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"UnknownNetworking")
            self.networkingStatus = NETERROR;
            break;
            
        case AFNetworkReachabilityStatusNotReachable:
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"disconnect")
            self.networkingStatus = NETERROR;
//            [self viewWhenNetWorkingError];
            
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
//            [self.viewWhenNetWorkingError removeFromSuperview];
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"mobileNet")
            self.networkingStatus = NETMOBILE;
            //            [self reloadWhenNecworkingReconnect];
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
//            [self.viewWhenNetWorkingError removeFromSuperview];
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"wifi")
            self.networkingStatus = NETWIFI;
            //            [self reloadWhenNecworkingReconnect];
            break;
        default:
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"sssssssss")
            break;
    }
}

*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////


-(void)initialization{
    UserInfo * temp = [UserInfo read];
    if (temp) {
        userInfo = temp;
        if (userInfo.isLogin) return;
    }
    [[UserInfoViewModel shareViewModel] initializationWithUser:self];
    
}
//-(void )initializationSuccess:(void(^)(id response))success failure:(void(^)(NSError*error))failure{
//
//    
//}



-(void)loginSuccess:(void (^)(ResponseStatus response))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel]  loginWithUser:self success:^(ResponseStatus response) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.loginSuccessBlack)
        if (self.loginSuccessBlack) {
            self.loginSuccessBlack();
        }


        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}



-(void)registerSuccess:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] registerWithUser:self Success:^(ResponseStatus response) {
       //注册成功的回调
        success(response);
    } failure:^(NSError *error) {
        //注册失败的回调
    }];

}
-(void)gotMobileCodeSuccess:(void (^)(ResponseStatus response))success failure:(void (^)(NSError *))failure{
    
    [[UserInfoViewModel shareViewModel] gotMobileCodeWithUser:self Success:^(ResponseStatus response) {
        success (response);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
-(void)addShopingCarWithGoods_id:(NSInteger)goods_id goodsNum:(NSInteger)num Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] addShopingCarWithUser:self goods_id:goods_id  goodsNum:num Success:^(ResponseStatus response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
-(void)gotShopingCarSuccess:(void (^)(ResponseStatus response))success failure:(void (^)(NSError *))failure{
    [[UserInfoViewModel shareViewModel] gotShopingCarWithUser:self success:^(ResponseStatus response) {
        
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

-(void)deleteShopingCarWithGoodsID:(NSInteger)goodsID success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure;{
    [[UserInfoViewModel shareViewModel] deleteShopingCarWithUser:self goodsID:goodsID success:^(ResponseStatus response) {

        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];


}

/** 添加商品收藏 */

-(void)addGoodsFavoriteWithGoods_id:(NSInteger)goods_id  Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] addGoodsFavoriteWithUser:self goods_id:goods_id  Success:^(ResponseStatus response) {
        if (response==POST_GOODS_COLLECT_SUCESS) {
            //添加购物车成功
        }
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/** 获取商品收藏 */
-(void)gotGoodsFavoriteSuccess:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotGoodsFavoriteWithUser:self success:^(ResponseStatus response) {
        
    } failure:^(NSError *error) {
        
    }];
}
/** 删除商品收藏 这个方法传的参数是SVCGoods的goodsid  不是goods_id */
-(void)deleteGoodsFavoriteWithGoodsID:(NSInteger)goodsID success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    

    [[UserInfoViewModel shareViewModel] deleteGoodsFavoriteWithUser:self goodsID:goodsID success:^(ResponseStatus response) {
        success(response);
        
    } failure:^(NSError *error) {
        
    }];

}
#pragma 店铺操作
-(void)addShopFavoriteWithShop_id:(NSInteger)shop_id   Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] addShopFavoriteWithUser:self shop_id:shop_id Success:^(ResponseStatus response) {
        success(response);
    } failure:^(NSError *error) {
        
    }];

}
-(void)gotShopFavoriteSuccess:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotShopFavoriteWithUser:self success:^(ResponseStatus response) {
        success(response);
    } failure:^(NSError *error) {
        
    }];
}

-(void)deleteShopFavoriteWithShop_id:(NSInteger)shop_id success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] deleteShopFavoriteWithUser:self shop_id:shop_id success:^(ResponseStatus response) {
        success(response);
    } failure:^(NSError *error) {
        
    }];
}

#pragma 获取分类列表
//-(void)gotclassifySuccess:(void (^)(ResponseStatus))success failure:(void (^)(NSError *))failure
-(void)gotClassifySuccess:(void(^)(ResponseObject* response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotClassifyWithUser:self success:^(ResponseObject* response) {
       success(response);
    } failure:^(NSError *error) {
        
    }];

}

-(void)uploadPictureWithPicData:(NSData*)picData success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] uploadPictureWithUser:self picData:nil success:^(ResponseStatus response) {
        
    } failure:^(NSError *error) {
        
    }];

}
//-(void)gotPersonalInfoSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{//获取个人信息,有点多余
//    [[UserInfoViewModel shareViewModel] gotPersonalInfWithUser:self success:^(id response) {
//        success(response);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.ID=[value integerValue];
        return;
    }
    if (value) [super setValue:value forKey:key];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

-(void)save {
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"userInfo.data"];
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}
+(instancetype )read{
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"userInfo.data"];
    UserInfo * newUserinfo = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return newUserinfo ;
}
+(void)deleteUserINfo
{

    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"userInfo.data"];
    
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isSuccess = [fileManager removeItemAtPath:path error:nil];
        if (isSuccess) {
            NSLog(@"delete success");
        }else{
            NSLog(@"delete fail");
        }
}
-(void)loginOut
{
    [UserInfo deleteUserINfo];
    self.token = nil ;
    self.member_id = 0 ;
//    userInfo=nil;
    self.name=nil;
    self.level=-1 ;
    
    
}
+ (NSArray *)mj_allowedCodingPropertyNames{
    return @[@"name",@"token",@"member_id",@"education",@"ID",@"nickname",@"password",@"saltcode",@"true_name",@"id_type",@"id_number",@"email",@"level",@"growth",@"integral",@"validity_start",@"head_images",@"mobile",@"telephone",@"telephone_ext",@"country",@"province",@"city",@"area",@"address",@"birthday",@"interested",@"marital_status",@"industry",@"company",@"department",@"position",@"earning",@"create_at",@"update_at",@"registration_ip",@"last_login_ip",@"last_login_time",@"balance",@"freeze",@"balancepwd",@"verified",@"bank_card",@"key",@"isLogin"] ;
    
}

#pragma NSCoping
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [self mj_encode:aCoder];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if (self) {
        [self mj_decode:aDecoder];
        
    }
    return self;
}

-(BOOL)isLogin{
    if (userInfo.token.length==32&&userInfo.member_id>0) {
        return YES;
    }else{
        return NO;
    }
}
-(void)setShoppingCarData:(NSMutableArray *)shoppingCarData{
    _shoppingCarData = shoppingCarData;
    
    if ([self.delegate respondsToSelector:@selector(reloadShoppingCarData)]) {
        [self.delegate reloadShoppingCarData];
    }

}

////////////////////////////////以下方法直接返回网络数据/////////////////////////////////////
-(void)gotProfileDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotProfileDataWithUser:self success:^(ResponseObject * responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)gotHomeDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotHomeDataWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

-(void)gotGuessLikeDataSuccess:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    [[UserInfoViewModel shareViewModel] gotGuessLikeDataWithUser:self success:^(ResponseObject *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
@end
