//
//  AppDelegate.m
//  b2c
//
//  Created by wangyuanfei on 3/22/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AppDelegate.h"

#import "KeyVC.h"

#import "MainTabBarVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initializationuserinfo];
    // Override point for customization after application launch.
    application.statusBarStyle=UIStatusBarStyleLightContent;
    [self setupKeyVC];
    [self testSwiftFile];

//    [self setupNavigaBar];
    
    return YES;
}
-(void)testSwiftFile{
    TestFile * f = [[TestFile alloc]init];
    [f testMethod];
    
}
-(void)initializationuserinfo
{
    [[UserInfo shareUserInfo] initialization];

}
-(void)setupKeyVC
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    KeyVC * keyVC = [KeyVC shareKeyVC];    
    MainTabBarVC * mainVC = [[MainTabBarVC alloc]init];
    [keyVC addChildViewController:mainVC];
    keyVC.navigationBarHidden=YES;
    //    [rootVC setValue:mainVC forKey:@"rootViewController"];
    self.window.rootViewController = keyVC;
    [self.window makeKeyAndVisible];
}
-(void)setupNavigaBar
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
