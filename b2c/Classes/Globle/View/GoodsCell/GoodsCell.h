//
//  GoodsCell.h
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionViewCell+Extension.h"
@interface GoodsCell : UICollectionViewCell
@property (nonatomic, strong) NSString *imagestr;
@property (nonatomic, strong) NSString *priceStr;
@property (nonatomic, strong) NSString *countStr;
@property (nonatomic, strong) NSString *textStr;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *coutnLabel;


@end
