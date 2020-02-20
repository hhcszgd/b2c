//
//  UserInfoViewModel.m
//  TTmall
//
//  Created by wangyuanfei on 3/2/16.
//  Copyright © 2016 Footway tech. All rights reserved.
/**
    记得增加判断返回的data字段为空或者类型不匹配的情况
 
 */

#import "UserInfoViewModel.h"
#import "UserInfo.h"
//#import "HomeHttpTool.h"

typedef enum : NSUInteger {
    POST,
    GET
} ActionType;

@interface UserInfoViewModel ()
@property(nonatomic,strong)  AFHTTPSessionManager*mar ;
@end
@implementation UserInfoViewModel

static UserInfoViewModel * _viewModel;


//////////////////////////////////////////////////////////////////////////
+(instancetype)shareViewModel{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _viewModel = [[UserInfoViewModel alloc]init];
    });
    return _viewModel;
}

-(AFHTTPSessionManager * )mar{
    if(_mar==nil){
//        _mar = [AFHTTPSessionManager manager];
        
        NSURL * baseUrl = [NSURL URLWithString:BASEURL];
        _mar = [[AFHTTPSessionManager alloc]initWithBaseURL:baseUrl];
        [_mar.requestSerializer setValue:@"2" forHTTPHeaderField:@"APPID"];
        [_mar.requestSerializer setValue:@"1" forHTTPHeaderField:@"VERSIONID"];
        [_mar.requestSerializer setValue:@"20160501" forHTTPHeaderField:@"VERSIONMINI"];
        [_mar.requestSerializer setValue:UUID forHTTPHeaderField:@"DID"];
        _mar.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    }
    return _mar;
}
-(void)initializationWithUser:(UserInfo *)user {
    NSString * url = @"index.php?m=Api&c=InitKey&a=rest";
    
    [self remoteLoadDataWithUrl:url Parameters:nil actionType:GET success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        if (response.status==GET_INIT_GETKEY_SUCESS) {
            NSString * result =   [UUID  stringByAppendingString:response.data];
            result = [result md5String];
            user.token=result;
            LOG(@"_%@_%d_生成token成功%@",[self class] , __LINE__,result)
        }

    } failure:^(NSError *error) {
        LOG(@"_%@_%d_initializationWithUser%@",[self class] , __LINE__,error)
    }];
    

    
}

-(void)registerWithUser:(UserInfo*)user Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    
    
    
    
    
    
    NSDictionary * parameters = @{
                   @"token":user.token,
                   @"name": user.name,
                   @"password": user.password,
                   @"mobilecode":user.mobileCode,
                   @"mobile":user.mobile
                    };
    NSString *url  =  @"index.php?m=Api&c=Register&a=rest";
    
    
    [self remoteLoadDataWithUrl:url Parameters:parameters actionType:POST success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        success(response.status);
    } failure:^(NSError *error) {
        failure(error);
    }];
    

    
}
-(void)gotMobileCodeWithUser:(UserInfo*)user Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    [self initializationWithUser:user success:^(ResponseStatus response) {
        
        
        
        NSDictionary * parameters = @{
                               @"token":user.token,
                               @"mobile":user.mobile,
                               @"type":@1//1注册2找回密码
                               };
        
        NSString * url = @"index.php?m=Api&c=ShortMessage&a=rest";
        
        [self remoteLoadDataWithUrl:url Parameters:parameters actionType:POST success:^(ResponseObject *response) {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
            success(response.status);
        } failure:^(NSError *error) {
            failure(error);
        }];

        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)initializationWithUser:(UserInfo*)user  success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    
    NSString * url  = @"index.php?m=Api&c=InitKey&a=rest"  ;
    
    [self remoteLoadDataWithUrl:url Parameters:nil actionType:GET success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        if (response.status==GET_INIT_GETKEY_SUCESS) {
            NSString * result =   [UUID  stringByAppendingString:response.data];
            result = [result md5String];
            user.token=result;
            success(response.status);
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,[NSString stringWithFormat:@"初始化成功%@",result])
            
        }
    } failure:^(NSError *error) {
        failure(error);
        LOG(@"_%@_%d_%@",[self class] , __LINE__,[NSString stringWithFormat: @"初始化失败%@",error])
    }];
    


}
-(void)loginWithUser:(UserInfo *)user success:(void (^)(ResponseStatus response))success failure:(void (^)(NSError *))failure{//这个成功回调值有两种可能
    
    
    [self initializationWithUser:user success:^(ResponseStatus response) {
        NSDictionary * parameters = @{
                               @"token":user.token,
                               @"username": user.name,
                               @"password": user.password
                               };
        NSString * url =   @"index.php?m=Api&c=Login&a=rest";
        
        [self remoteLoadDataWithUrl:url Parameters:parameters actionType:POST success:^(ResponseObject *response) {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
            if (response.status==LOGIN_SUCCESS ) {
                NSString * result =  response.data;
                user.member_id = [result integerValue];
                [self gotPersonalInfWithUser:user success:^(ResponseStatus response) {
                    
                } failure:^(NSError *error) {
                    failure(error);
                }];
                [self gotShopingCarWithUser:user success:^(ResponseStatus response) {
                    
                } failure:^(NSError *error) {
                     failure(error);
                }];
            }
            success(response.status);//登录成功回调
        } failure:^(NSError *error) {
              failure(error);
        }];
        
        

    } failure:^(NSError *error) {
        failure(error);
    }];
    
    

    
}

