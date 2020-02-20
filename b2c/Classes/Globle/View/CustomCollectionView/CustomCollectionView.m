//
//  CustomCollectionView.m
//  TTmall
//
//  Created by 0 on 16/3/24.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "CustomCollectionView.h"
#import "CustomCollectionCell.h"
@interface CustomCollectionView()
{
    //指针指向传进来的数据
    
    NSTimer *_timer;
    BOOL _isOff;

}
@property (nonatomic, strong) NSArray *data;



@end
@implementation CustomCollectionView

- (UIPageControl *)page{
    if (_page == nil) {
        _page = [[UIPageControl alloc] init];
        [self addSubview:_page];
    }
    return _page;
}
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        [self addSubview:_col];
    }
    return _col;
}

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)dataArray pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor bottom:(CGFloat)bottom right:(CGFloat)right width:(CGFloat)width height:(CGFloat)height on_off:(BOOL)on_off{
    self = [super initWithFrame:frame];
    if (self) {
        
        //赋数据源值
        _data = dataArray;
        _isOff = on_off;
        self.col.backgroundColor = [UIColor blackColor];
        [self.col registerClass:[CustomCollectionCell class] forCellWithReuseIdentifier:@"CustomCollectionCell"];
        self.col.showsHorizontalScrollIndicator = NO;
        self.col.showsVerticalScrollIndicator = NO;
        self.col.pagingEnabled = YES;
        [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        self.col.dataSource = self;
        self.col.delegate = self;
        
        
        
        
        self.page.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
        self.page.pageIndicatorTintColor = pageIndicatorTintColor;
        self.page.numberOfPages = dataArray.count;
        [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-bottom);
            make.centerX.equalTo(self.mas_centerX).offset(right);
             make.width.equalTo(@(width));
            make.height.equalTo(@(height));
        }];
        self.page.backgroundColor = [UIColor clearColor];
        
        
        
        if (on_off) {
            [self addTimer];
            
        }
        
    }
    return self;
}
#pragma collectionDelegate,collectionDatasource,flowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCell" forIndexPath:indexPath];
    cell.model = _data[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(_col.bounds.size.width, _col.bounds.size.height);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//添加定时器
- (void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(startScro) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes ];
}
- (void)startScro{
    NSIndexPath *currentIndexPath = [[self.col indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1];
    [self.col scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == _data.count) {
        nextItem = 0;
        nextSection++;
    }
    //设置当先page显示的点
    self.page.currentPage = nextItem;
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.col scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}
-(void)removeTimer{
    [_timer invalidate];
    
}
//开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_isOff) {
        [self removeTimer];
    }
    
}
//结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_isOff) {
        [self addTimer];
    }
    
}
//减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSIndexPath *currentIndexPath = [[self.col indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1];
    [self.col scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    currentIndexPath = [[self.col indexPathsForVisibleItems] lastObject];
    self.page.currentPage = currentIndexPath.item;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_customBlock) {
        _customBlock(_data[indexPath.row]);
    }
}

- (void)setDataArr:(NSArray *)dataArr{
    _data = dataArr;
    [self.col reloadData];
    self.page.numberOfPages = dataArr.count;
}







@end
