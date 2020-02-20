//
//  HFocusCollectiontCell.m
//  b2c
//
//  Created by wangyuanfei on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFocusCollectiontCell.h"
#import "HCellComposeModel.h"
@interface HFocusCollectiontCell()
@property(nonatomic,weak)ActionBaseView * image ;
@end


@implementation HFocusCollectiontCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        ActionBaseView * imgView = [[ActionBaseView alloc]init];
        self.image = imgView;
        [self.contentView  addSubview:self.image];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.image.frame = self.bounds;
    [self.image.backImg sd_setImageWithURL:[NSURL URLWithString:self.composeModel.imgStr]];
}

-(void)setComposeModel:(HCellComposeModel *)composeModel{
    _composeModel = composeModel;

    

}
@end
