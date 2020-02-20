//
//  PTableHeaderView.m
//  b2c
//
//  Created by wangyuanfei on 3/29/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PTableHeaderView.h"
#import "PTableHeaderModel.h"
#import "PTableHeaderCompose.h"
#import "ProfileMessageView.h"
@interface PTableHeaderView()
/** tableHeader的整体背景图片 */
@property(nonatomic,weak)ActionBaseView * imgView ;
/** 头像view的容器View */
@property(nonatomic,weak)ActionBaseView * iconView ;
/** 头像,等级,用户名的容器view */
@property(nonatomic,weak)UIView * containerView ;
/** 消息中心视图 */
@property(nonatomic,weak)ProfileMessageView * messageView ;
/** 背景图片的实际尺寸 */
@property(nonatomic,assign)CGSize  imgSize ;
/** 用户名label */
@property(nonatomic,weak)UILabel * accountNameLabel ;
/** 等级view */
@property(nonatomic,weak)UIImageView * levelImageView ;
//@property(nonatomic,weak)ActionBaseView *  accountNameAndLevelView;
/** 头部下方菜单项 */
@property(nonatomic,weak)UIView * menuView ;

/** 商品收藏 */
@property(nonatomic,weak)PTableHeaderCompose * goodsCollect ;
/** 店铺收藏 */
@property(nonatomic,weak)PTableHeaderCompose * shopCollect ;
/** 关注品牌 */
@property(nonatomic,weak)PTableHeaderCompose * attentionBrand ;
////////////////
//@property(nonatomic,weak)UIView * iconContainer ;

@end

@implementation PTableHeaderView



-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self addsubviews];
//        self.backgroundColor = [UIColor greenColor];
//        LOG(@"_%@_%d_%f",[self class] , __LINE__,SCALE)
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize([@"ceshxia" stringSizeWithFont:12]))
        
    }
    return self;

}

//-(void)addsubviews
//{
//    
//        //背景图
//    ActionBaseView * imgView = [[ActionBaseView   alloc]init];
//    imgView.img =[UIImage imageNamed:@"mytmall_atmosphere_default"];
//    self.imgView=imgView;
//    [self addSubview:self.imgView];
//    //头像
//    ActionBaseView * iconView = [[ActionBaseView alloc]init];
////    iconView.backgroundColor = randomColor;
//    self.iconView=iconView;
//    [self addSubview:self.iconView];
//    BaseModel * iconViewModel = [[BaseModel alloc]init];
//    iconViewModel.actionKey = ActionAccountInfo;
//    iconViewModel.title = @"个人信息";
//    iconViewModel.judge=YES;
//    self.iconView.model=iconViewModel;
//    [iconView addTarget:self action:@selector(componentClick:) forControlEvents:UIControlEventTouchUpInside];
//    //昵称&等级 , 不登录时就不显示,所以就采用懒加载
//    
//    //消息按钮
//    ActionBaseView * messageView =[[ActionBaseView alloc]init];
//    messageView.img=[UIImage imageNamed:@"SHJ_Collection"];
//    self.messageView=messageView;
//    [messageView addTarget:self action:@selector(componentClick:) forControlEvents:UIControlEventTouchUpInside];
//    BaseModel * messageViewModel = [[BaseModel alloc]init];
//    messageViewModel.actionKey = ActionMessageCenter;
//    messageViewModel.title = @"消息中心";
//    messageViewModel.judge=YES;
//    messageView.model=messageViewModel;
//    [self addSubview:messageView];
//    //菜单栏
//    UIView * menuView = [[UIView alloc]init];
//    menuView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
//    self.menuView=menuView;
//    [self addSubview:self.menuView];
//
//    for (int i = 0; i<4; i++) {
//        ActionBaseView * sub = [[ActionBaseView alloc]init];
////        sub.backgroundColor = randomColor;
//        [menuView addSubview:sub];
//        BaseModel * model = [[BaseModel alloc]init];
//        switch (i) {
//            case 0:
//            {
//                model.actionKey = ActionGoodsCollect;
//                model.title = @"商品收藏";
//            }
//                break;
//            case 1:
//            {
//                model.actionKey = ActionShopCollect;
//                model.title = @"店铺收藏";
//            }
//                break;
//            case 2:
//            {
//                model.actionKey = ActionAttentionBrand;
//                model.title = @"关注品牌";
//            }
//                break;
//            case 3:
//            {
//                model.actionKey = ActionFootHistory;
//                model.title = @"我的足迹";
//            }
//                break;
//            default:
//                break;
//        }
//        model.judge=YES;
//        sub.model = model;
//        [sub addTarget:self action:@selector(componentClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    self.imgView.frame = CGRectMake(0, -(self.imgSize.height-self.bounds.size.height), self.imgSize.width, self.imgSize.height);
//    CGFloat iconViewW = 79*SCALE;
//    CGFloat iconViewH = iconViewW;
//    CGFloat iconViewCenterY = (47.5 + iconViewH*0.5)*SCALE;
//    self.iconView.bounds=CGRectMake(0, 0, iconViewW, iconViewH);
//    self.iconView.center = CGPointMake(self.center.x, iconViewCenterY);
//    self.iconView.layer.cornerRadius = self.iconView.bounds.size.width*0.5;
//    self.iconView.layer.masksToBounds=YES;
//    self.iconView.layer.borderWidth=2*SCALE;
//    self.iconView.layer.borderColor=[UIColor whiteColor].CGColor;
//    
////    self.accountName=nil;
//    CGFloat w = screenW/4 ;
//    CGFloat h = 50*SCALE;
//    CGFloat y = self.bounds.size.height-h;
//    self.menuView.frame = CGRectMake(0, y, self.bounds.size.width, h);
//    for (int i = 0; i<self.menuView.subviews.count ; i++) {
//#warning 下面这一行的类要重新自定义
//        ActionBaseView * sub = self.menuView.subviews[i];
//        sub.frame = CGRectMake(i*w, 0, w, h);
//        sub.title = sub.model.title;
//
//    }
//    
//    self.messageView.frame=CGRectMake(300, 30, 30, 30);
//    
//    /** 模拟模型赋值 */
//    self.pTableHeaderModel= [[PTableHeaderModel alloc]init];
//}

