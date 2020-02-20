//
//  BaseVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()


@end

@implementation BaseVC

- (void)viewDidLoad {
    [self setupNetworkStatus];
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];//导航栏左右两侧按钮颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName :[UIColor whiteColor] }];//导航栏标题颜色
    
    self.view.backgroundColor=randomColor;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBarHidden=YES;
    
//    LOG(@"_%@_%d_%f",[self class] , __LINE__,NavigationBarHeight)
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
-(void)setTableView:(UITableView *)tableView{
    _tableView = tableView ;
    [self.view addSubview:tableView];
    tableView.delegate =self;
    tableView.dataSource = self;
}
-(void)setupNetworkStatus
{
    __weak typeof(self) weakSelf = self;
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,@"UnknownNetworking")
                weakSelf.networkingStatus = NETERROR;
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,@"disconnect")
                weakSelf.networkingStatus = NETERROR;
                //            [self viewWhenNetWorkingError];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //            [self.viewWhenNetWorkingError removeFromSuperview];
                LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,@"mobileNet")
                weakSelf.networkingStatus = NETMOBILE;
                //            [self reloadWhenNecworkingReconnect];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //            [self.viewWhenNetWorkingError removeFromSuperview];
                LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,@"wifi")
                weakSelf.networkingStatus = NETWIFI;
                //            [self reloadWhenNecworkingReconnect];
                break;
            default:
                LOG(@"_%@_%d_%@",[weakSelf class] , __LINE__,@"sssssssss")
                break;
        }
        
    } ];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
}

///////////////////////
//-(void)setNetworkingStatus:(NetworkingStatus)networkingStatus{
//    _networkingStatus = networkingStatus;
//    switch (networkingStatus) {
//        case NETERROR:
//        {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"UnknownNetworking")
////            ALERT(@"网络错误")
//        }
//            break;
//
//        case NETMOBILE:
//        {
//            //            [self.viewWhenNetWorkingError removeFromSuperview];
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"mobileNet")
////            ALERT(@"网络连接成功")
//        }
//            break;
//        case NETWIFI:
//        {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"wifi")
////            ALERT(@"当前网络为wifi")
//        }
//            break;
//        default:
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"未知错误")
//            break;
//    }
//}

//
//-(void)netWorkingChangeWithStatus:(AFNetworkReachabilityStatus)status
//{
//    switch (status) {
//        case AFNetworkReachabilityStatusUnknown:
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"UnknownNetworking")
//            self.networkingStatus = NETERROR;
//            break;
//            
//        case AFNetworkReachabilityStatusNotReachable:
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"disconnect")
//            self.networkingStatus = NETERROR;
//            //            [self viewWhenNetWorkingError];
//            
//            break;
//        case AFNetworkReachabilityStatusReachableViaWWAN:
//            //            [self.viewWhenNetWorkingError removeFromSuperview];
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"mobileNet")
//            self.networkingStatus = NETMOBILE;
//            //            [self reloadWhenNecworkingReconnect];
//            break;
//        case AFNetworkReachabilityStatusReachableViaWiFi:
//            //            [self.viewWhenNetWorkingError removeFromSuperview];
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"wifi")
//            self.networkingStatus = NETWIFI;
//            //            [self reloadWhenNecworkingReconnect];
//            break;
//        default:
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"sssssssss")
//            break;
//    }
//}

@end
