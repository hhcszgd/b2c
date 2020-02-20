//
//  TotalOrderVC.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "TotalOrderVC.h"
#import "TotalOrderRefreshHeader.h"
#import "TotalOrderRefreshAutoFooter.h"
//#import "TotalOrderCell.h"
//#import "TotalOrderFooter.h"
//#import "TotalOrderHeader.h"
#import "TotalOrderModel.h"
#import "TOTableCell.h"
#import "TOTableHeader.h"
#import "TOTableFooter.h"
@interface TotalOrderVC ()<UITableViewDataSource, UITableViewDelegate,editOrderDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *table;



/**将要删除的模型和所在的组*/
@property (nonatomic, strong) TotalOrderModel  *willDeleteModel;
/**将要删除的模型和所在的组*/
@property (nonatomic, assign) NSInteger willDeleteSection;

@end

@implementation TotalOrderVC
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    for (NSInteger i = 0; i < 30; i++) {
        TotalOrderModel *model = [[TotalOrderModel alloc] init];
        model.orderState = i%6;
        NSMutableArray *array = [NSMutableArray array];
        NSInteger count = arc4random()%2 + 1;
        for (NSInteger i = 0; i < count; i++) {
            [array addObject:@"1"];
        }
        model.dataArr = array;
        [self.dataArr addObject:model];
    }
    
//    [self configmentCol];
    
    
    [self configmentTable];
    // Do any additional setup after loading the view.
}

- (UITableView *)table{
    if (_table == nil) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY) style:UITableViewStyleGrouped];
        [self.view addSubview:_table];
        [_table registerClass:[TOTableCell class] forCellReuseIdentifier:@"TOTableCell"];
        [_table registerClass:[TOTableHeader class] forHeaderFooterViewReuseIdentifier:@"TOTableHeader"];
        [_table registerClass:[TOTableFooter class] forHeaderFooterViewReuseIdentifier:@"TOTableFooter"];
        _table.delegate = self;
        _table.dataSource = self;
        _table.rowHeight = UITableViewAutomaticDimension;
        _table.estimatedRowHeight = 100;
        [_table setShowsVerticalScrollIndicator:NO];
        TotalOrderRefreshHeader *refreashHeader = [TotalOrderRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        self.table.mj_header = refreashHeader;
        self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _table;
}
- (void)headerRefresh{
    [self.table.mj_header endRefreshing];
}

- (void)configmentTable{
    self.table.backgroundColor = BackgroundGray;
   
    
}
#pragma mark --  tableview 的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TotalOrderModel *model = self.dataArr[section];
    
    return model.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TotalOrderModel *model = self.dataArr[indexPath.section];
    TOTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TOTableCell" forIndexPath:indexPath];
    cell.botttomView.backgroundColor = [UIColor whiteColor];
    if (indexPath.row == (model.dataArr.count - 1)) {
        cell.botttomView.backgroundColor = BackgroundGray;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 103;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == (_dataArr.count - 1)) {
        return 82;
    }
    return 102;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TotalOrderModel *model = _dataArr[section];
    TOTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TOTableHeader"];
    header.orderModel = model;
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    TOTableFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TOTableFooter"];
    TotalOrderModel *model = _dataArr[section];
    
    footer.section = section;
    
    footer.superView = tableView;
    footer.orderModel = model;
    footer.delegate = self;
    return footer;
}

- (void)deleteOrder:(TotalOrderModel *)model section:(id)section{
    UIAlertView *alertView = [[UIAlertView alloc ]initWithTitle:@"确认删除订单？" message:@"删除之后可以从电脑端订单回收站回复" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertActionStyleDefault;
    [alertView show];
    _willDeleteModel = model;
    _willDeleteSection = [section integerValue];
    LOG(@"%@,%d,%ld",[self class], __LINE__,_willDeleteSection)
    
    
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    /**点击确定按钮进项删除订单的操作*/
    if (buttonIndex == 1) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 0; i < _willDeleteModel.dataArr.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:_willDeleteSection];
            [arr addObject:indexPath];
            
        }
        
        [_willDeleteModel.dataArr removeAllObjects];
        [_table deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationBottom];
        [self.dataArr removeObject:_willDeleteModel];
        [_table reloadData];
    }
}




//
//

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
