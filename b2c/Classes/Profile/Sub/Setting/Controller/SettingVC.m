//
//  SettingVC.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "SettingVC.h"
#import "CustomDetailCell.h"
@interface SettingVC ()
@property(nonatomic,assign)CGFloat  maxY ;
@property(nonatomic,weak)UIButton * loginOutButton ;
@property(nonatomic,strong)NSArray * leftTitles ;
@property(nonatomic,weak)UISwitch * setMessageSound ;
@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundGray;
//    [self layoutsubviews];
//    [self gotCacheSize];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
-(void)layoutsubviews
{
    [super layoutsubviews];
    CGFloat toTopMargin = 20 ;
    CGFloat startPointY = self.startY + toTopMargin ;
    self.maxY = startPointY ;
    CGFloat subH = 44 ;
    CGFloat cellMargin = 5 ;
    for (int i = 0 ;  i< 5; i++) {
        
        CustomDetailCell * sub = [[CustomDetailCell alloc]initWithFrame:CGRectMake(0, self.maxY, screenW, subH)];
        sub.backgroundColor = [UIColor whiteColor];
        sub.leftTitle = self.leftTitles[i];
        if (i==0) {
            sub.arrowHidden = YES;
            [self.view addSubview:sub];
            UISwitch * setMessageSound = [[UISwitch alloc]init];
            self.setMessageSound =setMessageSound ;
//            [setMessageSound addTarget:self action:@selector(changeMessageSoundState:) forControlEvents:UIControlEventValueChanged];
            CGFloat W= setMessageSound.bounds.size.width;
            CGFloat H= setMessageSound.bounds.size.height;
            setMessageSound.center = CGPointMake(sub.bounds.size.width-10 - W/2,sub.bounds.size.height/2);
            [sub addSubview:setMessageSound];

        }else if(i==1){
            /**
             property(nonatomic,copy)NSString * actionKey ;
             @property(nonatomic,copy)NSString * title ;
              是否需要判断是否登录 默认是NO
            @property(nonatomic,assign)BOOL  judge ;
             */
            [sub addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:sub];
            sub.rightDetailTitle = @"智能模式";
        }else if (i==2){
            [sub addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
            sub.arrowHidden = YES;
            sub.rightDetailTitle = [NSString stringWithFormat:@"%luMB",(NSUInteger)[self gotCacheSize]];
            [self.view addSubview:sub];
        }else if(i==3){
            [sub addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:sub];
        }else{
            [sub addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:sub];
        }
        
        self.maxY += (subH+cellMargin);
    }
    
    UIButton * loginOutButton = [[UIButton alloc]init];
    [loginOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    loginOutButton.bounds = CGRectMake(0, 0, screenW-40, 36);
    loginOutButton.center = CGPointMake(self.view.center.x, self.maxY + 100);
    [loginOutButton addTarget:self action:@selector(loginOutClick:) forControlEvents:UIControlEventTouchUpInside];
    loginOutButton.backgroundColor = [UIColor redColor];
    loginOutButton.layer.cornerRadius = 5 ;
    loginOutButton.layer.masksToBounds = YES;
    [self.view  addSubview:loginOutButton];
    self.loginOutButton = loginOutButton ;
    
}

-(void)cellClick:(CustomDetailCell*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击cell")
}

-(void)loginOutClick:(UIButton * )sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"退出登录")
    [[UserInfo  shareUserInfo] loginOut];
}
-(void)changeMessageSoundState:(UISwitch*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,[NSString stringWithFormat:@"状态改变了%d",sender.isOn])
}
-(NSArray * )leftTitles{
    if(_leftTitles==nil){
        _leftTitles = @[@"消息通知提示",@"图片质量",@"清除本地缓存",@"关于直接捞",@"给我们评分"];
    }
    return _leftTitles;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//获取磁盘缓存(单位mb)
-(CGFloat)gotCacheSize
{
    SDImageCache * cache = [SDImageCache sharedImageCache];
    LOG(@"_%@_%d_磁盘缓存大小%ldMB",[self class] , __LINE__,cache.getSize/1024/1024)
    return cache.getSize/1024/1024 ;
}

//清空磁盘缓存
-(void)clearDiskCacheMemory
{
    [[SDImageCache sharedImageCache] clearMemory];
//    [[SDWebImageManager sharedManager] cancelAll];
}


-(void)test1
{
    NSString *  ss[]  = {} ;
}
@end