-(CGSize)imgSize{
    UIImage *img = [UIImage imageNamed:@"mytmall_atmosphere_default"];
    CGSize imgsize = img.size;
    
    return  CGSizeMake(screenW, screenW/imgsize.width*imgsize.height);
}
-(void)componentClick:(ActionBaseView*)sender
{
    if ([self.TableHeaderDelegate respondsToSelector:@selector(actionWithTableHeaderComponent:)]) {
        [self.TableHeaderDelegate actionWithTableHeaderComponent:sender];
    }
}

-(UILabel * )accountNameLabel{
    if(_accountNameLabel==nil){
        UILabel * accountNameLabel = [[UILabel alloc]init];
        accountNameLabel.font = [UIFont boldSystemFontOfSize:14*SCALE];
        accountNameLabel.textColor = [UIColor whiteColor];
        _accountNameLabel = accountNameLabel;
        accountNameLabel.textAlignment = NSTextAlignmentCenter;
        [self.containerView addSubview:accountNameLabel];
    }
    return _accountNameLabel;
}

-(UIImageView * )levelImageView{
    if(_levelImageView==nil){
        UIImageView * levelImageView = [[UIImageView alloc]init];
        _levelImageView =levelImageView;
        [self.containerView addSubview:levelImageView];
    }
    return _levelImageView;
}


