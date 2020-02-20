//
//  HStoryCell.m
//  b2c
//
//  Created by wangyuanfei on 4/11/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HStoryCell.h"

@implementation HStoryCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setCellModel:(HCellModel *)cellModel{
    [super setCellModel:cellModel];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items)
}
@end
