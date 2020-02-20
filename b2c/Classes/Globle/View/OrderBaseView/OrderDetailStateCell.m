//
//  OrderDetailStateCell.m
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "OrderDetailStateCell.h"

@implementation OrderDetailStateCell


- (UIImageView *)backGroundImage{
    if (_backGroundImage == nil) {
        _backGroundImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_backGroundImage];
    }
    return _backGroundImage;
}
- (UILabel *)statusLabel{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_statusLabel];
    }
    return _statusLabel;
}

- (UILabel *)reasonLabel{
    if (_reasonLabel == nil) {
        _reasonLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_reasonLabel];
    }
    return _reasonLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.width.equalTo(@(screenW));
        }];
        [self.backGroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
            make.height.equalTo(@(80));
            
        }];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(30);
            
        }];
        [self.statusLabel sizeToFit];
        [self.reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statusLabel.mas_bottom).offset(0);
            make.left.equalTo(self.statusLabel.mas_left).offset(0);
            
        }];
        [self.reasonLabel sizeToFit];
    }
    return self;
}
@end