-(void)gotPersonalInfWithUser:(UserInfo *)user success:(void (^)(ResponseStatus response))success failure:(void (^)(NSError *))failure{
    
    
    NSDictionary * parameters = @{
                           @"token":user.token,
                           @"member_id":@(user.member_id)
                           };
    NSString * url =  @"index.php?m=Api&c=UserInfo&a=rest";
    
    [self remoteLoadDataWithUrl:url Parameters:parameters actionType:GET success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        if (response.status==GET_USERINFO_SUCESS) {
            NSArray * arr = response.data;
            NSDictionary * result = arr.firstObject;
            [user setValuesForKeysWithDictionary:result];
            [user save];
        }
        success(response.status);
    } failure:^(NSError *error) {
        failure(error);
    }];

    
}

#pragma 购物车操作

-(void)addShopingCarWithUser:(UserInfo*)user goods_id:(NSInteger)goods_id goodsNum:(NSInteger)num  Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{

    
        NSDictionary * parameters = @{
                               @"token":user.token,
                               @"member_id":@(user.member_id),
                               @"goods_id":@(goods_id),
                               @"num":@(num)
                               };
        NSString*url =  @"index.php?m=Api&c=ShopCart&a=rest";
    [self remoteLoadDataWithUrl:url Parameters:parameters actionType:POST success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        if (response.status==POST_SHOPCAR_ADD_SUCESS) {
            [self gotShopingCarWithUser:user success:^(ResponseStatus response) {//重新获取一下购物车数据
            } failure:^(NSError *error) {
            }];
        }
        success(response.status);
    } failure:^(NSError *error) {
        failure(error);
    }];
    


}
-(void)gotShopingCarWithUser:(UserInfo*)user  success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    NSDictionary * parameters = @{
                           @"token":user.token,
                           @"member_id":@(user.member_id)
                           };
    
    NSString * url = @"index.php?m=Api&c=ShopCart&a=rest" ;
    [self remoteLoadDataWithUrl:url Parameters:parameters actionType:GET success:^(ResponseObject *response) {
        //获取购物车商品信息
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        if (response.status > 0 &&response.data!=nil && [response.data isKindOfClass:[NSDictionary class]]) {
            id goodsnumObject =response.data[@"goodsnum"];
            if ([goodsnumObject isKindOfClass:[NSNumber class]]) {
               user.shoppingCarGoodsCount = [goodsnumObject integerValue];
            }
            
            NSMutableArray * shopS = [NSMutableArray array];
            
            for (int i = 0 ;  i< [response.data[@"list"] count]; i++) {
                NSDictionary * shopDict = response.data[@"list"][i];
                SVCShop * shopModel =  [[SVCShop alloc] initWithDict:shopDict];
                NSMutableArray * goodses = [NSMutableArray array];
                for (int j  = 0 ;  j <shopModel.list.count ;  j ++) {
                    NSDictionary * goodsDict = shopModel.list[j];
                    SVCGoods * goods =    [[SVCGoods alloc]initWithDict:goodsDict];
                    [goodses  addObject:goods];
                }
                shopModel.list = goodses;
                [shopS addObject:shopModel];
            }
            user.shoppingCarData=shopS;
        }
        
        success(response.status);//再在tableView的控制器判断状态码 做出相应的操作   成功的话刷新tableView

    } failure:^(NSError *error) {
        failure(error);
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
    }];
    
    

}



-(void)deleteShopingCarWithUser:(UserInfo *)user goodsID:(NSInteger)goodsID success:(void (^)(ResponseStatus response))success failure:(void (^)(NSError *))failure{
    
    NSDictionary * parameters = @{
                           @"token":user.token,
                           @"member_id":@(user.member_id),
                           @"_method":@"delete",
                           @"goods_id":@(goodsID)
                           };
    NSString * url = @"index.php?m=Api&c=ShopCart&a=rest" ;
    
    [self remoteLoadDataWithUrl:url Parameters:parameters actionType:POST success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        if (response.status==DELE_SHOPCAR_SUCESS) {
            //删除成功
            [self gotShopingCarWithUser:user success:^(ResponseStatus response) {
            } failure:^(NSError *error) {
            }];
        }
        success(response.status);
    } failure:^(NSError *error) {
        failure(error);
    }];


}

