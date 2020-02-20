//
//  SecondBaseVC.m
//  b2c
//
//  Created by wangyuanfei on 3/24/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "SecondBaseVC.h"
#import "ActionBaseView.h"
@interface SecondBaseVC ()

@property(nonatomic,weak)ActionBaseView * navigationView ;
@property(nonatomic,weak)UIButton * backButton ;
@property(nonatomic,weak)UILabel * naviTitleLabel ;
@property(nonatomic,weak)UIView * leftSubViewsContainer ;
@property(nonatomic,weak)UIView * rightSubViewsContainer ;
@property(nonatomic,weak)UIView * privateTitleView ;
@property(nonatomic,assign)BOOL  backButtonHidden ;

@end

@implementation SecondBaseVC


-(instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
    [self addsubviews];
    [self layoutsubviews];
    [self setupBackButtonHidden];

//    self.navigationView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0];
    // Do any additional setup after loading the view.
//    self.naviTitle = @"sdfao;isufgj";
}

-(void)setupBackButtonHidden
{
    if (self.navigationController.childViewControllers.count>1) {
        self.backButtonHidden=NO;
    }else{
        self.backButtonHidden=YES;
    }
}

-(void)addsubviews
{
    ActionBaseView * navigationView = [[ActionBaseView alloc]initWithFrame:CGRectMake(0, 0, screenW, self.navigationController.navigationBar.bounds.size.height+20)];
    self.navigationView=navigationView;
    [self.view addSubview:self.navigationView];
    self.navigationView.backgroundColor = [UIColor whiteColor];
    
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    backButton.adjustsImageWhenHighlighted=NO;
    self.backButton = backButton;
    [self.navigationView addSubview:self.backButton];
    [self.backButton addTarget:self action:@selector(navigationBack) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton setImage:[UIImage imageNamed:@"header_leftbtn_nor"] forState:UIControlStateNormal];
    
    if (self.naviTitle &&self.naviTitle.length>0) {
        self.naviTitleLabel.text = self.naviTitle;
         [self.naviTitleLabel sizeToFit];
        self.naviTitleLabel.center=CGPointMake(self.navigationView.center.x, self.navigationView.center.y+10);
    }
}

-(UILabel * )naviTitleLabel{
    if(_naviTitleLabel==nil){
       UILabel   * label = [[UILabel alloc]init];
        _naviTitleLabel = label;
        [self.navigationView addSubview:label];
    }
    return _naviTitleLabel;
}

-(void)setNaviTitle:(NSString *)naviTitle{//如果类内部赋值,先执行viewdidload , 如果外部赋值切创建出来不让它显示,(如先创建在push) , 此时先执行这一句, 而此时navititleLabel的父控件navigationView还不存在,所以需要再在viewdidload中再赋值一次
    _naviTitle = naviTitle;
    if (naviTitle.length>0 && naviTitle!=nil) {
        self.naviTitleLabel.hidden=NO;
        self.naviTitleLabel.text=naviTitle;
        [self.naviTitleLabel sizeToFit];
        self.naviTitleLabel.center=CGPointMake(self.navigationView.center.x, self.navigationView.center.y+10);
    }else{
        self.naviTitleLabel.text=nil;
        self.naviTitleLabel.hidden=YES;
    }

}


-(void)layoutsubviews
{
    
    self.navigationView.backgroundColor=[UIColor whiteColor];

}
-(void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
//    [[KeyVC shareKeyVC] popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
}
-(void)changenavigationBarBackGroundAlphaWithScale:(CGFloat)scale{
    self.navigationView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:scale];
    CGFloat tempScale = scale<0.6 ? 0.6 : scale;
    _privateTitleView.backgroundColor=[[UIColor colorWithWhite:0.9 alpha:1] colorWithAlphaComponent:tempScale] ;//设置搜索框的颜色和透明度

}
-(void)changenavigationBarAlphaWithScale:(CGFloat)scale{

        self.navigationView.alpha = scale;

}
-(void)setBackButtonHidden:(BOOL)backButtonHidden{
    _backButtonHidden=backButtonHidden;
    if (backButtonHidden) {
        self.backButton.hidden = YES;
    }else{
        self.backButton.hidden = NO;
    }

}
-(void)setNavigationBarColor:(UIColor *)navigationBarColor{
    _navigationBarColor = navigationBarColor;
    self.navigationView.backgroundColor = navigationBarColor;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.navigationView];
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
    
}
-(void)setNavigationBarRightActionViews:(NSArray *)navigationBarRightActionViews{
    _navigationBarRightActionViews = navigationBarRightActionViews;
    
    if (navigationBarRightActionViews) {
        CGFloat totalWidth = 0 ;
        CGFloat margin = 6;
        CGFloat subH =self.navigationView.bounds.size.height -20-margin;
        CGFloat subY = 20 ;
        for (int i = 0 ; i<navigationBarRightActionViews.count;i++) {
            CGFloat subW = subH;
            UIView * sub = navigationBarRightActionViews[i];
            [self.rightSubViewsContainer addSubview:sub];
            CGFloat subX = totalWidth;
            if (sub.bounds.size.width>0) {
                subX= totalWidth;
                subW = sub.bounds.size.width;
            }
            sub.frame = CGRectMake(subX, 0, subW, subH);
            totalWidth+=subW;
        }
        CGFloat containerX  =  self.navigationView.bounds.size.width -margin - totalWidth;
         self.rightSubViewsContainer.frame = CGRectMake(containerX, subY, totalWidth, subH);
    }

}
-(void)setNavigationBarLeftActionViews:(NSArray *)navigationBarLeftActionViews{
    _navigationBarLeftActionViews = navigationBarLeftActionViews;
    if (navigationBarLeftActionViews) {
        
            CGFloat leftStart = 0 ;
            CGFloat margin = 6;
            CGFloat subH =self.navigationView.bounds.size.height -20-margin;
//            CGFloat subW = subH;
            CGFloat subY = 20 ;
            for (int i = 0 ; i<navigationBarLeftActionViews.count;i++) {
                CGFloat subW = subH;
                UIView * sub = navigationBarLeftActionViews[i];
                [self.leftSubViewsContainer addSubview:sub];
                CGFloat subX = leftStart;
                if (sub.bounds.size.width>0) {
//                    subX= self.navigationView.bounds.size.width-rightMinus-margin-sub.bounds.size.width;
                    subW = sub.bounds.size.width;
                }
                sub.frame = CGRectMake(subX, 0, subW, subH);
                leftStart+=subW;
            }
        self.leftSubViewsContainer.frame = CGRectMake(margin, subY, leftStart, subH);
        
    }

}


