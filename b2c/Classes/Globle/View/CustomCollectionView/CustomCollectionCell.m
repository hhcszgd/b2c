//
//  CustomCollectionCell.m
//  TTmall
//
//  Created by 0 on 16/3/24.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "CustomCollectionCell.h"
#import "CustomCollectionModel.h"
@interface CustomCollectionCell()
/**展示图片*/
@property (nonatomic, strong) UIImageView *bannerImager;
@end
@implementation CustomCollectionCell
- (UIImageView *)bannerImager{
    if (_bannerImager == nil) {
        _bannerImager = [[UIImageView alloc] init];
        [self.contentView addSubview:_bannerImager];
    }
    return _bannerImager;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.bannerImager mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)setModel:(CustomCollectionModel *)model{
    
    [self.bannerImager sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
}
@end
