//
//  LoginVC.m
//  TTmall
//
//  Created by wangyuanfei on 2/18/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import "LoginVC.h"
//#import "RegisterVC.h"
@interface LoginVC ()<UITableViewDelegate , UITableViewDataSource>
/** 用户名输入提示 */
@property(nonatomic,weak)UILabel * accountName ;
/** 用户名输入框 */
@property(nonatomic,weak)UITextField * accountInput ;
/** 选择用户名下拉箭头 */
@property(nonatomic,weak)UIButton * chooseAccount ;
/** 待选用户名视图 */
@property(nonatomic,weak)UITableView * accountsView ;
/** 盛放所有用户名的数组 这个需要本地存储在这台设备上登录过的用户名*/
@property(nonatomic,strong)NSMutableArray * accounts ;
/** 密码输入提示 */
@property(nonatomic,weak)UILabel * password ;
/** 密码输入框 */
@property(nonatomic,weak)UITextField * passwordInput ;
/** 密码可见性按钮 */
@property(nonatomic,weak)UIButton * eyeable ;
/** 登录按钮 */
@property(nonatomic,weak)UIButton * login ;
/** 其他账户登录 */
@property(nonatomic,weak)UIButton * otherAccountLogin ;
/** 找回密码 */
@property(nonatomic,weak)UIButton * forgetPassword ;
/** 注册 */
@property(nonatomic,weak)UIButton * registerButton ;
/** 下半部分控件的容器控件, 方便整体下移 */
@property(nonatomic,weak)UIView * bottomContainer ;
/**
 UIView * accountContainer = [[UIView alloc]init];
 UIView * passwordContainer = [[UIView alloc]init];
 */
@property(nonatomic,strong)  MASConstraint * accountsViewHeight ;
@property(nonatomic,weak) UIView * accountContainer  ;
@property(nonatomic,weak) UIView * passwordContainer  ;
@property(nonatomic,strong)  MASConstraint * changeConstraint  ;
@end

@implementation LoginVC

- (void)viewDidLoad {

    [super viewDidLoad];
    self.naviTitle = @"登录";
    UIView * backBtnContainer = [[UIView alloc]init];
    ActionBaseView * btn = [[ActionBaseView alloc]init];
    btn.bounds=CGRectMake(0, 0, 26, 26);
    [btn addTarget:self action:@selector(dismissLogin) forControlEvents:UIControlEventTouchUpInside];
    [backBtnContainer addSubview:btn];
    btn.img=[UIImage imageNamed:@"ar_back"];
    self.navigationBarLeftActionViews = @[backBtnContainer];
    btn.center=backBtnContainer.center;
    self.view.backgroundColor= BackgroundGray;
    [self setupSubviews];
    [self laysubview];
}
-(void)dismissLogin
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
/** 导航栏下的细横线 */
-(void)testNaviBar
{
    
    UIView * test =[[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, screenW, 3) ];
    test.backgroundColor=[UIColor greenColor];
    [self.navigationController.navigationBar addSubview:test];
}


