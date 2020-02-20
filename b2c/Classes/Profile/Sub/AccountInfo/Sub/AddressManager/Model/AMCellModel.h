//
//  AMCellModel.h
//  TTmall
//
//  Created by wangyuanfei on 3/3/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMCellModel : NSObject
/** 收货人姓名 */
@property(nonatomic,copy)NSString * name ;
/** 收货人电话 */
@property(nonatomic,copy)NSString * phoneNumber ;
/** 全地址 */
@property(nonatomic,copy)NSString * totalAddress ;
/** 省 */
@property(nonatomic,copy)NSString * province ;
/** 市 */
@property(nonatomic,copy)NSString * city ;
/** 区  当选择了地区以后自动加载邮编*/
@property(nonatomic,copy)NSString * area ;

/** 街道 (取消街道)*/
//@property(nonatomic,copy)NSString * street ;
/** 具体地址 */
@property(nonatomic,copy)NSString * detailAddress ;
/** 是否设置为默认 */
@property(nonatomic,assign) BOOL isDefaultAddress  ;
/** 邮编 */
@property(nonatomic,copy)NSString * postalCode ;

//@property(nonatomic,copy)NSString * name ;
//
//@property(nonatomic,copy)NSString * name ;
//
//@property(nonatomic,copy)NSString * name ;
//
//@property(nonatomic,copy)NSString * name ;
-(instancetype)initWithdictionary:(NSDictionary*)dict;
@end
