//
//  POrderCellComposeModel.h
//  b2c
//
//  Created by wangyuanfei on 4/8/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface POrderCellComposeModel : BaseModel
@property(nonatomic,strong)UIImage * topImage ;
@property(nonatomic,copy)NSString * botomTitle ;
@property(nonatomic,assign)NSInteger  cornerCount ;
@end
