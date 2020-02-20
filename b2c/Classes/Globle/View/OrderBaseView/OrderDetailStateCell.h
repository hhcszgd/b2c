//
//  OrderDetailStateCell.h
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "BaseCell.h"

@interface OrderDetailStateCell : BaseCell
/**背景图片*/
@property (nonatomic, strong) UIImageView *backGroundImage;
/**状态label*/
@property (nonatomic, strong) UILabel *statusLabel;
/**退货的理由，以及退款的理由*/
@property (nonatomic, strong) UILabel *reasonLabel;
@end
