//
//  PendingPayVC.m
//  b2c
//
//  Created by wangyuanfei on 4/1/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PendingPayVC.h"
#import "PendingPayHeader.h"
#import "PendingPayFooter.h"
#import "PendingPayCell.h"
#import "PendingPayModel.h"
#import "GoodsCell.h"
#import "GuessYouLikeHeader.h"
#import "GoodsModel.h"
@interface PendingPayVC ()<UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,editOrderDelegate>
@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation PendingPayVC
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
        
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (NSInteger i = 0; i < 10; i++) {
        PendingPayModel *model = [[PendingPayModel alloc] init];
        model.orderState = orderStatusWaitingForBuyerToPay;
        NSMutableArray *array = [NSMutableArray array];
        NSInteger count = arc4random()%2 + 1;
        for (NSInteger i = 0; i < count; i++) {
            [array addObject:@"1"];
        }
        model.dataArr = array;
        [self.dataArr addObject:model];
    }
    
    for (NSInteger i = 0; i <1; i++) {
        GoodsModel *model = [[GoodsModel alloc] init];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger j = 0; j <11; j++) {
            GoodsModel *model = [[GoodsModel alloc] init];
            model.titleStr = [NSString stringWithFormat:@"%ld",i];
            [arr addObject:model];
        }
        model.goodsModelArr = arr;
        [self.dataArr addObject:model];
    }
    
    
    [self configmentCol];
    // Do any additional setup after loading the view.
}


- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];

    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY) collectionViewLayout:self.flowLayout];
        [self.view addSubview:_col];
    }
    return _col;
}



- (void)configmentCol{

    self.col.backgroundColor = [UIColor whiteColor];
    self.col.delegate = self;
    self.col.dataSource = self;
    [self.col registerClass:[PendingPayCell class] forCellWithReuseIdentifier:@"PendingPayCell"];
    [self.col registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"GoodsCell"];
    [self.col registerClass:[PendingPayFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PendingPayFooter"];
    [self.col registerClass:[PendingPayHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PendingPayHeader"];
    [self.col registerClass:[GuessYouLikeHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GuessYouLikeHeader"];
    [self.col setShowsVerticalScrollIndicator:NO];
    self.col.backgroundColor = [UIColor whiteColor];
    

}


//- (void)headerRefresh{
//    [self.col.mj_header endRefreshing];
//}
- (void)footerRefresh{
    [self.col.mj_footer endRefreshingWithNoMoreData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    BaseModel *basemodel = self.dataArr[section];
    if ([basemodel isKindOfClass:[GoodsModel class]]) {
        GoodsModel *model =  self.dataArr[section];
        return model.goodsModelArr.count;
    }
    
    
    PendingPayModel *model = self.dataArr[section];
    return model.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BaseModel *model = self.dataArr[indexPath.section];
   
    UICollectionViewCell *modelcell = nil;
    
    
    
    if ([model isKindOfClass:[GoodsModel class]]) {
        GoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCell" forIndexPath:indexPath];
        cell.model = [NSObject new];
        modelcell = cell;
        
    }else{
        PendingPayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PendingPayCell" forIndexPath:indexPath];
        
        modelcell = cell;
    }
    return modelcell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    BaseModel *model = self.dataArr[indexPath.section];
    if ([model isKindOfClass:[GoodsModel class]]) {
        return CGSizeMake((screenW - 2.0)/2.0, (screenW - 2.0)/2.0 * 1.3);
    }
    return CGSizeMake(screenW, 100);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    
    
    BaseModel *model = self.dataArr[indexPath.section];
    if ([model isKindOfClass:[GoodsModel class]]) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            GuessYouLikeHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GuessYouLikeHeader" forIndexPath:indexPath];
            reusableView = header;
            
        }else{
            
            
        }
    }else{
        PendingPayModel *model = self.dataArr[indexPath.section];
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            PendingPayHeader *header =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PendingPayHeader" forIndexPath:indexPath];
            header.section = indexPath.section;
            header.orderModel = model;
            reusableView = header;
            
        }else{
            PendingPayFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PendingPayFooter" forIndexPath:indexPath];
            footer.section = indexPath.section;
            footer.orderModel = model;
            footer.superView = collectionView;
            
            footer.delegate = self;
            reusableView = footer;
            
        }
    }
    
    
    
    return  reusableView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    BaseModel *model = self.dataArr[section];
    if ([model isKindOfClass:[GoodsModel class]]) {
        return CGSizeMake(0, 0);
    }else{
        if (section == (self.dataArr.count - 1 )) {
            return CGSizeMake(screenW, 82);
        }
    }
    
    
    
    
    return CGSizeMake(screenW, 102);

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(screenW, 40);
}

- (void)deleteOrder:(OrderBaseModel *)model section:(id)section{
    NSInteger index = [section integerValue];
    LOG(@"%@,%d,%ld",[self class], __LINE__,index)

    [self.dataArr removeObject:model];
    
    [self.col deleteSections:[NSIndexSet indexSetWithIndex:index]];
    
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        [self.col reloadSections:[NSIndexSet indexSetWithIndex:i]];
    }

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
