//
//  HBRecomentGoodShopCell.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HBRecomentGoodShopCell.h"
#import "HBRecommentGoodSubCell.h"

@interface HBRecomentGoodShopCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
/**布局类*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**滑动collectionview*/
@property (nonatomic, strong) UICollectionView *col;
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/***/
@property (nonatomic, strong) UIPageControl *page;
@end
@implementation HBRecomentGoodShopCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configmentUI];
    }
    return self;
}
/**懒加载*/
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0 , self.contentView.bounds.size.width, self.contentView.bounds.size.height- 20) collectionViewLayout:self.flowLayout];
        _col.delegate = self;
        _col.dataSource = self;
        [_col registerClass:[HBRecommentGoodSubCell class] forCellWithReuseIdentifier:@"HBRecommentGoodSubCell"];
        _col.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_col];
    }
    return _col;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UIPageControl *)page{
    if (_page == nil) {
        _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [self.contentView addSubview:_page];
    }
    return _page;
}
- (void)configmentUI{
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.col setShowsHorizontalScrollIndicator:NO];
    [self.col setShowsVerticalScrollIndicator:NO];
    [self.col setScrollEnabled:YES];
    [self.col setPagingEnabled:YES];
    
    
#pragma mark -- 设置page
    [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.width.equalTo(@(100));
        make.height.equalTo(@(20));
    }];
    self.page.numberOfPages = 3;
    self.page.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    self.page.pageIndicatorTintColor = [UIColor whiteColor];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HBRecommentGoodSubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HBRecommentGoodSubCell" forIndexPath:indexPath];
    cell.model = [NSObject new];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(screenW, self.col.frame.size.height);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/screenW;
    self.page.currentPage = index;
}
- (void)setModel:(id)model{
    [self.col reloadData];
}
@end
