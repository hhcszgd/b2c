//
//  HBBannerCell.m
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HBBannerCell.h"

@interface HBBannerCell()
@property (nonatomic, strong) CustomCollectionView *banner;
@end
@implementation HBBannerCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentUI];
    }
    return self;
}

- (void)configmentUI{
    CustomCollectionView *banner = [[CustomCollectionView alloc] initWithFrame:self.contentView.bounds withData:@[@"1",@"2",@"3"] pageIndicatorTintColor:[UIColor whiteColor] currentPageIndicatorTintColor:[UIColor purpleColor] bottom:10 right:0 width:100 height:30 on_off:YES];
    _banner = banner;
    [self.contentView addSubview:banner];
}

#pragma mark  赋值
- (void)setCollectionView:(UICollectionView *)collectionView{
    
}

- (void)setModel:(id)model{
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        CustomCollectionModel *model = [[CustomCollectionModel alloc] init];
        model.imageUrl = @"http://2t.5068.com/uploads/allimg/151106/48-151106145608-51.jpg";
        [array addObject:model];
    }
    _banner.dataArr = array;
    __weak typeof(self) Myself = self;
    _banner.customBlock = ^(id model){
        LOG(@"%@,%d,%@",[Myself class], __LINE__,model)
    };
}

@end
