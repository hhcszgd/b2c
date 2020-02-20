//
//  AccountSafeVC.m
//  b2c
//
//  Created by wangyuanfei on 4/7/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "AccountSafeVC.h"
#import "PTableCellModel.h"
@interface AccountSafeVC ()
@property(nonatomic,weak)UIScrollView *  scrollContainer;
@property(nonatomic,assign)CGFloat  maxY ;
@property(nonatomic,weak)UILabel * phoneNumLabel ;
@end

@implementation AccountSafeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollContainer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addScrollContainer
{
    
    UIScrollView * scrollContainer = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY)];
    scrollContainer.delegate=self;
    scrollContainer.backgroundColor=BackgroundGray;
    self.scrollContainer=scrollContainer;
    //    self.scrollContainer.backgroundColor=randomColor;
    [self.view addSubview:self.scrollContainer];
    self.scrollContainer.alwaysBounceVertical = YES;
    
    [self addSubviewOfScrollContainer];
    
}

-(void)addSubviewOfScrollContainer
{
    CGFloat normalRowHeight = 44*SCALE;
//    CGFloat topLineHeight = 3 ;
    CGFloat bottomLineHeight = 2 ;
//    CGFloat topMargin = 6 ;
//    CGFloat rightMargin = 10 ;
    CGFloat W = self.view.bounds.size.width;
    
    
    
    
    
    
    
    ActionBaseView * addressArrow = [[ActionBaseView alloc]init];
    [addressArrow addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
    addressArrow.img=[UIImage imageNamed:@"sen"];
    [self setRowViewWithTitle:@"修改密码" frame:CGRectMake(0, self.maxY, W, normalRowHeight) lineHeight:bottomLineHeight detailView:addressArrow andType:@"image"];
    
    UIView * safeLevel = [[UIView alloc]init];
    [self setRowViewWithTitle:@"修改绑定手机" frame:CGRectMake(0, self.maxY, W, normalRowHeight) lineHeight:bottomLineHeight detailView:safeLevel andType:@"string"];
    ActionBaseView * safeLevelArrow = [[ActionBaseView alloc]init];
    [safeLevelArrow addTarget:self action:@selector(changeNum) forControlEvents:UIControlEventTouchUpInside];
    safeLevelArrow.img=[UIImage imageNamed:@"sen"];
    safeLevelArrow.frame = CGRectMake(safeLevel.bounds.size.width - safeLevel.bounds.size.height, 0, safeLevel.bounds.size.height, safeLevel.bounds.size.height);
    [safeLevel addSubview:safeLevelArrow];
    
    UILabel * phoneNumLabel = [[UILabel alloc]init];
    self.phoneNumLabel=phoneNumLabel;
    phoneNumLabel.textAlignment = NSTextAlignmentRight;
    [safeLevel addSubview:phoneNumLabel];
    phoneNumLabel.frame=CGRectMake(0, 0, safeLevel.bounds.size.width-safeLevel.bounds.size.height, safeLevel.bounds.size.height);
    phoneNumLabel.text=@"188****0446";
    
}

-(void)setRowViewWithTitle:(NSString*)title frame:(CGRect)frame lineHeight:(CGFloat)lineHeight detailView:(UIView*)detailView andType:(NSString*)type
{
    CGFloat leftMargin  =  10 ;
    CGFloat rightMargin = 20 ;
    CGFloat topMargin = 5;
    ActionBaseView * tempView = [[ActionBaseView alloc]initWithFrame:frame];
    tempView.backgroundColor=[UIColor whiteColor];
    [self.scrollContainer addSubview:tempView];
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = BackgroundGray;
    line.frame = CGRectMake(0, 0, tempView.bounds.size.width, lineHeight);
    [tempView addSubview:line];
    
    UILabel * titleLabel=[[UILabel alloc]init];
    [tempView addSubview:titleLabel];
    titleLabel.frame=CGRectMake(leftMargin, lineHeight, frame.size.width/2-leftMargin, frame.size.height-lineHeight);
    titleLabel.text=title;
    
    //    detailView.backgroundColor=randomColor;
    [tempView addSubview:detailView];
    if ([type isEqualToString:@"image"]) {
        CGFloat imgH = tempView.bounds.size.height-2*topMargin-lineHeight;
        CGFloat imgY = topMargin+lineHeight;
        CGFloat imgW = imgH;
        CGFloat imgX = tempView.bounds.size.width - imgW - rightMargin;
        detailView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
    }else if([type isEqualToString:@"string"]){
        detailView.frame = CGRectMake(frame.size.width/2, lineHeight + topMargin, frame.size.width/2-rightMargin, frame.size.height-lineHeight-2*topMargin);
    }
    
    self.maxY+=frame.size.height;
    
    
}

-(CGFloat )maxY{
    if(_maxY==0){
        _maxY = 10;
    }
    return _maxY;
}
-(void)changePassword
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"修改密码")
    PTableCellModel *model = [[PTableCellModel alloc]init];
    model.actionKey = ActionChangePassword;
    model.title = @"修改密码";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
}
-(void)changeNum
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"修改电话")
    PTableCellModel *model = [[PTableCellModel alloc]init];
    model.actionKey = ActionChangePhoneNum;
    model.title = @"修改电话";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
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
