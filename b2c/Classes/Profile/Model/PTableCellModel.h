//
//  PTableCellModel.h
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseModel.h"

@interface PTableCellModel : BaseModel
@property(nonatomic,assign)BOOL arrowHidden ;

@property(nonatomic,strong)UIImage * leftImage ;
@property(nonatomic,copy)NSString * leftTitle ;
@property(nonatomic,copy)NSString * rightDetailTitle ;
@property(nonatomic,strong)UIImage * rightImage ;
@end