//-(void)setPTableHeaderModel:(PTableHeaderModel *)pTableHeaderModel{
//    _pTableHeaderModel = pTableHeaderModel;
//    
//    
//    
////    self.messageView.count =  pTableHeaderModel.messageCount;
//    //收藏商品数
//    
//    
//
//    self.accountNameLabel.text=pTableHeaderModel.accountName;
//    self.levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"level_v%ld",pTableHeaderModel.level]];
//    self.iconView.img =pTableHeaderModel.icon;
//    
//    
//    self.accountNameLabel.text=pTableHeaderModel.accountName;
//    
//    if (pTableHeaderModel.accountName && pTableHeaderModel.accountName.length>0) {
////        self.accountNameAndLevelView.hidden=NO;
//        self.accountNameLabel.hidden = NO ;
//        self.levelImageView.hidden = NO;
//        self.accountNameLabel.text = pTableHeaderModel.accountName;
//        CGSize textSize = [pTableHeaderModel.accountName stringSizeWithFont:12*SCALE];
//        CGFloat imgW = 18*SCALE;
//        CGFloat imgH = imgW;
//        CGFloat imgX = textSize.width;
//        CGFloat imgY = 0 ;
//        CGFloat margin= 5 ;
//        self.accountNameLabel.bounds = CGRectMake(0, 0, textSize.width+1, textSize.height+1);
//        self.accountNameLabel.center = CGPointMake(self.center.x, CGRectGetMaxY(self.iconView.frame)+textSize.height);
//        self.levelImageView.bounds = CGRectMake(0, 0, imgW, imgH);
//        self.levelImageView.center = CGPointMake(self.center.x+16.25, CGRectGetMaxY(self.iconView.frame)-16.25);
////        self.accountNameAndLevelView.bounds = CGRectMake(0, 0, self.accountNameLabel.bounds.size.width, self.accountNameLabel.bounds.size.height);
////        self.accountNameAndLevelView.center = CGPointMake(self.center.x, CGRectGetMaxY(self.iconView.frame)+margin*2*SCALE);
//        
//    }else{
//        self.accountNameLabel.hidden = NO ;
//        self.levelImageView.hidden = NO;
//    }
//
//}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setPTableHeaderModel:(PTableHeaderModel *)pTableHeaderModel{
    _pTableHeaderModel = pTableHeaderModel;
    
    
    
    //    self.messageView.count =  pTableHeaderModel.messageCount;
    //收藏商品数
    self.goodsCollect.composeCount = pTableHeaderModel.goodsCollectCount;
    self.shopCollect.composeCount = pTableHeaderModel.shopCollectCount;
    self.attentionBrand.composeCount=pTableHeaderModel.attentionBrandCount;
    self.messageView.messageCount = pTableHeaderModel.messageCount;
    
    self.accountNameLabel.text=pTableHeaderModel.accountName;
    self.levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"level_v%ld",pTableHeaderModel.level]];
    UIImageView * tempImageview = [[UIImageView alloc]init];
    
    [tempImageview sd_setImageWithURL:ImageUrlWithString(pTableHeaderModel.iconUrl)  placeholderImage:[UIImage imageNamed:@"me"]];

    self.iconView.img =tempImageview.image;
    
    
    self.accountNameLabel.text=pTableHeaderModel.accountName;
    
    if (pTableHeaderModel.accountName && pTableHeaderModel.accountName.length>0) {
        //        self.accountNameAndLevelView.hidden=NO;
        self.accountNameLabel.hidden = NO ;
        self.levelImageView.hidden = NO;
        self.accountNameLabel.text = pTableHeaderModel.accountName;
        CGSize textSize = [pTableHeaderModel.accountName stringSizeWithFont:14*SCALE];
        CGFloat imgW = 18*SCALE;
        CGFloat imgH = imgW;
        CGFloat imgX = textSize.width;
        CGFloat imgY = 0 ;
        CGFloat margin= 5 ;
        self.accountNameLabel.bounds = CGRectMake(0, 0, textSize.width+1, textSize.height+1);
        self.accountNameLabel.center = CGPointMake(self.containerView.bounds.size.width*0.5, 79*SCALE+textSize.height);
        self.levelImageView.bounds = CGRectMake(0, 0, imgW, imgH);
        CGFloat iconHalfW = self.containerView.bounds.size.width*0.5;
        CGFloat keyValue = iconHalfW - sqrt(iconHalfW*iconHalfW*0.5) ;
        self.levelImageView.center = CGPointMake(self.containerView.bounds.size.width-keyValue, self.containerView.bounds.size.height-keyValue);
        //        self.accountNameAndLevelView.bounds = CGRectMake(0, 0, self.accountNameLabel.bounds.size.width, self.accountNameLabel.bounds.size.height);
        //        self.accountNameAndLevelView.center = CGPointMake(self.center.x, CGRectGetMaxY(self.iconView.frame)+margin*2*SCALE);
        
    }else{
        self.accountNameLabel.hidden = NO ;
        self.levelImageView.hidden = NO;
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(0, -(self.imgSize.height-self.bounds.size.height), self.imgSize.width, self.imgSize.height);
    

    
    
    
    
    CGFloat iconViewW = 79*SCALE;
    CGFloat iconViewH = iconViewW;
    CGFloat iconViewCenterY = (47.5 + iconViewH*0.5)*SCALE;
    
    
//    CGFloat containerX = 0 ;
//    CGFloat containerY = 0 ;
    CGFloat containerW = iconViewW ;
    CGFloat containerH = iconViewH ;
    
    self.containerView.bounds=CGRectMake(0, 0, containerW, containerH);
    self.containerView.center = CGPointMake(self.center.x, iconViewCenterY);
    self.iconView.layer.cornerRadius = self.iconView.bounds.size.width*0.5;
    self.iconView.layer.masksToBounds=YES;
    self.iconView.layer.borderWidth=2*SCALE;
    self.iconView.layer.borderColor=[UIColor whiteColor].CGColor;
    
    self.iconView.frame = self.containerView.bounds;
    
    //    self.accountName=nil;
    CGFloat w = screenW/4 ;
    CGFloat h = 50*SCALE;
    CGFloat y = self.bounds.size.height-h;
    self.menuView.frame = CGRectMake(0, y, self.bounds.size.width, h);
    for (int i = 0; i<self.menuView.subviews.count ; i++) {
#warning 下面这一行的类要重新自定义
        ActionBaseView * sub = self.menuView.subviews[i];
        sub.frame = CGRectMake(i*w, 0, w, h);
        sub.title = sub.model.title;
        
    }
    CGFloat messageViewW = 18.5*SCALE;
    self.messageView.frame=CGRectMake(self.bounds.size.width-(15.5+messageViewW)*SCALE, 26*SCALE, messageViewW, messageViewW);
    
    /** 模拟模型赋值 */
    self.pTableHeaderModel= [[PTableHeaderModel alloc]init];
}


