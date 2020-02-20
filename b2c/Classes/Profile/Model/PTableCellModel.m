//
//  PTableCellModel.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PTableCellModel.h"

@implementation PTableCellModel
-(void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    self.title = leftTitle ; 

}
@end