#pragma 添加子控件
-(void)setupSubviews
{
    UITableView * accountsView = [[UITableView alloc]init];
    self.accountsView=accountsView;
    accountsView.backgroundColor = BackgroundGray;
    [self.view addSubview:accountsView];
    accountsView.dataSource=self;
    accountsView.delegate=self;
    
    UIView * bottomContainer = [[UIView alloc]init];
    [self.view addSubview:bottomContainer];
    bottomContainer.backgroundColor=BackgroundGray;
    self.bottomContainer=bottomContainer;
    
    UIView * accountContainer = [[UIView alloc]init];
    accountContainer.backgroundColor = [UIColor whiteColor];
    self.accountContainer=accountContainer;
    [self.view addSubview:accountContainer];
    
    UIView * passwordContainer = [[UIView alloc]init];
    passwordContainer.backgroundColor=[UIColor whiteColor];
    self.passwordContainer=passwordContainer;
    [self.bottomContainer addSubview:passwordContainer];
    
    UILabel * accountName = [[UILabel alloc]init];
    accountName.text=@"账户";
    //    accountName.backgroundColor = randomColor;
    [self.accountContainer addSubview:accountName];
    self.accountName=accountName;
    
    UITextField * accountInput = [[UITextField alloc]init];
    
    accountInput.placeholder=@"请输入用户名";
    accountInput.text=@"chuck";
    //    accountInput.backgroundColor = randomColor;
    [self.accountContainer addSubview:accountInput];
    self.accountInput=accountInput;
    
    UIButton * chooseAccount = [[UIButton alloc]init];
    //    chooseAccount.backgroundColor = randomColor;
    [chooseAccount addTarget:self action:@selector(chooseAccountClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.accountContainer addSubview:chooseAccount];
    self.chooseAccount= chooseAccount;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    
    
    UILabel * password = [[UILabel alloc]init];
    password.text=@"登录密码";
    
    //    password.backgroundColor = randomColor;
    [self.passwordContainer addSubview:password];
    self.password=password;
    
    UITextField * passwordInput = [[UITextField alloc]init];
    passwordInput.secureTextEntry=YES;
    passwordInput.placeholder = @"请输入密码";
    passwordInput.text=@"123456";
    //    passwordInput.backgroundColor = randomColor;
    [self.passwordContainer addSubview:passwordInput];
    self.passwordInput = passwordInput;
    
    UIButton * eyeable = [[UIButton alloc]init];
    //    [eyeable setImage:[UIImage imageNamed:@"yan bi he "] forState:UIControlStateNormal];
    //    [eyeable setImage:[UIImage imageNamed:@"yan zheng kai "] forState:UIControlStateSelected];
    //    eyeable.backgroundColor = randomColor;
    [eyeable addTarget:self action:@selector(eyeableClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.passwordContainer addSubview:eyeable];
    self.eyeable=eyeable;
    
    UIButton*login = [[UIButton alloc]init];
    login.layer.cornerRadius = 5 ;
    login.layer.masksToBounds= YES;
    //    [login setBackgroundImage:[UIImage imageNamed:@"zheng chang zhuang tai bei jing tu "] forState:UIControlStateNormal];
    //    [login setBackgroundImage:[UIImage imageNamed:@"bu ke dian ji bei jing tu "] forState:UIControlStateDisabled];
    login.enabled = NO;
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setTitle:@"取消" forState:UIControlStateSelected];
    login.backgroundColor = [UIColor redColor];
    [login addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomContainer addSubview:login];
    self.login=login;
    
    UIButton * otherAccountLogin = [[UIButton alloc]init];
    [otherAccountLogin.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [otherAccountLogin setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [otherAccountLogin setTitle:@"第三方登录" forState: UIControlStateNormal];
    //    otherAccountLogin.backgroundColor = randomColor;
    [otherAccountLogin addTarget:self action:@selector(otherAccountLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomContainer addSubview:otherAccountLogin];
    self.otherAccountLogin=otherAccountLogin;
    
    UIButton * forgetPassword = [[UIButton alloc]init];
    [forgetPassword setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [forgetPassword.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [forgetPassword setTitle:@"找回密码" forState:UIControlStateNormal];
    //    forgetPassword.backgroundColor = randomColor;
    [forgetPassword addTarget:self action:@selector(forgetPasswordClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomContainer addSubview:forgetPassword];
    self.forgetPassword=forgetPassword;
    
    UIButton * registerButton = [[UIButton alloc]init];
    [registerButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    registerButton.layer.borderColor = [UIColor redColor].CGColor;
    registerButton.layer.borderWidth = 1.0;
    registerButton.layer.cornerRadius= 5 ;
    registerButton.layer.masksToBounds=YES;
    [registerButton setTitle:@"免费注册" forState:UIControlStateNormal];
    //    registerButton.backgroundColor = randomColor;
    [registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomContainer addSubview:registerButton];
    self.registerButton = registerButton;
    
    
}
-(void)changeButtonStateWithButton:(UIButton *)button Title:(NSString*)title titleColor:(UIColor *)titleColor titleFontSize:(CGFloat)fontSize
{
    
}
#pragma 布局子控件
-(void)laysubview
{
    CGFloat compnentH=44;
//    CGFloat accountAndPasswordW=64.0;
    CGFloat topMargin = 16;
    [self.accountContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(topMargin+64);
        //        make.width.equalTo(@(screenW));
        make.height.equalTo(@(compnentH));
    }];
    
    [self.accountName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountContainer).offset(28);
        make.top.bottom.equalTo(self.accountContainer);
        make.width.equalTo(@80);
    }];
    
    [self.chooseAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(_accountContainer);
        make.width.height.equalTo(@(compnentH));
    }];
    
    [self.accountsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountName.mas_right);
        make.right.equalTo(self.accountContainer);
        make.top.equalTo(self.accountContainer.mas_bottom);
        MASConstraint * accountsViewHeight = make.height.equalTo(@0);
        self.accountsViewHeight = accountsViewHeight;
    }];
    
    [self.bottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.accountContainer);
        MASConstraint * changeConstraint =  make.top.equalTo(self.accountsView.mas_bottom);
        self.changeConstraint = changeConstraint;
        //        make.width.equalTo(@(screenW));
        make.height.equalTo(@(screenW));
    }];
    
    [self.accountInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountName.mas_right);
        make.top.bottom.equalTo(self.accountContainer);
        make.right.equalTo(self.chooseAccount.mas_left);
    }];
    
    [self.passwordContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.bottomContainer);
        make.height.equalTo(self.accountContainer);
    }];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordContainer).offset(28);
        make.top.bottom.equalTo(self.passwordContainer);
        make.width.equalTo(self.accountName.mas_width);
    }];
    
    [self.eyeable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.passwordContainer);
        make.width.equalTo(self.passwordContainer.mas_height);
    }];
    
    [self.passwordInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.passwordContainer);
        make.left.equalTo(self.password.mas_right);
        make.right.equalTo(self.eyeable.mas_left);
    }];
    
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordContainer.mas_bottom).offset(30);
        make.left.equalTo(self.bottomContainer).offset(20);
        make.right.equalTo(self.bottomContainer).offset(-20);
        make.height.equalTo(self.accountContainer.mas_height);
    }];
    
    [self.otherAccountLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.login);
        make.top.equalTo(self.login.mas_bottom).offset(10);
    }];
    
    [self.forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.login).offset(10);
        make.top.equalTo(self.otherAccountLogin);
        
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.login.mas_centerX);
        make.top.equalTo(self.otherAccountLogin.mas_bottom).offset(44);
        make.width.equalTo(@100);
        make.height.equalTo(@36);
    }];
}

