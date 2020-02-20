//
//  ShopCollectVC.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//
/**收藏控制器*/
#import "ShopCollectVC.h"
#import "SCCell.h"
@interface ShopCollectVC ()
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ShopCollectVC
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   

  //背景颜色
    self.view.backgroundColor = [UIColor whiteColor];

    //数据请求
    
    
    //    NSString *token = [UserInfo shareUserInfo].token;
    //
    //    NSURL *url = [NSURL URLWithString:BASEURL];
    //    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    //    //表头
    //    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"APPID"];
    //    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"VERSIONID"];
    //    [manager.requestSerializer setValue:@"20160501" forHTTPHeaderField:@"VERSIONMINI"];
    //    [manager.requestSerializer setValue:UUID forHTTPHeaderField:@"DID"];
    //
    //    //表单
    //    NSDictionary *dic = @{@"token":token,@"member_id":@"4"};
    //    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //    [manager GET:@"index.php?m=Api&c=ShopCollect&a=rest" parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
    //
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        LOG(@"%@,%d,%@",[self class], __LINE__,responseObject)
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        LOG(@"%@,%d,%@",[self class], __LINE__,@"请求失败")
    //    }];
    //
    //
    //
    //
    
    
    [self configmentNav];
    /**如果没有数据就不会加载table*/
    if (self.dataArray.count == 0 ) {
#warning 缺少没有数据时候的页面
    }else{
        [self configmentTable];
    }
    
}

- (void)configmentNav{
    //控制器标题
    self.title = @"店铺收藏";
    //编辑按钮
    UILabel *edit = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [edit configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"编辑"];
    UITapGestureRecognizer *editTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(edit:)];
    [edit addGestureRecognizer:editTap];
    [edit setUserInteractionEnabled:YES];
    self.navigationBarRightActionViews = @[edit];
}
/**编辑方法*/
- (void)edit:(UITapGestureRecognizer *)tap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"编辑")
}
//显示北京图片
- (void)showBackView{
    
}
- (void)configmentTable{
    
    UITableView *shopTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY) style:UITableViewStylePlain];
    shopTable.delegate = self;
    shopTable.dataSource = self;
    shopTable.rowHeight = UITableViewAutomaticDimension;
    shopTable.estimatedRowHeight = 100;
    shopTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [shopTable registerClass:[SCCell class] forCellReuseIdentifier:@"SCCell"];
    
    [self.view addSubview:shopTable];
}




#pragma mark -- tableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SCCell" forIndexPath:indexPath];
    cell.scModel = [[SCModel alloc] init];
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"ShopStoreController"];
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