#pragma 商品收藏操作
-(void)addGoodsFavoriteWithUser:(UserInfo*)user goods_id:(NSInteger)goods_id   Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{

    NSDictionary * parameters = @{
                           @"token":user.token,
                           @"member_id":@(user.member_id),
                           @"goods_id":@(goods_id)
                           };
    NSString * url = @"index.php?m=Api&c=GoodsCollect&a=rest"  ;
    [self remoteLoadDataWithUrl:url Parameters:parameters actionType:POST success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        if (response.status==POST_GOODS_COLLECT_SUCESS) {
            //收藏成功

        }
        success(response.status);

    } failure:^(NSError *error) {
        failure(error);
    }];

    
}
-(void)gotGoodsFavoriteWithUser:(UserInfo*)user  success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    NSDictionary * parameters = @{
                           @"token":user.token,
                           @"member_id":@(user.member_id)
                           };
    NSString*url =  @"index.php?m=Api&c=GoodsCollect&a=rest"  ;
    [self remoteLoadDataWithUrl:url Parameters:parameters actionType:GET success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        if (response.status==GET_GOODS_COLLECT_SUCESS) {
            //获取成功
        }
        success(response.status);
    } failure:^(NSError *error) {
        failure(error);
    }];
    

    
}

-(void)deleteGoodsFavoriteWithUser:(UserInfo*)user  goodsID:(NSInteger)goodsID success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    NSDictionary * parameters = @{
                           @"token":user.token,
                           @"member_id":@(user.member_id),
                           @"_method":@"delete",
                           @"goods_id":@(goodsID)
                           };
    NSString* url =   @"index.php?m=Api&c=GoodsCollect&a=rest" ;
    [self remoteLoadDataWithUrl:url Parameters:parameters actionType:POST success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        if (response.status==DELETE_GOODS_COLLECT_SUCESS) {
            //删除成功
        }
        success(response.status);
    } failure:^(NSError *error) {
        failure(error);
    }];

    
}
#pragma 店铺收藏操作

-(void)addShopFavoriteWithUser:(UserInfo*)user shop_id:(NSInteger)shop_id   Success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    NSDictionary * parameters = @{
                           @"token":user.token,
                           @"member_id":@(user.member_id),
                           @"shop_id":@(shop_id)
                           };
    
    NSString*url = @"index.php?m=Api&c=ShopCollect&a=rest"   ;
    
    [self remoteLoadDataWithUrl:url Parameters:parameters actionType:POST success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        success(response.status);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    

    

}
-(void)gotShopFavoriteWithUser:(UserInfo*)user  success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    NSDictionary * parameters = @{
                           @"token":user.token,
                           @"member_id":@(user.member_id)
                           };
    NSString * url = @"index.php?m=Api&c=ShopCollect&a=rest" ;
    [self remoteLoadDataWithUrl:url Parameters:parameters actionType:GET success:^(ResponseObject *response) {
//       LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        success(response.status);
    } failure:^(NSError *error) {
        failure(error);
    }];

    
}

-(void)deleteShopFavoriteWithUser:(UserInfo*)user  shop_id:(NSInteger)shop_id success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    NSDictionary * parameters = @{
                           @"token":user.token,
                           @"member_id":@(user.member_id),
                           @"shop_id":@(shop_id),
                           @"_method":@"delete"
                           };
    NSString * url = @"index.php?m=Api&c=ShopCollect&a=rest";
    [self remoteLoadDataWithUrl:url Parameters:parameters actionType:POST success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        success(response.status);
    } failure:^(NSError *error) {
        failure(error);
    }];
    

    
}

#pragma 获取所有分类
-(void)gotClassifyWithUser :(UserInfo*)user success:(void(^)(ResponseObject * response))success failure:(void(^)(NSError*error))failure{
    NSDictionary * Parameters = @{
                           @"token":user.token
                           };
    NSString * url =@"index.php?m=Api&c=GoodsClassfyTree&a=rest";

    [self remoteLoadDataWithUrl:url Parameters:Parameters actionType:GET success:^(ResponseObject *response) {
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.data)
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
        if (response.status==GET_CLASSIFY_TREE_SUCESS) {
            //存储分类并转模型TODO
        }
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    

}

#pragma 上传图像
-(void)uploadPictureWithUser:(UserInfo *)user picData:(NSData*)picData success:(void(^)(ResponseStatus response))success failure:(void(^)(NSError*error))failure{
    NSDictionary * parameters = @{
                           @"token":user.token,
                           @"member_id":@(user.member_id)
                           };

    [self.mar POST:@"index.php?m=Api&c=HeadImg&a=rest" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *img = [UIImage imageNamed:@"meinv08"];
        NSData * data =     UIImagePNGRepresentation(img);
        [formData appendPartWithFileData:data name:@"images" fileName:@"head_images.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        LOG(@"_%@_%d_%lld,%lld",[self class] , __LINE__,uploadProgress.completedUnitCount,uploadProgress.totalUnitCount)
        LOG(@"_%@_%d_%@",[self class] , __LINE__,uploadProgress)
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject)
        LOG(@"_%@_%d_%@",[self class] , __LINE__,task)
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
    }];



}