#pragma ButtonClick
-(void)chooseAccountClick:(UIButton*)sender
{
    
    CGFloat accountsViewHeight   = self.accounts.count>1 ? 88 : 44;
    sender.selected=!sender.selected;
    if (sender.selected) {
        self.accountsViewHeight.mas_equalTo(accountsViewHeight);
        [UIView animateWithDuration:0.2 animations:^{
            //            [self.accountsView layoutIfNeeded];
            [self.bottomContainer layoutIfNeeded];
        }];
    }else{
        self.accountsViewHeight.mas_equalTo(0);
        [UIView animateWithDuration:0.2 animations:^{
            [self.accountsView layoutIfNeeded];
            [self.bottomContainer layoutIfNeeded];
        }];
    }
    LOG_METHOD
}
-(void)eyeableClick:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        self.passwordInput.secureTextEntry=NO;
        //点击之后图片显示眼睛睁开
    }else{
        
        self.passwordInput.secureTextEntry=YES;
        //点击之后图片显示眼睛闭合
    }
    LOG_METHOD
}
-(void)loginClick:(UIButton *)sender
{
    [self saveAccountName];
    
    sender.selected=!sender.selected;
    if (sender.selected) {
        //
        [self performLogin];
        //        [self testInit];
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击了登录, 现在显示 取消  ")
        [self.view endEditing:YES];
    }else{
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击了取消, 现在显示 登录")
    }
}