-(void)addsubviews{
    

    
    //背景图
    ActionBaseView * imgView = [[ActionBaseView   alloc]init];
    imgView.img =[UIImage imageNamed:@"mytmall_atmosphere_default"];
    self.imgView=imgView;
    [self addSubview:self.imgView];
    
    //容器View
    UIView  * containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 79*SCALE, 79*SCALE)];
    self.containerView = containerView;
    [self addSubview:containerView];
    //头像
    ActionBaseView * iconView = [[ActionBaseView alloc]init];
    //    iconView.backgroundColor = randomColor;
    self.iconView=iconView;
    [self.containerView addSubview:self.iconView];
    BaseModel * iconViewModel = [[BaseModel alloc]init];
    iconViewModel.actionKey = ActionAccountInfo;
    iconViewModel.title = @"个人信息";
    iconViewModel.judge=YES;
    self.iconView.model=iconViewModel;
    [iconView addTarget:self action:@selector(componentClick:) forControlEvents:UIControlEventTouchUpInside];
    //昵称&等级 , 不登录时就不显示,所以就采用懒加载
    
    //消息按钮//////////////////////////////////
    ActionBaseView * messageView =[[ActionBaseView alloc]init];
    
    
    
    
//    messageView.img=[UIImage imageNamed:@"SHJ_Collection"];
//    self.messageView=messageView;
//    [messageView addTarget:self action:@selector(componentClick:) forControlEvents:UIControlEventTouchUpInside];
//    BaseModel * messageViewModel = [[BaseModel alloc]init];
//    messageViewModel.actionKey = ActionMessageCenter;
//    messageViewModel.title = @"消息中心";
//    messageViewModel.judge=YES;
//    messageView.model=messageViewModel;
//    [self addSubview:messageView];

    
    [self setupMessageView];
    
    //菜单栏
    UIView * menuView = [[UIView alloc]init];
    menuView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.33];
    self.menuView=menuView;
    [self addSubview:self.menuView];
    
    for (int i = 0; i<4; i++) {
        
        PTableHeaderCompose * sub = nil;
        if (i!=3) {
            sub = [[PTableHeaderCompose alloc]initWithStyle:PTableHeaderComposeNumberStyle];
        }else{
            sub = [[PTableHeaderCompose alloc]initWithStyle:PTableHeaderComposeImageStyle];
        }
        //        sub.backgroundColor = randomColor;
        [menuView addSubview:sub];
        BaseModel * model = [[BaseModel alloc]init];
        switch (i) {
            case 0:
            {
                model.actionKey = ActionGoodsCollect;
                model.title = @"商品收藏";
                sub.composeTitle = model.title;
                self.goodsCollect = sub;
            }
                break;
            case 1:
            {
                model.actionKey = ActionShopCollect;
                model.title = @"店铺收藏";
                sub.composeTitle = model.title;
                self.shopCollect  = sub;
            }
                break;
            case 2:
            {
                model.actionKey = ActionAttentionBrand;
                model.title = @"关注品牌";
                sub.composeTitle = model.title;
                self.attentionBrand =sub;
            }
                break;
            case 3:
            {
                model.actionKey = ActionFootHistory;
                model.title = @"我的足迹";
                sub.composeTitle = model.title;
            }
                break;
            default:
                break;
        }
        model.judge=YES;
        sub.model = model;
        sub.composeCount = 0 ;//默认是0
        [sub addTarget:self action:@selector(componentClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
-(void)setupMessageView
{
    ProfileMessageView * messageView = [[ProfileMessageView alloc]init];
    self.messageView = messageView ;
    [self addSubview:messageView];
    [messageView addTarget:self action:@selector(componentClick:) forControlEvents:UIControlEventTouchUpInside];
    BaseModel * messageViewModel = [[BaseModel alloc]init];
    messageViewModel.actionKey = ActionMessageCenter;
    messageViewModel.title = @"消息中心";
    messageViewModel.judge=YES;
    messageView.model=messageViewModel;

}

@end
