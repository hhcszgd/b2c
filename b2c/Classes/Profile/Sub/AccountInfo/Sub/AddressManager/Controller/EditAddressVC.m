//
//  EditAddressVC.m
//  b2c
//
//  Created by wangyuanfei on 4/6/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "EditAddressVC.h"

#import "AMCell.h"

#import "AMCellModel.h"
#import "AddressManagerVC.h"
@interface EditAddressVC ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,weak)UILabel * nameLabel ;
@property(nonatomic,strong)UITextField * nameInput ;
@property(nonatomic,weak)UILabel * phoneNumberLabel ;
@property(nonatomic,weak)UITextField * phoneNumberInput ;
@property(nonatomic,weak)UILabel * areaLabel ;
@property(nonatomic,weak)UIButton * areaShow ;
//@property(nonatomic,weak)UILabel * streetLabel ;
//@property(nonatomic,weak)UIButton * streetShow ;
@property(nonatomic,weak)UILabel * detailAddressLabel;
@property(nonatomic,weak)UITextField * detailAddressInput ;
@property(nonatomic,weak)UILabel * postalCode ;
@property(nonatomic,weak)UITextField * postalCodeShow ;
@property(nonatomic,strong)NSMutableArray *left  ;
@property(nonatomic,strong)NSMutableArray * right ;
@property(nonatomic,weak)UIPickerView * pickerView ;
@property(nonatomic,strong)NSMutableArray * pickerData ;
@property(nonatomic,copy)NSString *  currentProvince ;
@property(nonatomic,copy)NSString *  currentCity;
@property(nonatomic,copy)NSString * currentArea ;
@property(nonatomic,weak)UIView * subContainer ;

@property(nonatomic,assign)EditAddressVCActionStyle  actionStyle ;
@end

@implementation EditAddressVC
-(instancetype)initWithActionStyle:(EditAddressVCActionStyle)actionStyle{
    if (self=[super init]) {
        self.actionStyle = actionStyle;
    }

    return self;
}
-(void)setActionStyle:(EditAddressVCActionStyle)actionStyle{
    _actionStyle = actionStyle;
    if (actionStyle == Editing) {
            self.naviTitle=@"修改地址";
    }else if (actionStyle == Adding){
            self.naviTitle=@"新增地址";
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor= BackgroundGray;
    [self setupRightBarbuttonItem];

    [self subContainer];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBegainEditing) name:UITextFieldTextDidBeginEditingNotification object:nil];
