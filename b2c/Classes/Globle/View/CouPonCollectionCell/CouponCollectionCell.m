//
//  CouponCollectionCell.m
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CouponCollectionCell.h"
@interface CouponCollectionCell()
/**优惠券图片*/
@property (nonatomic, strong) UIImageView *couponImage;
@end
@implementation CouponCollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentUI];
    }
    return self;
}
- (UIImageView *)couponImage{
    if (_couponImage == nil) {
        _couponImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_couponImage];
    }
    return _couponImage;
}


- (void)configmentUI{
    [self.couponImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
}
- (void)setModel:(id)model{
    self.couponImage.image = [UIImage imageNamed:@"zhekouqu"];
}
@end
