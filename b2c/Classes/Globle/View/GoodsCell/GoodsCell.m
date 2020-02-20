//
//  GoodsCell.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GoodsCell.h"

@implementation GoodsCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) Myself = self;
        //固定图片的高度
        
        UIImageView *imageView = [UIImageView new];
        _imageView = imageView;
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(Myself.contentView);
            make.height.equalTo(imageView.mas_width);
        }];
        //创建三个label
        //商品信息
        UILabel *textLabel = [UILabel new];
        textLabel.numberOfLines = 2;
        [textLabel sizeToFit];
        [self.contentView addSubview:textLabel];
        _textLabel = textLabel;
        
        //商品价格
        UILabel *priceLabel = [UILabel new];
        [self.contentView addSubview:priceLabel];
        [priceLabel sizeToFit];
        _priceLabel = priceLabel;
        
        //剩余的数量
        UILabel *countLable = [UILabel new];
        [self.contentView addSubview:countLable];
        [countLable sizeToFit];
        _coutnLabel = countLable;
        //选择按钮
        
       
        
        //布局控件
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(0);
            make.left.equalTo(Myself.contentView.mas_left).offset(0);
            make.right.equalTo(Myself.contentView.mas_right).offset(0);
            make.bottom.equalTo(priceLabel.mas_top).offset(0);
        }];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(textLabel.mas_bottom).offset(0);
            make.left.equalTo(Myself.contentView.mas_left).offset(0);
            make.bottom.equalTo(Myself.mas_bottom).offset(0);
            make.right.equalTo(countLable.mas_left).offset(0);
            make.width.equalTo(countLable);
        }];
        [countLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(textLabel.mas_bottom).offset(0);
            make.left.equalTo(priceLabel.mas_right).offset(0);
            make.bottom.equalTo(Myself.contentView.mas_bottom).offset(0);
            make.right.equalTo(Myself.contentView.mas_right).offset(0);
            
        }];
        
        
    }
    return self;
}







#pragma mark - 布局子控件
- (void)setImagestr:(NSString *)imagestr{
    self.imageView.image = [UIImage imageNamed:imagestr];
}
- (void)setPriceStr:(NSString *)priceStr{
    [_priceLabel configmentfont:[UIFont boldSystemFontOfSize:13] textColor:[UIColor redColor] backColor:[UIColor blackColor] textAligement:0 cornerRadius:0 text:priceStr];
}

- (void)setCountStr:(NSString *)countStr{
    
}
- (void)setTextStr:(NSString *)textStr{
    
}
- (void)setModel:(id)model{
    _imageView.image = [UIImage imageNamed:@"zhekouqu"];
    [_coutnLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:[NSString stringWithFormat:@"%@",@"12"] ];
    [_priceLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"$12.5"];
    [_textLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"真是难看到衣服,模特倒是很漂亮怎么着也给我找一个吧"];
    
    
}
- (void)setCollectionView:(UICollectionView *)collectionView{
    
}



@end
