//
//  HomeVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HomeVC.h"
#import "HBaseTableView.h"
#import "HBaseCell.h"
#import "HCellComposeModel.h"
#import "HCellModel.h"


#import "HStoreDetailsVC.h"
@interface HomeVC ()
//@property(nonatomic,assign)CGFloat  or ;
/** 存放每组数据对应的cell的名字 */
/** 初次加载返回的数据 */
@property(nonatomic,strong)NSMutableArray * homeData ;
/** 猜你喜欢接口的数据 */
@property(nonatomic,strong)NSMutableArray * guessLikeData ;
/** 上面两个数据的容器数组 , 首页数据分为两部分 */
@property(nonatomic,strong)NSMutableArray * totalData ;
@end

@implementation HomeVC



- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self gotHomeDataSuccess:^{ }];
//    self.naviTitle=@"首页";
    self.navigationBarColor = [UIColor redColor];
//    self.backButtonHidden=YES;
    [self changenavigationBarBackGroundAlphaWithScale:0];
//    [self setupTableView];//在这设置会有网络数据还没加载完毕而 self.homedata数组为空的情况(解决 网络请求之前从本地取数据 ,初次启动没用)

}
/** 初始化tableView 和 根据数据动态设置刷新控件 */
-(void)setupTableView
{

    if (!self.tableView) {
        CGRect frame  = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
        HBaseTableView * tableView =[[HBaseTableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        self.tableView =tableView;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight=200;
        LOG(@"_%@_%d_%@",[self class] , __LINE__,tableView.mj_header)
        LOG(@"_%@_%d_%@",[self class] , __LINE__,tableView.mj_footer)
        HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(shaxin)];
        self.tableView.mj_header=refreshHeader;
        
        HomeRefreshFooter* refreshFooter = [HomeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
        self.tableView.mj_footer = refreshFooter;
    }else{
        if (!self.homeData) {
            self.tableView.mj_header = nil;
            self.tableView.mj_footer = nil;
        }else{
            if (!self.tableView.mj_footer) {
                HomeRefreshFooter* refreshFooter = [HomeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
                self.tableView.mj_footer = refreshFooter;
            }
            if (!self.tableView.mj_header) {
                HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(shaxin)];
                self.tableView.mj_header=refreshHeader;
            }
        }
    }
    [self.tableView reloadData];
}


//子类实现
-(void)navigationBarRightClickAction
{
    
//    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HomeBaseVC"];
}
////////////////////////////////////////////////////////////////////////////////////////////

#pragma tableView的数据源和代理方法
/** tableView数据源方法 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
      LOG(@"_%@_%d_%ld",[self class] , __LINE__,self.totalData.count)
    return self.totalData.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LOG(@"_%@_%d_%ld",[self class] , __LINE__,[self.totalData[section] count])
    return [self.totalData[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HCellModel * cellModel  = self.totalData[indexPath.section][indexPath.row];
    NSString * cellClassNameStr = cellModel.classKey;
    
    HBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:cellClassNameStr];
    if (!cell) {
        Class  class = NSClassFromString(cellClassNameStr);
        cell = [[class alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClassNameStr];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    if (indexPath.section==0) {
        cell.backgroundColor=[UIColor redColor];
    }else{
//        cell.backgroundColor = [UIColor greenColor];
    }
    cell.cellModel = cellModel;
    return cell;
}
-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UILabel * tempSectionHeader = [[UILabel alloc]init];
        tempSectionHeader.textAlignment = NSTextAlignmentCenter;
        tempSectionHeader.font = [UIFont systemFontOfSize:13];
        tempSectionHeader.textColor = [UIColor lightGrayColor];
        if (self.guessLikeData.count>0) {
            
            tempSectionHeader.text = @"-- 猜你喜欢 --";
        }
        tempSectionHeader.backgroundColor=[UIColor whiteColor];
        return tempSectionHeader;
    }
    return nil;;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.guessLikeData.count>0 && section == 1) {
        
        return 20;
    }
    return 0.0000000001;
}

////////////////////////////////////////////////////////////////////////////////////////////

#pragma 数据操作
-(NSMutableArray * )totalData{
    if(_totalData==nil){
        _totalData = [[NSMutableArray alloc]init];
        [_totalData addObject:self.homeData];
        [_totalData addObject:self.guessLikeData];
    }
    return _totalData;
}
-(NSMutableArray * )homeData{
    if(_homeData==nil){
        _homeData = [[NSMutableArray alloc]init];
    }
    return _homeData;
}
-(NSMutableArray * )guessLikeData{
    if(_guessLikeData==nil){
        _guessLikeData = [[NSMutableArray alloc]init];
        //        [_guessLikeData addObject:@"HAllbuyCell"];
    }
    return _guessLikeData;
}

/** 刷新回调方法 */
-(void)shaxin
{
    //    [NSThread sleepForTimeInterval:2];
    [self gotHomeDataSuccess:^{
        [self.guessLikeData removeAllObjects];
        [self.tableView.mj_header endRefreshing];
        [self setupTableView];
    }];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行刷新列表")
}
/** 加载更多的回调方法 */
-(void)LoadMore
{
    [self gotGuessLikeDataSuccess:^{
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
}

/** 网络获取首页数据(不含猜你喜欢) */
-(void)gotHomeDataSuccess:(void(^)())success
{
    ResponseObject * getFromDisk = [ResponseObject read];//先本地取
    [self analysisDataWith:getFromDisk];
    
    [[UserInfo shareUserInfo] gotHomeDataSuccess:^(ResponseObject *responseObject) {
        [responseObject save];
        [self analysisDataWith:responseObject];
        success();
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        self.tableView.mj_header = nil;
        self.tableView.mj_footer = nil;
    }];
    
}
/** 首页数据解析抽取 */
-(void)analysisDataWith:(ResponseObject*)response
{
    [self.homeData removeAllObjects];
    for (NSDictionary * sub in response.data) {
        HCellModel  * cellModel = [[HCellModel alloc]initWithDict:sub];
        NSMutableArray * tempArrM = [NSMutableArray array];
        for (id  subsub in cellModel.items) {//subsub是数组或字典
            if ([subsub isKindOfClass:[NSArray class]]) {
                //                     LOG(@"_%@_%d_%@",[self class] , __LINE__,subsub)
                NSMutableArray * containLeftAndRightItemArrM = [NSMutableArray array];
                for (NSDictionary * subsubsub in subsub) {//约定好,到这儿一定是字典(优惠券cell的模型->itmes(元素是数组 , 数组里有两个模型))
                    HCellComposeModel * composeModel = [[HCellComposeModel alloc]initWithDict:subsubsub];
                    [containLeftAndRightItemArrM addObject:composeModel];
//                    LOG(@"_%@_%d_%@",[self class] , __LINE__,composeModel.actionKey)
                }
                [tempArrM addObject:containLeftAndRightItemArrM];
                
            }else if ([subsub isKindOfClass:[NSDictionary class]]){//其他cell ->items属性里是直接包含模型的数组
                HCellComposeModel * composeModel = [[HCellComposeModel alloc]initWithDict:subsub];
                [tempArrM addObject:composeModel];
            }
            
        }
        cellModel.items = tempArrM;
        [self.homeData addObject:cellModel];
    }
    
    //////////////设置刷新UI/////////////////
    [self setupTableView];
}

/** 获取加载更多 */
-(void)gotGuessLikeDataSuccess:(void(^)())success{
    [[UserInfo shareUserInfo] gotGuessLikeDataSuccess:^(ResponseObject *responseObject) {
        //        NSString * channel = responseObject.data[@"channel"];
        //        NSString * imgStr = responseObject.data[@"img"];
        NSArray * items = responseObject.data[@"items"];
//        NSMutableArray * arrOut = [NSMutableArray array];
        for (NSDictionary * sub in items) {
            HCellModel * cellModel = [[HCellModel alloc]initWithDict:sub];
            NSMutableArray * arrIn = [NSMutableArray array];
            for (NSDictionary * subsub in cellModel.items) {
                HCellComposeModel * composeModel =  [[HCellComposeModel alloc]initWithDict:subsub];
//                LOG(@"_%@_%d_%@",[self class] , __LINE__,composeModel.imgStr)
                [arrIn addObject:composeModel];
            }
            cellModel.items = arrIn;
            [self.guessLikeData addObject:cellModel];
        }
        success();
    } failure:^(NSError *error) {
        
    }];
}
/** 获取加载更多gai */
-(void)gotGuessLikeDataSuccessNew:(void(^)())success{
    [[UserInfo shareUserInfo] gotGuessLikeDataSuccess:^(ResponseObject *responseObject) {
        
        NSArray * items = responseObject.data[@"items"];
        NSInteger guessLikeItemsCount = items.count;
        NSInteger tarGetCellCount = 0 ;
        if (guessLikeItemsCount%2==0) {
            tarGetCellCount = guessLikeItemsCount/2;
        }else{
            tarGetCellCount = guessLikeItemsCount/2 + 1 ;
        }
        
        NSMutableArray * containCellsArrM = [NSMutableArray array];
        for (int i = 0 ; i < tarGetCellCount; i++) {
            HCellModel * cellModel = [[HCellModel alloc]init];
            cellModel.classKey=@"guesslike";
            [containCellsArrM addObject:cellModel];
        }
        
        for (int k ;  k< items.count; k++) {
            NSDictionary * dict = items[k];
            HCellComposeModel * composeModel = [[HCellComposeModel alloc]initWithDict:dict];
            HCellModel * cellModel =  containCellsArrM[k/2];
            [cellModel.items addObject:composeModel];
        }
        
        
        [self.guessLikeData arrayByAddingObjectsFromArray:containCellsArrM];
        success();
    } failure:^(NSError *error) {
        
    }];
}
////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