-(void)remoteLoadDataWithUrl:(NSString*)url Parameters:(id)parameters actionType:(ActionType)type success:(void(^)(ResponseObject* response))success failure:(void(^)(NSError*error))failure{
    
    if ([UserInfo shareUserInfo].token) {
        
    }else{
    
    }
    
    
    

    if (type==POST) {
        [self.mar POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject)
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                ResponseObject * response = [[ResponseObject alloc]initWithDict:responseObject];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
                success(response);
            }else if ([responseObject isKindOfClass:[NSArray class]]){
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"返回数据为arr ")
            }else{
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"返回数据非arr & Dic")
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        }];
    }else if (type==GET){
    
        [self.mar GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject)
                ResponseObject * response = [[ResponseObject alloc]initWithDict:responseObject];
                LOG(@"_%@_%d_%@",[self class] , __LINE__,response.msg)
                success(response);
            }else if ([responseObject isKindOfClass:[NSArray class]]){
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"返回数据为arr ")
            }else{
                LOG(@"_%@_%d_%@",[self class] , __LINE__,@"返回数据非arr & Dic")
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
            LOG(@"_%@_%d_%@",[self class] , __LINE__,error.userInfo[@"NSLocalizedDescription"])
        }];
    }
    
        

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////一下方法直返回网络获取的数据//////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)gotProfileDataWithUser:(UserInfo*)user success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    NSDictionary * parameters = @{
                                  @"token":user.token,
                                  @"member_id":@(user.member_id)
                                  };
    NSString * url = @"index.php?&m=Api&c=V2/MyPage&a=rest";
    
    [self remoteLoadDataWithUrl:url Parameters:parameters actionType:GET success:^(ResponseObject *response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
    
//    [self.mar GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        success(responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failure(error);
//    }];

}
-(void)gotHomeDataWithUser:(UserInfo*)user success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    
    if (user.token) {//正常加载
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,user.token)
        NSDictionary * parameters = @{
                                        @"token":user.token
                                        };
        NSString * url = @"index.php?&m=Api&c=V2/IndexPage&a=rest";
        
        [self remoteLoadDataWithUrl:url Parameters:parameters actionType:GET success:^(ResponseObject *response) {
            success(response);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }else{//先初始化 再加载
        [self initializationWithUser:user success:^(ResponseStatus response) {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,user.token)
            NSDictionary * parameters = @{
                                            @"token":user.token
                                            };
            NSString * url = @"index.php?&m=Api&c=V2/IndexPage&a=rest";
            
            [self remoteLoadDataWithUrl:url Parameters:parameters actionType:GET success:^(ResponseObject *response) {
                success(response);
            } failure:^(NSError *error) {
                failure(error);
            }];
        } failure:^(NSError *error) {
            
        }];
    }

}

/**
 GET: http://www.zjlao.com/index.php?m=Api&c=V2/GuessLike&a=rest   
 */
-(void)gotGuessLikeDataWithUser:(UserInfo*)user success:(void(^)(ResponseObject * responseObject))success failure:(void(^)(NSError*error))failure{
    if (user.token) {//正常加载
        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,user.token)
        NSDictionary * parameters = @{
                                      @"token":user.token
                                      };
        NSString * url = @"index.php?m=Api&c=V2/GuessLike&a=rest";
        
        [self remoteLoadDataWithUrl:url Parameters:parameters actionType:GET success:^(ResponseObject *response) {
            success(response);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }else{//先初始化 再加载
        [self initializationWithUser:user success:^(ResponseStatus response) {
            //            LOG(@"_%@_%d_%@",[self class] , __LINE__,user.token)
            NSDictionary * parameters = @{
                                          @"token":user.token
                                          };
            NSString * url = @"index.php?m=Api&c=V2/GuessLike&a=rest";
            
            [self remoteLoadDataWithUrl:url Parameters:parameters actionType:GET success:^(ResponseObject *response) {
                success(response);
            } failure:^(NSError *error) {
                failure(error);
            }];
        } failure:^(NSError *error) {
            
        }];
    }
    
}

@end