-(void)performLogin
{
    [[UserInfo shareUserInfo] initialization];
    [UserInfo shareUserInfo].name = self.accountInput.text;
    [UserInfo shareUserInfo].password=self.passwordInput.text;
    [[UserInfo shareUserInfo] loginSuccess:^(ResponseStatus response) {
        if (response==LOGIN_SUCCESS) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else if (response ==LOGIN_WRONG_USERNAME_PWD){
            //用户名或密码不正确
            MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hub.mode=MBProgressHUDModeText;
            hub.labelText=@"用户名或密码不正确";
            self.login.selected = NO;
//            [self.login setTitle:@"登录" forState:UIControlStateNormal];
            
            [hub hide:YES afterDelay:1.5];

        }
        
        

    } failure:^(NSError *error) {

        
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
    }];
}



-(void)otherAccountLoginClick:(UIButton *)sender
{
    
    
#warning 弹出新的 第三方登录控制器 TODO
    [self.view endEditing:YES];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行第三方登录 , 待完成")
}
-(void)forgetPasswordClick:(UIButton *)sender
{
#warning 弹出新的 找回密码控制器 TODO
    [self.view endEditing:YES];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行找回密码 , 待完成")
}
-(void)registerButtonClick:(UIButton *)sender
{
#warning 弹出新的 注册控制器 TODO
    [self.view endEditing:YES];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行新用户注册 , 待完成")
    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:@"注册" action:@"RegisterVC"];
}


#pragma about TableView method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger  i = self.accounts.count;
    return i;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identy = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    cell.backgroundColor = BackgroundGray ;
    NSString * accountName = self.accounts[indexPath.row];//[@"userName"] ;
    cell.textLabel.text = accountName;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (![cell.textLabel.text isEqualToString:self.accountInput.text]) {
        self.passwordInput.text = nil;
    }
    self.accountInput.text = cell.textLabel.text;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self textChange:nil];
    
    [self.passwordInput becomeFirstResponder];
    
    self.accountsViewHeight.mas_equalTo(0);
    [UIView animateWithDuration:0.2 animations:^{
        self.chooseAccount.selected = NO;
        [self.accountsView layoutIfNeeded];
        [self.bottomContainer layoutIfNeeded];
    }];
}

#pragma lazyLoad
-(NSMutableArray * )accounts{
    if(_accounts==nil){
        //从沙盒里去取

            _accounts = [[NSMutableArray alloc]init];

    }
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString * filePath = [path stringByAppendingPathComponent:@"accounts.plist"];
    NSMutableArray * tempArrM = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    if (tempArrM) {
        _accounts = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    }
    return _accounts;
}

-(void)saveAccountName
{
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString * filePath = [path stringByAppendingPathComponent:@"accounts.plist"];
    NSMutableArray * arrM = [NSMutableArray arrayWithArray:self.accounts];
    for (NSString*target in arrM) {
        if ([target isEqualToString:self.accountInput.text])  return;
    }

    [arrM insertObject:self.accountInput.text atIndex:0] ;
    [arrM writeToFile:filePath atomically:YES];
    [self.accountsView reloadData];
}
-(void)textChange:(NSNotification*)noti
{
    
    if (self.accountInput.text.length>0&&self.passwordInput.text.length>0) {
        self.login.enabled=YES;
    }else{
        self.login.enabled=NO;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.view endEditing:YES];
}
@end
