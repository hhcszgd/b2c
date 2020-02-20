//
//  MainTabBarVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "MainTabBarVC.h"
#import "MainTabBar.h"
#import "BaseNavigationVC.h"
#import "BaseVC.h"
#import "HomeVC.h"
#import "HomeNavigationVC.h"
#import "ClassifyVC.h"
#import "ClassifyNavigationVC.h"
#import "LaoVC.h"
#import "LaoNavigationVC.h"
#import "ShopCarVC.h"
#import "ShopCarNavigationVC.h"
#import "ProfileVC.h"
#import "ProfileNavigationVC.h"
@interface MainTabBarVC ()<MainTabBarDelegate>

@end

@implementation MainTabBarVC


 - (void)viewDidLoad {
 [super viewDidLoad];
 
 [self addChildViewController: [self setSubVCWithNavigationVC:@"HomeNavigationVC" subVC:@"HomeVC"]];
 [self addChildViewController: [self setSubVCWithNavigationVC:@"ClassifyNavigationVC" subVC:@"ClassifyVC"]];
 [self addChildViewController: [self setSubVCWithNavigationVC:@"LaoNavigationVC" subVC:@"LaoVC"]];
 [self addChildViewController: [self setSubVCWithNavigationVC:@"ShopCarNavigationVC" subVC:@"ShopCarVC"]];
 [self addChildViewController: [self setSubVCWithNavigationVC:@"ProfileNavigationVC" subVC:@"ProfileVC"]];

 [self setuptabBar];
 // Do any additional setup after loading the view.
 }

-(BaseNavigationVC*)setSubVCWithNavigationVC:(NSString*)navigationVC subVC:(NSString*)subVC {
    Class NavigationVCClass = NSClassFromString(navigationVC);
    Class SubVcClass = NSClassFromString(subVC);
    BaseNavigationVC *  destinationVC = [[NavigationVCClass alloc]initWithRootViewController:[[SubVcClass alloc]init]] ;
    return destinationVC;
}
//初始化自定义tabBar
- (void)setuptabBar
{
    
    MainTabBar *tabBar = [[MainTabBar alloc] init];
    
    tabBar.frame = self.tabBar.bounds;
    //    tabBar.GDItems = self.tabBarArr;
    //    tabBar.GDItems = self.tabBar.subviews;
    tabBar.itemCount=self.childViewControllers.count;
    tabBar.mainTabBarDelegate = self;
    
    [self.tabBar addSubview:tabBar];
    [self.tabBar bringSubviewToFront:tabBar];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=YES;
    for (UIView *childView in self.tabBar.subviews) {
        
        if ([childView isKindOfClass:[MainTabBar class]] == NO) {
            
            [childView removeFromSuperview];
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(MainTabBar *)tabBar didClickbtn:(NSInteger)index
{
    //selectedindex是系统自带的属性,只要将按钮的索引传给它,就能实现点击切换控制器了
    
    self.selectedIndex = index;
}

@end
