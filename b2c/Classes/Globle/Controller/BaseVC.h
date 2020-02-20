//
//  BaseVC.h
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
/**
 工程里所用viewcontroller的父控制器
 */

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    NETERROR=0,
    NETWIFI,
    NETMOBILE
} NetworkingStatus;

@interface BaseVC : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView * tableView ;
/** 当前网络状态 */
@property(nonatomic,assign)NetworkingStatus  networkingStatus ;
@end