//
    // Do any additional setup after loading the view.
}
-(void)setupRightBarbuttonItem
{
    ActionBaseView * rightBarButton = [[ActionBaseView alloc]init];
    [rightBarButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton.title=@"完成";
    self.navigationBarRightActionViews = @[rightBarButton];
}

//-(void)textBegainEditing
//{
//    [self pickerViewDown];
//}

-(void)done:(UIBarButtonItem*)sender
{
    for (int i = 0;  i < self.right.count; i++) {
        
        if (i==2) {
            UIButton * btn = self.right[i];
            if (btn.titleLabel.text.length<1) {
                
                UILabel * lbl = self.left[i];
                [self hubWithTitle:lbl.text];
                return;
            }
        }else{
            UITextField * field = self.right[i];
            if (field.text.length<1) {
                UILabel * lbl = self.left[i];
                [self hubWithTitle:lbl.text];
                return;
            }
        }
    }
    AMCellModel * model =[[AMCellModel alloc]init];
    model.name = self.nameInput.text;
    model.phoneNumber=self.phoneNumberInput.text;
    model.postalCode=self.postalCodeShow.text;
    //    model.area = self.areaShow.titleLabel.text;
    model.province=self.currentProvince;//TODO
    //    model.province = self.pro
    model.city=self.currentCity;
    model.area=self.currentArea;
    //    model.street=self.streetShow.titleLabel.text;
    model.detailAddress=self.detailAddressInput.text;
    if (self.actionStyle==Editing) {
        
        self.editingCell.model=model;
        
        LOG(@"_%@_%d_%@",[self class] , __LINE__,model.name)
        if ([self.delegate respondsToSelector:@selector(endEditingAddtess:andEditingCell:)]) {
            [self.delegate endEditingAddtess:self andEditingCell:self.editingCell];
        }
        
    }else{
        if ([self.delegate respondsToSelector:@selector(addAddressWithModel:)]) {
            [self.delegate addAddressWithModel:model];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)hubWithTitle:(NSString * ) title
{
    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.mode=MBProgressHUDModeText;
    hub.labelText=[NSString stringWithFormat:@"请输入 %@",title];
    [hub hide:YES afterDelay:2];
    
}

-(UIView * )subContainer{
    if(_subContainer==nil){
        UIView * subContainer  = [[UIView alloc]init];
        self.subContainer=subContainer;
        [self.view addSubview:subContainer];
        [self addSubviews];
        [self layoutMySubviews];
        _subContainer = subContainer;
    }
    return _subContainer;
}

-(void)addSubviews
{
    UILabel * nameLabel  = [[UILabel alloc]init];
    self.nameLabel=nameLabel;
    [self.view addSubview:self.nameLabel];
    [self.left addObject:self.nameLabel];
    nameLabel.text = @"收货人姓名";
    
    
    UITextField * nameInput =[[UITextField alloc]init];
    self.nameInput=nameInput;
    [self.view addSubview:self.nameInput];
    [self.right addObject:self.nameInput];
    [self setBorderWithView:nameInput andBackgroundcolor:[UIColor colorWithWhite:4.0 alpha:1]];
    
    
    UILabel * phoneNumberLabel = [[UILabel alloc]init] ;
    self.phoneNumberLabel = phoneNumberLabel;
    [self.view addSubview:self.phoneNumberLabel];
    [self.left addObject:self.phoneNumberLabel];
    phoneNumberLabel.text=@"手机号码";
    
    UITextField * phoneNumberInput =[[UITextField alloc]init];
    self.phoneNumberInput=phoneNumberInput;
    [self.view addSubview:self.phoneNumberInput];
    [self.right addObject:self.phoneNumberInput];
    [self setBorderWithView:phoneNumberInput andBackgroundcolor:[UIColor colorWithWhite:4.0 alpha:1]];
    self.phoneNumberInput.keyboardType = UIKeyboardTypeNumberPad;
    
    UILabel * areaLabel  = [[UILabel alloc]init];
    self.areaLabel=areaLabel;
    [self.view addSubview:self.areaLabel];
    [self.left addObject:self.areaLabel];
    areaLabel.text=@"所在区域";
    
    UIButton * areaShow =[[UIButton alloc]init] ;
    self.areaShow=areaShow;
    [self.view addSubview:self.areaShow];
    [self.right addObject:self.areaShow];
    [self setBorderWithView:areaShow andBackgroundcolor:[UIColor whiteColor]];
    [self.areaShow setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.areaShow setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [areaShow addTarget:self action:@selector(chooseArea:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * detailAddressLabel = [[UILabel alloc]init];
    self.detailAddressLabel=detailAddressLabel;
    [self.view addSubview:self.detailAddressLabel];
    [self.left addObject:self.detailAddressLabel];
    detailAddressLabel.text=@"详细地址";
    
    UITextField * detailAddressInput =[[UITextField alloc]init];
    self.detailAddressInput = detailAddressInput;
    [self.view addSubview:self.detailAddressInput];
    [self.right addObject:self.detailAddressInput];
    [self setBorderWithView:detailAddressInput andBackgroundcolor:[UIColor colorWithWhite:4.0 alpha:1]];
    
    
    UILabel * postalCode  = [[UILabel alloc]init];
    self.postalCode=postalCode;
    [self.view addSubview:self.postalCode];
    [self.left addObject:self.postalCode];
    postalCode.text=@"邮政编码";
    
    
    UITextField * postalCodeShow =[[UITextField alloc]init];
    self.postalCodeShow=postalCodeShow;
    [self.view addSubview:self.postalCodeShow];
    [self.right addObject:self.postalCodeShow];
    [self setBorderWithView:postalCodeShow andBackgroundcolor:[UIColor whiteColor]];
    [self setLeftTextAttribut];
    self.postalCodeShow.keyboardType = UIKeyboardTypeNumberPad;
}
-(void)setLeftTextAttribut
{
    for (UILabel*label in self.left) {
        label.textColor=[UIColor grayColor];
        label.font=[UIFont systemFontOfSize:14];
    }
}
-(void)setBorderWithView:(UIView *)view andBackgroundcolor:(UIColor*)color
{
    view.layer.borderColor=[UIColor lightGrayColor].CGColor;
    view.layer.borderWidth=0.50;
    view.backgroundColor=color;
    view.layer.cornerRadius=2.50;
    view.layer.masksToBounds=YES;
}
-(void)layoutMySubviews
{
    CGFloat margin = 10 ;
    CGFloat h = 36 ;
    CGFloat leftW = 90 ;
    CGFloat rightW = screenW - margin*3 - leftW;
    
    for (int i = 0; i< self.left.count; i++) {
        UIView * view = ( UIView *  )self.left[i];
        view.frame=CGRectMake(margin, i*(margin+h)+margin+67, leftW, h);
    }
    for (int i = 0 ; i< self.right.count; i++) {
        UIView * view = ( UIView *  )self.right[i];
        view.frame=CGRectMake(margin+leftW+margin, i*(margin+h)+margin+67, rightW, h);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma lazylog
-(NSMutableArray * )left{
    if(_left==nil){
        _left = [[NSMutableArray alloc]init];
    }
    return _left;
}
-(NSMutableArray * )right{
    if(_right==nil){
        _right = [[NSMutableArray alloc]init];
    }
    return _right;
}

-(void)setEditingCell:(AMCell *)editingCell{
        [self subContainer];
    _editingCell=editingCell;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,editingCell.model.city)
    _nameInput.text = editingCell.model.name;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,    self.areaShow)
    [self.areaShow setTitle:[NSString stringWithFormat:@"%@%@%@",editingCell.model.province,editingCell.model.city,editingCell.model.area] forState:UIControlStateNormal];
    self.phoneNumberInput.text =editingCell.model.phoneNumber;
    self.detailAddressInput.text=editingCell.model.detailAddress;
    self.postalCodeShow.text=editingCell.model.postalCode;
    self.currentProvince=editingCell.model.province;
    self.currentCity = editingCell.model.city;
    self.currentArea = editingCell.model.area;
    
}
-(void)chooseArea:(UIButton*)sender
{

    [self.view endEditing:YES];
    //选择省份, 跳出新的控制器TODO
    
}
-(void)dealloc{
    LOG(@"_%@_%d_dealloc%@",[self class] , __LINE__,self)
}

/*
-(UIPickerView * )pickerView{
    if(_pickerView==nil){
        CGFloat pickerHeight = screenW/2;
        //        UIPickerView * pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, screenH-pickerHeight, screenW, pickerHeight)];
        UIPickerView * pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, screenH, screenW, pickerHeight)];
        pickerView.backgroundColor=randomColor;
        pickerView.dataSource = self;
        pickerView.delegate=self;
        [self.view addSubview:pickerView];
        _pickerView = pickerView;
    }
    return _pickerView;
}


-(void)pickerViewUp
{
    [UIView animateWithDuration:0.2 animations:^{
        self.pickerView.mj_y = screenH - self.pickerView.bounds.size.height;
    }];
}
-(void)pickerViewDown
{
    [UIView animateWithDuration:0.2 animations:^{
        self.pickerView.mj_y = screenH;
    }];
}
-(NSMutableArray * )pickerData{
    if(_pickerData==nil){
        NSMutableArray * arrM = [NSMutableArray array];
        if (YES) {
            for (int i = 0 ; i < 5; i++) {
                NSString * province  = [NSString stringWithFormat:@"省%d",i];
                NSMutableArray * cities = [NSMutableArray array];
                for (int j = 0; j < 10; j++) {
                    NSString * city = [NSString stringWithFormat:@"市%d" ,j];
                    NSMutableArray * areas = [NSMutableArray array];
                    for (int k = 0 ; k<15; k++) {
                        NSString * area = [NSString stringWithFormat:@"区%d",k];
                        NSDictionary * areaDic = @{
                                                   @"area":area
                                                   };
                        [areas addObject:areaDic];
                    }
                    NSDictionary * cityDic = @{
                                               @"city":city,
                                               @"areas":areas
                                               };
                    [cities addObject:cityDic];
                }
                NSDictionary * provinceDic = @{
                                               @"province" : province ,
                                               @"cities": cities
                                               };
                [arrM addObject:provinceDic];
            }
            
        }else{
            
        }
        _pickerData = arrM;
    }
    return _pickerData;
}
#pragma pickerViewDagasource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3 ;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component==0) {
        return self.pickerData.count;
        
    }else if (component==1){
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSDictionary * provinceDic =  self.pickerData[rowProvince];
        NSArray * provinceCities = provinceDic[@"cities"];
        
        return provinceCities.count;
    }else{
        NSInteger rowProvince=[pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        
        NSDictionary * provinceDic =  self.pickerData[rowProvince];
        NSArray * provinceCities = provinceDic[@"cities"];
        
        NSDictionary * cityDic = provinceCities[rowCity];
        NSArray * areas = cityDic[@"areas"];
        return areas.count;
        
    }
    
}
#pragma delegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    //    return streetDic[@"street"];
    
    
    if (component==0) {
        NSDictionary * provinceDic =  self.pickerData[row];
        NSString * province = provinceDic[@"province"];
        return province;
    }else if (component==1){
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSDictionary * provinceDic =  self.pickerData[rowProvince];
        NSArray * provinceCities = provinceDic[@"cities"];
        NSDictionary * cityDic = provinceCities[row];
        NSString * city = cityDic[@"city"];
        return city;
    }else{
        NSInteger rowProvince=[pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        
        NSDictionary * provinceDic =  self.pickerData[rowProvince];
        NSArray * provinceCities = provinceDic[@"cities"];
        
        NSDictionary * cityDic = provinceCities[rowCity];
        NSArray * areas = cityDic[@"areas"];
        
        NSDictionary * areaDic = areas[row];
        NSString * area = areaDic[@"area"];
        return area;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        
    }else if (component==1){
        
        [pickerView selectRow:0 inComponent:2 animated:NO];
    }
    
    [pickerView reloadComponent:1];
    [pickerView reloadComponent:2];
    [self.areaShow setTitle:[NSString stringWithFormat:@"%@/%@/%@",self.currentProvince,self.currentCity,self.currentArea] forState:UIControlStateNormal];
}

-(NSString *)currentProvince{
    
    NSInteger rowProvince=[self.pickerView selectedRowInComponent:0];
    NSDictionary * provinceDic =  self.pickerData[rowProvince];
    NSString * province = provinceDic[@"province"];
    return province;
    
}

-(NSString *)currentCity{
    NSInteger rowProvince=[self.pickerView selectedRowInComponent:0];
    NSInteger rowCity = [self.pickerView selectedRowInComponent:1];
    NSDictionary * provinceDic =  self.pickerData[rowProvince];
    NSArray * provinceCities = provinceDic[@"cities"];
    NSDictionary * cityDic = provinceCities[rowCity];
    NSString * city = cityDic[@"city"];
    return city;
    
}
-(NSString *)currentArea{
    NSInteger rowProvince=[self.pickerView selectedRowInComponent:0];
    NSInteger rowCity = [self.pickerView selectedRowInComponent:1];
    NSInteger rowArea = [self.pickerView selectedRowInComponent:2];
    NSDictionary * provinceDic =  self.pickerData[rowProvince];
    NSArray * provinceCities = provinceDic[@"cities"];
    NSDictionary * cityDic = provinceCities[rowCity];
    NSArray * areas = cityDic[@"areas"];
    NSDictionary * areaDic = areas[rowArea];
    NSString * area = areaDic[@"area"];
    return area;
}
//
//-(void)initializationPickerView
//{
//    for (int i = 0 ; i<self.pickerData.count; i++) {
//        NSDictionary * provinceDic =  self.pickerData[i];
//        NSString * province = provinceDic[@"province"];
//        if ([self.editingCell.model.province isEqualToString:province]) {
//            LOG(@"_%@_%d_%d",[self class] , __LINE__,i)
//            [self.pickerView selectRow:i inComponent:0 animated:YES];
//            NSArray * provinceCities = provinceDic[@"cities"];
//            for (int j = 0 ; j<provinceCities.count; j++) {
//                NSDictionary * cityDic = provinceCities[j];
//                NSString * city = cityDic[@"city"];
//                if ([self.editingCell.model.city isEqualToString:city]) {
//                    LOG(@"_%@_%d_%d",[self class] , __LINE__,j)
//                    [self.pickerView selectRow:j inComponent:1 animated:YES];
//                    NSArray * areas = cityDic[@"areas"];
//                    for (int k = 0 ; k<areas.count; k++) {
//                        NSDictionary * areaDic  =  areas[k];
//                        NSString * area =areaDic[@"area"];
//                        if ([self.editingCell.model.area isEqualToString:area]) {
//                            LOG(@"_%@_%d_%d",[self class] , __LINE__,k)
//                            [self.pickerView selectRow:k inComponent:2 animated:YES];
//                        }
//                    }
//                }
//            }
//        }
//        
//    }
//}
 */


@end
