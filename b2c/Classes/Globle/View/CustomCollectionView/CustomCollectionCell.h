//
//  CustomCollectionCell.h
//  TTmall
//
//  Created by 0 on 16/3/24.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCollectionModel.h"
/**主要是为了展示没有图片的放大缩小功能*/
@interface CustomCollectionCell : UICollectionViewCell
@property (nonatomic, copy) CustomCollectionModel *model;
@end
