//
//  ShopCarVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**
要点 : 当没收藏商品时 ,在tableHeader中显示空空如也
      当有收藏商品时 , 各自分组显示(失效宝贝归为一组,每个店铺归为一组 , 猜你喜欢归为一组)
*/

#import "ShopCarVC.h"

@interface ShopCarVC ()
/** 底部结算条 , 当tabbar显示时 , 贴近tabbar最上端,当tabbar隐藏时 , 贴近屏幕底边 , 当购物车为空时隐藏 */
@property(nonatomic,strong)NSMutableArray * shopCarData ;
@property(nonatomic,weak)UIView * bottomMenuBar ;


@end

@implementation ShopCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
        self.naviTitle=@"购物车";

//        self.tabBarController.tabBar.isHidden
    // Do any additional setup after loading the view.
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
-(void)setUPBottomToolBar
{
    if (self.shopCarData.count>0) {//阶段toolbar显示
        
    }else{//阶段toolbar隐藏
    
    }
    
    if (self.tabBarController.tabBar.isHidden) {//当tabbar隐藏时 结算toolbar 贴着最下端 , tableview贴着toolBar的最上端
        
    }else{//当tabbar显示时 结算toolbar 贴着tabbar最上端 , tableview再贴着toolBar的最上端
        
    }
}
-(NSMutableArray * )shopCarData{
    if(_shopCarData==nil){
        _shopCarData = [[NSMutableArray alloc]init];
    }
    return _shopCarData;
}

-(void)gotShopCarDataByrRemoteLoad
{
    [[UserInfo shareUserInfo] gotShopingCarSuccess:^(ResponseStatus response) {
       self.shopCarData = [[UserInfo shareUserInfo].shoppingCarData mutableCopy];
        //把结算toolbar显示 , self.toobar.hidden = NO ;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
@end
