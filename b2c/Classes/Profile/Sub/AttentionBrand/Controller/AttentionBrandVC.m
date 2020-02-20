//
//  AttentionBrandVC.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AttentionBrandVC.h"
#import "ABrandModel.h"
#import "ABrandCell.h"
@interface AttentionBrandVC ()
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation AttentionBrandVC
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return _dataArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**如果没有数据就不会加载table*/
    if (self.dataArray.count == 0 ) {
#warning 缺少没有数据时候的页面
    }else{
        [self configmentTable];
    }
    
    //
    // Do any additional setup after loading the view.
}
- (void)configmentTable{
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = UITableViewAutomaticDimension;
    table.estimatedRowHeight = 100;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [table registerClass:[ABrandCell class] forCellReuseIdentifier:@"ABrandCell"];
    
    [self.view addSubview:table];
}




#pragma mark -- tableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABrandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABrandCell" forIndexPath:indexPath];
    cell.brandModel = [[ABrandModel alloc] init];
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"ShopStoreController"];
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
