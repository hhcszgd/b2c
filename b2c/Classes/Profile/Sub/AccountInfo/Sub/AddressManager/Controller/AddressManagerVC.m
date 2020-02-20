//
//  AddressManagerVC.m
//  b2c
//
//  Created by wangyuanfei on 4/6/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AddressManagerVC.h"
#import "AMCell.h"
#import "AMCellModel.h"
#import "EditAddressVC.h"
@interface AddressManagerVC ()<UITableViewDelegate,UITableViewDataSource,AMCellDelegate,EditAddressVCDelegate>


@property(nonatomic,strong)NSMutableArray  * addresses ;//默认地址排在第一位
@end

@implementation AddressManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle=@"收货地址管理";
    [self setupRightBarbuttonItem];
    self.view.backgroundColor=BackgroundGray;
    [self setupTableView];
    
    // Do any additional setup after loading the view.
}
-(void)setupRightBarbuttonItem
{
    ActionBaseView * rightButton = [[ActionBaseView alloc]init];
    rightButton.title = @"新增";
    [rightButton addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBarRightActionViews=@[rightButton];
}
-(void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    UITableView*tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY) style:UITableViewStylePlain];
    self.tableView=tableView;
    self.tableView.backgroundColor=BackgroundGray;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight=200;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
}

-(void)addAddress:(ActionBaseView*)sender
{
    EditAddressVC * cv = [[EditAddressVC alloc]initWithActionStyle:Adding];
    cv.delegate=self;
    [self.navigationController pushViewController:cv animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addresses.count ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AMCellModel * model = self.addresses[indexPath.row];
    AMCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AMCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model=model;
    cell.delegate=self;
    return cell;
}


#pragma lazyload

-(NSMutableArray * )addresses{
    if(_addresses==nil){
        NSMutableArray * arrM =  [[NSMutableArray alloc]init];
        for (int i = 0 ; i<6; i++) {
            AMCellModel*model = [[AMCellModel alloc]init];
            model.name=@"John Lock";
            model.phoneNumber=@"188 3812 0444";
            model.province=@"省1";
            model.city=@"市2";
            model.area=@"区3";
            model.isDefaultAddress=NO;
            if (i==2) {
                model.area=@"北京市海淀区";
            }
            //            model.street=@"航丰路街道";
            model.detailAddress = @"时代财富天地2015";
            model.postalCode=@"100000";
            [arrM addObject:model];
        }
        _addresses = arrM;
    }
    return _addresses;
}
#pragma cellDelegate
-(void)setDefaultAddressAtCell:(AMCell*)cell{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"代理方法执行成功")
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    for (AMCellModel * temp in self.addresses) {
        temp.isDefaultAddress=NO;
    }
    AMCellModel * model = self.addresses[indexPath.row];
    model.isDefaultAddress=YES;
    [self.tableView reloadData];
}

-(void)deleteButtonClickAtCell:(AMCell *)cell{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"代理方法执行成功 点击删除按钮")
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定要删除此收货地址吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * perform=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
#pragma 记得更新服务器端的数据
        [self.addresses removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:perform];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)editButtonClickAtCell:(AMCell *)cell{
    
    EditAddressVC * cv = [[EditAddressVC alloc]initWithActionStyle:Editing];
    cv.delegate=self;

    [self.navigationController pushViewController:cv animated:YES];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    cv.editingCell=cell;
//    });
    
}
-(void)endEditingAddtess:(EditAddressVC *)editVC andEditingCell:(AMCell *)editingCell{
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:editingCell];
    //    AMCellModel * model = self.addresses[indexPath.row];
    //    model = editingCell.model;
    //     self.addresses[indexPath.row]= model ;
    [self.addresses replaceObjectAtIndex:indexPath.row withObject:editingCell.model];
    [self.tableView reloadData];
    
    
}
-(void)addAddressWithModel:(AMCellModel *)model{
    [self.addresses addObject:model];
    [self.tableView reloadData];
    
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
