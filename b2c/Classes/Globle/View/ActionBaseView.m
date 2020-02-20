//
//  ActionBaseView.m
//  b2c
//
//  Created by wangyuanfei on 3/25/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ActionBaseView.h"

@interface ActionBaseView()
@property(nonatomic,weak)UILabel * titleLabel ;
@property(nonatomic,weak)UIImageView * imgView ;
@end

@implementation ActionBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
    }
    return self;
}




/**
 //添加监听者
 [self.tableView addObserver: self forKeyPath: @"contentOffset" options: NSKeyValueObservingOptionNew context: nil];
 
// 监听属性值发生改变时回调

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat offset = self.tableView.contentOffset.y;
    CGFloat delta = offset / 64.f + 1.f;
    delta = MAX(0, delta);
    [self alphaNavController].barAlpha = MIN(1, delta);
}
 */
-(UIImageView * )backImg{
    if(_backImg==nil){
        UIImageView * backImg =  [[UIImageView alloc]init];
        _backImg = backImg;
        backImg.frame = self.bounds;
        [self addSubview:backImg];
    }
    return _backImg;
}

-(UILabel * )titleLabel{
    if(_titleLabel==nil && _title){
        UILabel * titleLabel = [[UILabel alloc]init];
        _titleLabel = titleLabel;
        titleLabel.textAlignment=NSTextAlignmentCenter;
        
        [self addSubview:titleLabel];
    }
    return _titleLabel;
}

-(UIImageView * )imgView{
    if(_imgView==nil && _img){
        UIImageView * imgView= [[UIImageView alloc]init];
        [self addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.subviews.count>2) {
        
    }else{
        if (self.titleLabel) {
            self.titleLabel.frame = self.bounds;
        }
        if (self.imgView) {
            self.imgView.frame = self.bounds;
        }
    }
    
    
    

}
//-(void)setTitle:(NSString *)title{
//    _title = title;
//    self.titleLabel.text = title;
//}
-(void)setImg:(UIImage *)img{
    _img = img;
    self.imgView.image = img;

}

-(void)setModel:(BaseModel *)model{
    _model = model;
    self.title = model.title;



}
@end