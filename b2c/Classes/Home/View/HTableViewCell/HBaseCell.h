//
//  HBaseCell.h
//  b2c
//
//  Created by wangyuanfei on 4/11/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**
    首页cell的基类
 */

#import "BaseCell.h"
#import "HCellComposeModel.h"
#import "HCellModel.h"
//@class HCellModel;
@interface HBaseCell : BaseCell
@property(nonatomic,strong)HCellModel * cellModel ;
@end
