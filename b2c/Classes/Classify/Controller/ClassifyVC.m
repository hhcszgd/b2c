//
//  ClassifyVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ClassifyVC.h"
#import "ActionBaseView.h"
@interface ClassifyVC ()

@end

@implementation ClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
        self.naviTitle=@"分类";
    ActionBaseView * view = [[ActionBaseView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor=randomColor;
    [self.view addSubview:view];
    [view addTarget:self action:@selector(mytest:) forControlEvents:UIControlEventTouchUpInside];
//    [view addTarget:self andSelStr:@"mytest:"];

}
-(void)mytest:(id)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,sender)
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"ClassifyVC"];

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
