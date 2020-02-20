//
//  GuessYouLikeHeader.m
//  b2c
//
//  Created by 0 on 16/4/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GuessYouLikeHeader.h"

@implementation GuessYouLikeHeader
- (UIImageView *)guessImageView{
    if (_guessImageView == nil) {
        _guessImageView = [[UIImageView alloc] init];
        [self addSubview:_guessImageView];
    }
    return _guessImageView;
}
- (UILabel *)guessLabel{
    if (_guessLabel == nil) {
        _guessLabel = [[UILabel alloc] init];
        [self addSubview:_guessLabel];
    }
    return _guessLabel;
}
- (UIView *)rightLineView{
    if (_rightLineView == nil) {
        _rightLineView = [[UIView alloc] init];
        [self addSubview:_rightLineView];
    }
    return _rightLineView;
}
- (UIView *)leftLineView{
    if (_leftLineView == nil) {
        _leftLineView= [[UIView alloc] init];
        [self addSubview:_leftLineView];
    }
    return _leftLineView;
}




- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.guessImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self).offset(-30);
            make.height.equalTo(@(20));
             make.width.equalTo(@(20));
        }];
        
        self.guessImageView.image = [UIImage imageNamed:@"collect_item_selected"];
        [self.guessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.guessImageView.mas_right).offset(5);
        }];
        [self.guessLabel sizeToFit];
        [self.guessLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"猜你喜欢"];
        [self.rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.equalTo(@(1));
            make.left.equalTo(self.guessLabel.mas_right).offset(5);
            make.right.equalTo(self).offset(-5);
        }];
        self.rightLineView.backgroundColor = [UIColor blackColor];
        [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.guessImageView.mas_left).offset(-5);
            make.left.equalTo(self).offset(5);
            make.height.equalTo(@(1));
        }];
        [self.leftLineView setBackgroundColor:[UIColor blackColor]];
        
    }
    return self;
}



@end
