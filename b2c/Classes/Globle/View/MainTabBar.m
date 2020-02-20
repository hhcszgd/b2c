//
//  MainTabBar.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "MainTabBar.h"
#import "MainTabBarButton.h"
#import "KeyVC.h"
#import "UserInfo.h"
#import "LoginNavVC.h"
@interface MainTabBar()
@property(nonatomic,weak)MainTabBarButton * currentBtn ;
@property(nonatomic,strong)NSMutableArray * buttonS ;
@property(nonatomic,assign)MainTabBarButton *  destinationBtn ;//点了,不一定会跳过去
@property(nonatomic,strong)NSArray * normalImageS ;
@property(nonatomic,strong)NSArray * selectedImageS ;
@property(nonatomic,weak)MainTabBarButton * profileBtn ;
@end

@implementation MainTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(NSArray * )normalImageS{
    if(_normalImageS==nil){
        _normalImageS = @[@"tab_home_normal",@"tab_classify_normal",@"tab_lao_normal",@"tab_Shopping Cart_normal",@"tab_me_normal" ];
    }
    return _normalImageS;
}
-(NSArray * )selectedImageS{
    if(_selectedImageS==nil){
        _selectedImageS = @[@"tab_home_click",@"tab_classify_click",@"tab_lao_click",@"tab_Shopping Cart_click",@"tab_me_click"];
    }
    return _selectedImageS;
}
-(void)setItemCount:(NSInteger)itemCount{
    
    _itemCount=itemCount;
    NSArray * arr = @[@"首页",@"分类",@"捞",@"购物车",@"我的"];
    for (int i = 0; i < itemCount; i++) {
        
        //        UITabBarItem *item = GDItems[i];
        
        MainTabBarButton *btn = [[MainTabBarButton alloc] init];
        //        [btn setBackgroundImage:item.image forState:UIControlStateNormal];
        //        [btn setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
        btn.tag = i;
        //        [btn setImage:[UIImage imageNamed:@"shop_mainbtn_allitem_unselected"] forState:UIControlStateNormal];
        //        [btn setImage:[UIImage imageNamed:@"shop_mainbtn_allitem_selected"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:self.normalImageS[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:self.selectedImageS[i]] forState:UIControlStateSelected];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        //        [btn.titleLabel setTextColor:[UIColor grayColor]];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (i == 0) {
            
            [self btnClick:btn];
        }
        if (i==4) {
            btn.redPointShow=YES;
            self.profileBtn = btn;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeProfileRedPointState:) name:@"ProfileRedPointShow" object:nil];
        }
        [self addSubview:btn];
        [self.buttonS addObject:btn];
    }
    
    
    
}
-(void)changeProfileRedPointState:(NSNotification*)userinfo
{
    
    NSDictionary * userInfo =userinfo.userInfo;
    self.profileBtn.redPointShow = [userInfo[@"state"] boolValue];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.bounds.size.width / self.itemCount;
    CGFloat btnH = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    //    for (int i = 0; i < _GDItems.count; i++) {
    for (int i = 0; i < self.itemCount; i++) {
        
        MainTabBarButton *btn = self.subviews[i];
        //        [btn setBackgroundColor:randomColor];
        
        
        
        btnX = i * btnW;
        
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}

-(void)btnClick:(MainTabBarButton*)sender
{
    self.destinationBtn = sender;
    if (sender.tag==3 && ![UserInfo shareUserInfo].isLogin) {
        
        LoginNavVC * loginVC  = [[LoginNavVC alloc]initLoginNavVC];
        [[KeyVC shareKeyVC] presentViewController:loginVC animated:YES completion:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skipToDestinatinTabbarIndex) name:@"LoginSuccess" object:nil];
        
    }else {
        self.currentBtn.selected = NO;
        sender.selected = YES;
        
        self.currentBtn = sender ;
        if ([self.mainTabBarDelegate respondsToSelector:@selector(tabBar:didClickbtn:)]) {
            [self.mainTabBarDelegate tabBar:self didClickbtn:sender.tag];
//            [[NSNotificationCenter defaultCenter] removeObserver:self];
        }
    }
}

//-(void)dismissLogin
//{
//    [self.navi dismissViewControllerAnimated:YES completion:nil];
//}

-(void)skipToDestinatinTabbarIndex
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"监听成功")
    
//    MainTabBarButton * shopingCarBtn=self.buttonS[3];
    [self btnClick:self.destinationBtn];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}
 
-(NSMutableArray * )buttonS{
    if(_buttonS==nil){
        _buttonS = [[NSMutableArray alloc]init];
    }
    return _buttonS;
}

@end
