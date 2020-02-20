//
//  BaseModel.h
//  b2c
//
//  Created by wangyuanfei on 3/29/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum : NSUInteger {
//    ActionShopCollection=0,
//    ActionGoodsCollection,
//    ActionAttentionBrand,
//    ActionFootHistory
//} ActionType;

@interface BaseModel : NSObject
//@property(nonatomic,assign)ActionType  actionType ;
@property(nonatomic,copy)NSString * actionKey ;
@property(nonatomic,copy)NSString * title ;
/** 是否需要判断是否登录 默认是NO */
@property(nonatomic,assign)BOOL  judge ;
@end
//个人中心数据
static  NSString * ActionGoodsCollect =@"ActionGoodsCollect";
static  NSString * ActionShopCollect = @"ActionShopCollect";
static  NSString * ActionAttentionBrand = @"ActionAttentionBrand";
static  NSString * ActionFootHistory =@"ActionFootHistory";
static  NSString * ActionMessageCenter = @"ActionMessageCenter";
static  NSString * ActionAccountInfo = @"ActionAccountInfo";
static  NSString * ActionTotalOrder = @"ActionTotalOrder";
static  NSString * ActionAssets = @"ActionAssets";
static  NSString * ActionMemberClub = @"ActionMemberClub";
static  NSString * ActionMyExercise = @"ActionMyExercise";
static  NSString * ActionHelpFeedBack = @"ActionHelpFeedBack";
static  NSString * ActionSetting = @"ActionSetting";
static  NSString * ActionPendingPay = @"ActionPendingPay";
static  NSString * ActionPendingSend = @"ActionPendingSend";
static  NSString * ActionPendingReceive = @"ActionPendingReceive";
static  NSString * ActionPendingAppraise = @"ActionPendingAppraise";
static  NSString * ActionAfterCost = @"ActionAfterCost";

static  NSString * ActionCoupon = @"ActionCoupon";
static  NSString * ActionBalance = @"ActionBalance";
static  NSString * ActionCardPackage = @"ActionCardPackage";
static  NSString * ActionLBi = @"ActionLBi";
static  NSString * ActionAccountSafe = @"ActionAccountSafe";
static  NSString * ActionChangePhoneNum = @"ActionChangePhoneNum";
static  NSString * ActionChangePassword = @"ActionChangePassword";
static  NSString * ActionHelpCenter   = @"ActionHelpCenter";

