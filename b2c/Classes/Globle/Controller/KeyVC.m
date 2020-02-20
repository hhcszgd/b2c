//
//  KeyVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "KeyVC.h"

@interface KeyVC ()

@end

@implementation KeyVC

static  KeyVC * _keyVC;
+(instancetype)shareKeyVC{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keyVC = [[KeyVC alloc]init];
    });
    return _keyVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count!=0) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    
    if (self.childViewControllers.count>1) {
        self.navigationBarHidden=NO;
    }else{
        self.navigationBarHidden=YES;
    }
    [super pushViewController:viewController animated:animated];
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
