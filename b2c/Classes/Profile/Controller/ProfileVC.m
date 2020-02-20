//
//  ProfileVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ProfileVC.h"
#import "PTableView.h"
#import "BaseCell.h"
#import "PBackgroundVC.h"
#import "POrderCell.h"
#import "PAssetsCell.h"
#import "PNormalCell.h"
#import "PTableCellModel.h"
#import "PTableHeaderModel.h"

@interface ProfileVC ()<PTableViewDelegate,PBaseCellDelegate>
@property(nonatomic,assign)CGPoint  targetPoint;
@property(nonatomic,strong)NSArray * profileData ;
@property(nonatomic,copy)NSString * goodsCollectCount ;
@property(nonatomic,copy)NSString * shopCollectCount ;
@property(nonatomic,copy)NSString * attentionBrandCount ;
@property(nonatomic,weak)PTableView * tempTableView ;

@property(nonatomic,assign)BOOL redPointShow ;

@end

@implementation ProfileVC
-(void)gotProfiledata
{
    
    
    [[UserInfo shareUserInfo] gotProfileDataSuccess:^(ResponseObject * responseObject) {
        NSDictionary * imgDic = responseObject.data[@"headImage"];
        NSString * imgUrl = imgDic[@"url"];//取出未用
        /** tableHeader上的商品,店铺,足迹等模块儿 */
        NSDictionary * navDic = responseObject.data[@"nav"];
        if (navDic) {
            NSDictionary * goodscollect = navDic[@"goodscollect"];
            self.goodsCollectCount = goodscollect[@"num"];
            
            NSDictionary * shopcollect = navDic[@"shopcollect"];
            self.shopCollectCount = shopcollect[@"num"];
            
            NSDictionary * focusbrand = navDic[@"focusbrand"];
            self.attentionBrandCount = focusbrand[@"num"];
            PTableHeaderModel * tempModel = [[PTableHeaderModel alloc]init];
            tempModel.goodsCollectCount = self.goodsCollectCount.integerValue;
            tempModel.shopCollectCount = self.shopCollectCount.integerValue;
            tempModel.attentionBrandCount = self.attentionBrandCount.integerValue;
            tempModel.iconUrl = imgUrl;
            self.tempTableView.tableHeaderModel = tempModel;
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,self.goodsCollectCount)
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,self.shopCollectCount)
//            LOG(@"_%@_%d_%@",[self class] , __LINE__, self.attentionBrandCount)
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data)
        }

        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
    }];
}
/**当个人中心需要根据self.redPointShow改变小红点时调一下这个方法 */
-(void)changeRedPointState
{
    NSDictionary * userinfo = @{@"state":@(self.redPointShow)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ProfileRedPointShow" object:nil userInfo:userinfo];
}

- (void)viewDidLoad {
    [self gotProfiledata];
    
    [super viewDidLoad];
    [self setupTableView];
    // Do any additional setup after loading the view.
    [self changeRedPointState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupTableView
{
    CGRect frame  = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
    PTableView * tableView =[[PTableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    self.tableView =tableView;
    self.tempTableView = tableView;
    tableView.PTableViewDelegate=self;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight=200;
//    CGFloat tableViewTopViewW = self.view.bounds.size.width;
//    CGFloat tableViewTopViewH = screenH-200;
//    CGFloat tableViewTopViewY = -tableViewTopViewH;
//    CGFloat tableViewTopViewX = 0;
//    UIImageView * tableViewTopView = [[UIImageView alloc]initWithFrame:CGRectMake(tableViewTopViewX, tableViewTopViewY, tableViewTopViewW, tableViewTopViewH)];
//    tableViewTopView.backgroundColor=[UIColor redColor];
//    tableViewTopView.image=[UIImage imageNamed:@"mytmall_atmosphere_default"];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.profileData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PBaseCell * cell = nil ;
    NSString * reuseIdentifier = nil ;
    PTableCellModel * model = self.profileData[indexPath.row];
    switch (indexPath.row) {
        case 0:
            reuseIdentifier = @"POrderCell";
            break;
        case 1:
             reuseIdentifier = @"PAssetsCell";
            break;
        default:
             reuseIdentifier = @"PNormalCell";
            break;
    }
    
    cell =  [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        Class class = NSClassFromString(reuseIdentifier);
        cell = [[class alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    [cell setValue:model forKey:@"cellModel"];
    cell.PCellDelegate=self;
    return cell;
}
#pragma  cell和tableHeader子控件的点击代理
-(void)actionWithModel:(BaseModel *)model{
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];

}

-(CGPoint)targetPoint{
    return CGPointMake(self.view.center.x, 200);
}

-(void)test
{
    UIImage * img = [UIImage imageNamed:@"ar_back"];
    NSData * data = UIImagePNGRepresentation(img);
    
    
}
-(NSArray *)profileData{
    if (!_profileData) {
        NSMutableArray * arrM = [NSMutableArray arrayWithCapacity:6];
        for (int i = 0 ; i<6; i++) {
            PTableCellModel * model = [[PTableCellModel alloc]init];
            
            switch (i) {
                case 0:
                {
                    model  = [[PTableCellModel alloc]init];
                    model.leftTitle =[NSString stringWithFormat:@"全部订单"];
                    model.actionKey = ActionTotalOrder;
                    model.judge=YES;
                    model.rightDetailTitle = @"查看全部订单";
                }
                    break;
                case 1:
                {
                    model  = [[PTableCellModel alloc]init];
                    model.leftTitle = @"我的资产";
                    model.actionKey = ActionAssets;
                    model.judge=YES;
                    model.rightDetailTitle = @"查看全部资产";
                }
                    break;
                case 2:
                {
                    model  = [[PTableCellModel alloc]init];
                    model.leftTitle =@"我的活动";
                    model.actionKey = ActionMyExercise;
                    model.judge=YES;
                    model.leftImage = [UIImage imageNamed:@"icon_activity"];
                }
                    break;
                case 3:
                {
                    model  = [[PTableCellModel alloc]init];
                    model.leftTitle =@"设置";
                    model.actionKey = ActionSetting;
                    model.judge=NO;
                    model.leftImage = [UIImage imageNamed:@"icon_set up"];
                }
                    break;
                case 4:
                {
                    model= [[PTableCellModel alloc]init];
                    model.leftTitle =@"帮助中心";
                    model.actionKey = ActionHelpCenter;
                    model.judge=YES;
                    model.leftImage = [UIImage imageNamed:@"icon_help"];
                  
                }
                    break;
                case 5:
                {
                    model  = [[PTableCellModel alloc]init];
                    model.leftTitle =@"咨询与反馈";
                    model.actionKey = ActionHelpFeedBack;
                    model.judge=YES;
                    model.leftImage = [UIImage imageNamed:@"icon_consultation"];
                   
                }
                    break;
                default:
                    break;
            }
            [arrM addObject:model];
        }
        _profileData=arrM.copy;
    }

    return _profileData;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self resetDataInProfile];
   }

-(void)resetDataInProfile
{
    
    if ([UserInfo shareUserInfo].isLogin) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"登录状态")
        [self gotProfiledata];
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"未登录状态")
        PTableHeaderModel * tempModel = [[PTableHeaderModel alloc]init];
        self.tempTableView.tableHeaderModel = tempModel;
        [self.tableView reloadData];
    }

}


@end
