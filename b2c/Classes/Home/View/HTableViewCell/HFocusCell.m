//
//  HFocusCell.m
//  b2c
//
//  Created by wangyuanfei on 4/11/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HFocusCell.h"
#import "HFocusCollectiontCell.h"
@interface HFocusCell()<UICollectionViewDelegate ,UICollectionViewDataSource>
@property(nonatomic,strong)NSTimer * timer ;
@property(nonatomic ,strong)UIView * containerView;
@property(nonatomic,strong)UICollectionView * collectV ;
@property(nonatomic,strong)UIPageControl * pageC ;
@end

@implementation HFocusCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutcontainerView];
        [self layoutCollectV];
        [self addTimer];
    }
    return self;
}
-(UIPageControl * )pageC{
    if(_pageC==nil){
        _pageC = [[UIPageControl alloc]init];
        [self.containerView addSubview:_pageC];
        [self.pageC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.containerView.mas_right).with.offset(-screenW/30);
            make.bottom.equalTo(self.containerView.mas_bottom).with.offset(-screenW/30);
        }];
        _pageC.pageIndicatorTintColor=[UIColor colorWithWhite:0.9 alpha:0.2];
        _pageC.currentPageIndicatorTintColor=[UIColor whiteColor];
    }
    return _pageC;
}
-(void)layoutCollectV
{
    UICollectionViewFlowLayout * fLayout = [[UICollectionViewFlowLayout alloc]init];
    fLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    fLayout.itemSize=CGSizeMake(screenW, screenW/2);
    fLayout.minimumLineSpacing = 0 ;
    self.collectV=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenW/2) collectionViewLayout:fLayout];
    self.collectV.showsHorizontalScrollIndicator = NO;
    [self.collectV registerClass:[HFocusCollectiontCell class] forCellWithReuseIdentifier:@"HFocusCollectiontCell"];
    [self.containerView addSubview:self.collectV];
    self.collectV.dataSource=self;
    self.collectV.delegate=self;
    self.collectV.pagingEnabled = YES;
    
}
-(void)layoutcontainerView
{
    self.containerView = [[UIView alloc]init];
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@(screenW/2));
        make.width.equalTo(@(screenW));
        
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.containerView);
    }];
}
-(void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(startRoll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    ///////////
    // LOG(@"_%d_%@",__LINE__,@"添加了定时器");
}
-(void)removeTimer{
    [self.timer invalidate];
    self.timer=nil;
    // LOG(@"_%d_%@",__LINE__,@"移除了定时器");
}
-(void)startRoll
{
    
    NSIndexPath *currentIndexPath = [[self.collectV indexPathsForVisibleItems] lastObject];
    // LOG(@"_%d_%@",__LINE__,currentIndexPath);
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1];
    [self.collectV scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item +1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem==self.cellModel.items.count) {
        nextItem=0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    self.pageC.currentPage =nextIndexPath.item ;
    //  LOG(@"*_* %d *_*%@",__LINE__,nextIndexPath);
    [self.collectV scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    self.pageC.numberOfPages = self.cellModel.items.count ;//每刷新一下列表就重新设置一下
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 6;
    return self.cellModel.items.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HFocusCollectiontCell * cell = [self.collectV dequeueReusableCellWithReuseIdentifier:@"HFocusCollectiontCell" forIndexPath:indexPath];
    
    cell.backgroundColor = randomColor;
    HCellComposeModel * cm =self.cellModel.items[indexPath.item];
    NSString * url = [NSString stringWithFormat:@"http://i0.zjlao.com/%@",cm.imgStr];
//    [cell.colletImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageTransformAnimatedImage];
    cell.composeModel=cm;
    return cell;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;{//只有手动拖的时候才会被调用
    NSIndexPath *currentIndexPath = [[self.collectV indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:1];
    [self.collectV scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    currentIndexPath = [[self.collectV indexPathsForVisibleItems] lastObject];
    self.pageC.currentPage =currentIndexPath.item ;
    LOG(@"_%d_%@",__LINE__,currentIndexPath);
    
}

-(void)setCellModel:(HCellModel *)cellModel{
    [super setCellModel:cellModel];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,cellModel.items)
}
@end
