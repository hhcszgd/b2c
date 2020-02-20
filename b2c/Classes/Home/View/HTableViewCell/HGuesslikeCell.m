//
//  HGuesslikeCell.m
//  b2c
//
//  Created by wangyuanfei on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGuesslikeCell.h"
#import "GuessLikeCellSub.h"
@interface HGuesslikeCell()
@property(nonatomic,strong)GuessLikeCellSub * contennerViewL ;
@property(nonatomic,strong)GuessLikeCellSub * contennerViewR ;

@end

@implementation HGuesslikeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutContennerView];

    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutContennerView
{
    
    CGFloat margin = 3 ;
    CGFloat conposeW = (screenW - margin )/2 ;
    GuessLikeCellSub * contennerViewL = [[GuessLikeCellSub alloc]init];
    self.contennerViewL = contennerViewL;
    //    self.contennerViewL.backgroundColor = randomColor;
    [self.contentView addSubview: self.contennerViewL];
    [self.contennerViewL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView);
        make.height.equalTo(@(screenW/1.5));
        make.width.equalTo(@(conposeW));
    }];
    //    [self.contennerViewL.btn setImage:[UIImage imageNamed:@"zuidapai_02"] forState:UIControlStateNormal];
    
    GuessLikeCellSub * contennerViewR = [[GuessLikeCellSub alloc]init];
    self.contennerViewR =contennerViewR;
    //    self.contennerViewR.backgroundColor = randomColor;
    [self.contentView addSubview: self.contennerViewR];
    [self.contennerViewR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contennerViewL.mas_right).offset(margin);
        make.top.equalTo(self.contennerViewL);
        make.height.equalTo(@(screenW/1.5));
        make.width.equalTo(@(conposeW));
    }];
    //    [self.contennerViewR.btn setImage:[UIImage imageNamed:@"zuidapai_02"] forState:UIControlStateNormal];
    
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contennerViewL);
        make.right.equalTo(self);
        make.left.equalTo(self);
    }];
}
-(void)setCellModel:(HCellModel *)cellModel{
    [super setCellModel:cellModel];
    self.contennerViewL.composeModel = [cellModel.items firstObject];
    self.contennerViewR.composeModel = [cellModel.items lastObject];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items)
}
@end
