//
//  SkipManager.m
//  TTmall
//
//  Created by wangyuanfei on 15/12/18.
//  Copyright © 2015年 Footway tech. All rights reserved.
//

#import "SkipManager.h"


#import "LoginNavVC.h"


//#import "SearchFLayout.h"
//#import "SearchVC.h"
//#import "ProfileBaseVC.h"
//#import "DemoVC.h"
@implementation SkipManager

+(instancetype)shareSkipManager{
    static id temp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        temp = [[SkipManager alloc]init];
    });
    return temp;
}
//
//-(void)skipByVC:(UIViewController*)vc urlStr:(NSString *)urlStr title:(NSString *)titleStr action:(NSString *)action{
//    
//    
////    LOG(@"_%@_%d_%d",[self class] , __LINE__,vc.navigationController.childViewControllers.count)
//    Class class = NSClassFromString(action);
//    UIViewController * destination = [[class alloc]init];
//    
//    
//    if ([action isEqualToString:@"SearchVC"]) {
////        SearchFLayout * layout = [[SearchFLayout alloc]init];
////        destination = [[class alloc]initWithCollectionViewLayout:layout];
//        [vc.navigationController pushViewController:destination animated:NO];
//
//    }else{
//        [vc.navigationController pushViewController:destination animated:YES];
////        LOG(@"_%@_%d_%@",[self class] , __LINE__,destination.navigationController)
//    }
//
//
//}
//
//-(void)skipByVC:(UIViewController*)vc withUserInfo:(NSDictionary*)userInfo{
//    
//    
//    //    LOG(@"_%@_%d_%d",[self class] , __LINE__,vc.navigationController.childViewControllers.count)
//#warning 判断是否登录,做出相应的跳转
//    NSString * action = userInfo[@"action"];
//    Class class = NSClassFromString(action);
//    UIViewController * destination = [[class alloc]init];
//    [destination setValue:userInfo forKey:@"GDuserInfo"];
//    
//    
//    if ([action isEqualToString:@"SearchVC"]) {
////        SearchFLayout * layout = [[SearchFLayout alloc]init];
////        destination = [[class alloc]initWithCollectionViewLayout:layout];
//        [vc.navigationController pushViewController:destination animated:NO];
//        
//    }else{
//        [vc.navigationController pushViewController:destination animated:YES];
////        LOG(@"_%@_%d_%@",[self class] , __LINE__,destination.navigationController)
//    }
//    
//    
//}
-(void)skipByVC:(UIViewController*)vc urlStr:(NSString *)urlStr title:(NSString *)titleStr action:(NSString *)action{
    
    
    //    LOG(@"_%@_%d_%d",[self class] , __LINE__,vc.navigationController.childViewControllers.count)
    Class class = NSClassFromString(action);
    UIViewController * destination = [[class alloc]init];
    
    
    if ([action isEqualToString:@"SearchVC"]) {
        //        SearchFLayout * layout = [[SearchFLayout alloc]init];
        //        destination = [[class alloc]initWithCollectionViewLayout:layout];
        [vc.navigationController pushViewController:destination animated:NO];
        
    }else{
        [vc.navigationController pushViewController:destination animated:YES];
        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,destination.navigationController)
    }
    
    
}
//-(void)skipByVC:(UIViewController*)vc urlStr:(NSString *)urlStr title:(NSString *)titleStr action:(NSString *)action{
//    
//    
//    //    LOG(@"_%@_%d_%d",[self class] , __LINE__,vc.navigationController.childViewControllers.count)
//    Class class = NSClassFromString(action);
//    UIViewController * destination = [[class alloc]init];
//    
//    
//    if ([action isEqualToString:@"SearchVC"]) {
//        //        SearchFLayout * layout = [[SearchFLayout alloc]init];
//        //        destination = [[class alloc]initWithCollectionViewLayout:layout];
//        [[KeyVC shareKeyVC] pushViewController:destination animated:NO];
//        
//    }else{
//        [[KeyVC shareKeyVC] pushViewController:destination animated:YES];
//        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,destination.navigationController)
//    }
//    
//    
//}

-(void)skipByVC:(UIViewController*)vc withUserInfo:(NSDictionary*)userInfo{
    
    
    //    LOG(@"_%@_%d_%d",[self class] , __LINE__,vc.navigationController.childViewControllers.count)
#warning 判断是否登录,做出相应的跳转TODO
    NSString * action = userInfo[@"action"];
    Class class = NSClassFromString(action);
    UIViewController * destination = [[class alloc]init];
//    [destination setValue:userInfo forKey:@"GDuserInfo"];
    
    
    if ([action isEqualToString:@"SearchVC"]) {
        //        SearchFLayout * layout = [[SearchFLayout alloc]init];
        //        destination = [[class alloc]initWithCollectionViewLayout:layout];
        [vc.navigationController pushViewController:destination animated:NO];
        
    }else{
        [vc.navigationController pushViewController:destination animated:YES];
        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,destination.navigationController)
    }
    
    
}

-(void)skipByVC:(UIViewController*)vc withActionModel:(BaseModel*)model{
    LOG(@"_%@_%d跳转到_%@",[self class] , __LINE__,model.title)
    LOG(@"_%@_%d_%@",[self class] , __LINE__,model.actionKey)


    if (model.judge) {
        if ([UserInfo shareUserInfo].isLogin) {
            [self performActionWithViewController:vc andModel:model];
        }else{
            LoginNavVC * loginVC  = [[LoginNavVC alloc]initLoginNavVC];
            [[KeyVC shareKeyVC] presentViewController:loginVC animated:YES completion:nil];
        }
    }else{
            [self performActionWithViewController:vc andModel:model];
    }
    

}

-(void)performActionWithViewController:(UIViewController*)vc andModel:(BaseModel*)model
{
    NSString * temp = model.actionKey;
    NSString * subAction = [temp substringFromIndex:6];
    NSString * action = [subAction stringByAppendingString:@"VC"];
    Class class = NSClassFromString(action);
    SecondBaseVC * destination = [[class alloc]init];
    //        destination.naviTitle = action;//根据这个key做相应的跳转
    destination.naviTitle = model.title;//根据这个key做相应的跳转
    
     [vc.navigationController pushViewController:destination animated:YES];
}

@end
