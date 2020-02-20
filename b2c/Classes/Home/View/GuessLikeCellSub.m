//
//  GuessLikeCellSub.m
//  b2c
//
//  Created by wangyuanfei on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GuessLikeCellSub.h"
#import "HCellComposeModel.h"
@interface GuessLikeCellSub()
@property(nonatomic,weak)UILabel * descrip ;
@property(nonatomic,weak)UILabel * price ;
@property(nonatomic,weak)UILabel * ticket ;
@property(nonatomic,weak)UIButton * action ;
@property(nonatomic,weak)UIImageView * productImage ;
@property(nonatomic,weak)UIView * whiteLine ;

@end

@implementation GuessLikeCellSub

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        
        UILabel * descrip = [[UILabel alloc]init];
        [self addSubview:descrip];
        self.descrip=descrip;
        descrip.numberOfLines=2 ;
        //                descrip.backgroundColor=randomColor;
        
        UILabel * price = [[UILabel alloc]init];
        [self addSubview:price];
        self.price=price;
        price.textColor=[UIColor redColor];
        //                price.backgroundColor=randomColor;
        
        
        
        UIButton * action = [[UIButton alloc]init];
        [self addSubview:action];
        self.action=action;
        [action addTarget:self action:@selector(actionVWithSender:) forControlEvents:UIControlEventTouchUpInside];
        //                action.backgroundColor=randomColor;
        
        UIImageView * productImage = [[UIImageView alloc]init];
        [self addSubview:productImage];
        self.productImage=productImage;
        productImage.backgroundColor=randomColor;
        
        UIView *whiteLine  = [[UIView alloc]init];
        [self addSubview:whiteLine ];
        self.whiteLine =whiteLine ;
        whiteLine.backgroundColor=[UIColor whiteColor];
        
        
        UILabel * ticket = [[UILabel alloc]init];
        //        [ticket setAdjustsLetterSpacingToFitWidth: YES];
        [self addSubview:ticket];
        self.ticket=ticket;
        ticket.textColor = [UIColor whiteColor];
        //        ticket.alignmentRectInsets
        
        self.ticket.hidden=YES;
        
        ticket.backgroundColor=[UIColor colorWithRed:250/255.0 green:40/255.0 blue:40/255.0 alpha:0.7];
#pragma layout
        
        CGFloat lineH = 3 ;
        CGFloat composeW = (screenW - 3 )/2 ;
        CGFloat imageH = composeW;
        
        [productImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@(imageH));
        }];
        
        
        [descrip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(productImage).offset(10);
            make.top.equalTo(productImage.mas_bottom);
        }];
        descrip.text = @"dja;lskdhfolkajsdlhj[oaisdlkfjasdfaso;diyfpoaskjdf;lasjdkf";
        
        
        
        
        [whiteLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.height.equalTo(@(lineH));
        }];
        
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(descrip);
            make.top.equalTo(descrip.mas_bottom);
            make.right.equalTo(self);
            make.bottom.equalTo(whiteLine.mas_top);
        }];
        price.text = @"¥1211";
        
        [action mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
        
        
        [ticket mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(productImage);
            make.height.equalTo(@(30));
        }];
        ticket.text = @"  买一送一啊";
        
    }
    return self;
}
//TODO
-(void)layoutSubviews{
    
    
}

-(void)actionVWithSender:(UIButton * ) sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,[self class])
}

-(void)setComposeModel:(HCellComposeModel *)composeModel{
    _composeModel = composeModel ;
        self.descrip.text=composeModel.full_name;
        self.price.text = [NSString stringWithFormat:@"¥ %f", composeModel.price];
//        self.ticket.text = composeModel.ticket;
        //  model.action ;
        [self.productImage sd_setImageWithURL:ImageUrlWithString(composeModel.imgStr)];
//        if (composeModel.ticket) {
//    
//            self.ticket.hidden=NO;
//            self.ticket.text=composeModel.ticket;
//        }else{
//            self.ticket.hidden=YES;
//        }
}
//-(void)setModel:(NormalViewModel *)model{
//    _model = model;
//    self.descrip.text=model.descrip;
//    self.price.text = [NSString stringWithFormat:@"¥ %f", model.price];
//    self.ticket.text = model.ticket;
//    //  model.action ;
//    [self.productImage sd_setImageWithURL:ImageUrlWithString(model.imageUrlStr)];
//    if (model.ticket) {
//        
//        self.ticket.hidden=NO;
//        self.ticket.text=model.ticket;
//    }else{
//        self.ticket.hidden=YES;
//    }
//    
//}

@end
