//
//  HBabyGirlHeader.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HBabyGirlHeader.h"

@interface HBabyGirlHeader()
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation HBabyGirlHeader
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIPageControl *)page{
    if (_page == nil) {
        
    }
    return _page;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
        }];
        _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [self addSubview:_page];
#pragma mark -- 设置page
        [_page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-20);
            make.width.equalTo(@(60));
            make.height.equalTo(@(30));
        }];
        _page.backgroundColor = [UIColor redColor];
        _page.numberOfPages = 2;
        _page.currentPageIndicatorTintColor = [UIColor redColor];
        _page.pageIndicatorTintColor = [UIColor blackColor];

    }
    return self;
}


- (void)setTitle:(NSString *)title{
    [self.titleLabel configmentfont:[UIFont boldSystemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:title];
}
@end