-(UIView * )leftSubViewsContainer{
    if(_leftSubViewsContainer==nil){
        UIView * leftSubViewsContainer = [[UIView alloc]init];
        [self.navigationView addSubview:leftSubViewsContainer];
        _leftSubViewsContainer =leftSubViewsContainer;
        
    }
    return _leftSubViewsContainer;
}
-(UIView * )rightSubViewsContainer{
    if(_rightSubViewsContainer==nil){
        UIView * rightSubViewsContainer = [[UIView alloc]init];
        [self.navigationView addSubview:rightSubViewsContainer];
        _rightSubViewsContainer = rightSubViewsContainer;
    }
    return _rightSubViewsContainer;
}
-(void)setNavigationTitleView:(UIView *)navigationTitleView{
    _navigationTitleView = navigationTitleView;
    if (navigationTitleView) {
        for (UIView * sub in self.privateTitleView.subviews) {
            [sub removeFromSuperview];
        }
        [self.privateTitleView addSubview:navigationTitleView];
        navigationTitleView.frame = self.privateTitleView.bounds;
        
    }
}
-(void)setSearchView:(UIView *)searchView{
    _searchView = searchView;
    if (searchView) {
        for (UIView * sub in self.privateTitleView.subviews) {
            [sub removeFromSuperview];
        }
        [self.privateTitleView addSubview:searchView];
        searchView.frame = self.privateTitleView.bounds;
//        _privateTitleView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.5] ;
    }
}
-(void)setNavigationCustomView:(UIView *)navigationCustomView{
    _navigationCustomView = navigationCustomView;
    if (navigationCustomView) {
        for (UIView * sub in self.privateTitleView.subviews) {
            [sub removeFromSuperview];
        }
        [self.privateTitleView addSubview:navigationCustomView];
        navigationCustomView.frame = self.privateTitleView.bounds;

    }
}
-(UIView * )privateTitleView{
    if(_privateTitleView==nil){
        UIView * privateTitleView = [[UIView alloc]init];
        privateTitleView.layer.cornerRadius = 5 ;
        privateTitleView.layer.masksToBounds=YES;
        [self.navigationView addSubview:privateTitleView];
        _privateTitleView=privateTitleView;
        
        
        
        CGFloat margin = 6;
        CGFloat subH =34;
        CGFloat subW =  0 ;
        CGFloat y =(self.navigationView.bounds.size.height-margin-20-subH)*0.5 +20 ;
        if (self.navigationTitleView) { //当设置titleView时 , 此时以右面的为准  //done //考虑小于44 的情况
            CGFloat x = self.rightSubViewsContainer.bounds.size.width+margin*2;
            subW = self.navigationView.bounds.size.width - x*2  ;
            _privateTitleView.frame = CGRectMake(x, y, subW, subH);
        }else if (self.searchView){//当设置搜索View时 ,此时分返回键是否显示 //
            if (!self.backButtonHidden && self.rightSubViewsContainer.subviews.count>0) {//返回键显示,右侧显示
                CGFloat x = self.backButton.bounds.size.width+margin*2;
                subW = self.navigationView.bounds.size.width - x-self.rightSubViewsContainer.bounds.size.width-margin*2  ;
                _privateTitleView.frame = CGRectMake(x, y, subW, subH);
            }else if (self.leftSubViewsContainer.subviews.count>0&&self.rightSubViewsContainer.subviews.count>0){//左侧显示,右侧显示
                CGFloat x = CGRectGetMaxX(self.backButton.frame)+margin;
                subW = self.navigationView.bounds.size.width - x - self.rightSubViewsContainer.bounds.size.width - margin*2 ;
                _privateTitleView.frame = CGRectMake(x, y, subW, subH);

            }
        }else  if(self.navigationCustomView){//其他情况 可以留个接口供自定义
            //balala
            self.privateTitleView.bounds =CGRectMake(0, 0, self.navigationCustomView.bounds.size.width, subH);
            self.privateTitleView.center = CGPointMake(self.navigationView.center.x, self.navigationView.center.y+10);
        }
    }
    return _privateTitleView;
}
-(void)dealloc{
    
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"销毁")
}

-(CGFloat)startY{
    return self.navigationView.bounds.size.height;


}

@end
