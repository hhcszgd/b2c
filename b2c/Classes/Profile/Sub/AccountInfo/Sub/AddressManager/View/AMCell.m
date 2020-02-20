//
//  AMCell.m
//  TTmall
//
//  Created by wangyuanfei on 3/3/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import "AMCell.h"
#import "AMCellModel.h"

@interface AMCell ()
/** 上部控件容器视图 */
@property(nonatomic,weak)UIView * topContainerView ;
/** 展示姓名的label */
@property(nonatomic,weak)UILabel * nameLabel ;
/** 显示手机号码的label */
@property(nonatomic,weak)UILabel * phoneNumberLabel ;
/** 是否是默认地址的标志 */
@property(nonatomic,weak)UILabel * defaultTag ;
/** 高度动态变化的详细地址 */
@property(nonatomic,weak)UILabel * areaLabel ;
/** 底部控件的容器视图 */
@property(nonatomic,weak)UIView * bottomContainerView ;
/** 中间分割线 */
@property(nonatomic,weak)UIView * midSeparate ;
/** 设置为默认地址的文字提示 */
@property(nonatomic,weak)UILabel * setDefaultLabel ;
/** 设置为默认地址的点击按钮 */
@property(nonatomic,weak)UIButton * setDefaultButton ;
/** 编辑按钮 */
@property(nonatomic,weak)UIButton * editButton ;
/** 删除按钮 */
@property(nonatomic,weak)UIButton * deleteButton ;
/** 底部分割线 */
@property(nonatomic,weak)UIView * bottomSeparate ;
/** 是否为默认地址 */
@property(nonatomic,assign)BOOL  isDefaultAddress ;

@end

@implementation AMCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self setupSubviews];
        [self layoutMySubview];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
-(void)setupSubviews
{
    UIView * topContainerView = [[UIView alloc]init];
    self.topContainerView=topContainerView;
//    self.topContainerView.backgroundColor=randomColor;
    [self.contentView addSubview:self.topContainerView];
    UILabel * nameLabel = [[UILabel alloc]init];
    self.nameLabel=nameLabel;
    self.nameLabel.font=[UIFont systemFontOfSize:16];
    [self.topContainerView addSubview:self.nameLabel];
    UILabel * phoneNumberLabel = [[UILabel alloc]init];
    self.phoneNumberLabel=phoneNumberLabel;
    self.phoneNumberLabel.font=[UIFont systemFontOfSize:16];
    [self.topContainerView addSubview:self.phoneNumberLabel];
    UILabel * defaultTag = [[UILabel alloc]init];
    self.defaultTag= defaultTag;
    [self.topContainerView addSubview:self.defaultTag];
    self.defaultTag.text=@"默认地址";
    self.defaultTag.font=[UIFont systemFontOfSize:12];
    self.defaultTag.textColor=[UIColor redColor];
    
    UILabel * areaLabel = [[UILabel alloc]init];
    self.areaLabel = areaLabel;
    self.areaLabel.font=[UIFont systemFontOfSize:15];
//    self.areaLabel.backgroundColor=randomColor;
    self.areaLabel.textColor=[UIColor grayColor];
    [self.contentView addSubview:self.areaLabel];
    self.areaLabel.numberOfLines=0;
    
    UIView * bottomContainer = [[UIView alloc]init];
    self.bottomContainerView= bottomContainer;
//    self.bottomContainerView.backgroundColor=randomColor;
    [self.contentView addSubview:self.bottomContainerView];
    UIView * midSeparare = [[UIView alloc]init ] ;
    self.midSeparate = midSeparare;
    self.midSeparate.backgroundColor=BackgroundGray;
    [self.bottomContainerView addSubview:self.midSeparate];
    UIButton * setDefaultButton = [[UIButton alloc]init];
    self.setDefaultButton= setDefaultButton;
    [self.setDefaultButton addTarget:self action:@selector(setDefaultButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.setDefaultButton setImage:[UIImage imageNamed:@"collect_item_not_selected"] forState:UIControlStateNormal];
    [self.setDefaultButton setImage:[UIImage imageNamed:@"collect_item_selected"] forState:UIControlStateSelected];
//    self.setDefaultButton.backgroundColor=randomColor;
    [self.bottomContainerView addSubview:self.setDefaultButton];
    UILabel * setDefaultLabel = [[UILabel alloc]init];
    self.setDefaultLabel=setDefaultLabel;
    self.setDefaultLabel.text=@"设为默认地址";
    [self.setDefaultLabel setTextColor:[UIColor darkGrayColor]];
    self.setDefaultLabel.font=[UIFont systemFontOfSize:12];
//    self.setDefaultLabel.backgroundColor=randomColor;
    [self.bottomContainerView addSubview:self.setDefaultLabel];
    UIButton * editButton = [[UIButton alloc]init ] ;
    self.editButton= editButton;
    self.editButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    self.editButton.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    [self.editButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.editButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    self.editButton.backgroundColor=randomColor;
    [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.editButton.layer.cornerRadius=3;
//    self.editButton.layer.masksToBounds=YES;
//    self.editButton.layer.borderWidth=1;
//    self.editButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.editButton setImage:[UIImage imageNamed:@"tm_shopcart_couponicon"] forState:UIControlStateNormal];
    [self.bottomContainerView addSubview:self.editButton];
    UIButton * deleteButton= [[UIButton alloc]init] ;
    self.deleteButton=deleteButton;
    [self.deleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    self.deleteButton.backgroundColor=randomColor;
    [self.deleteButton setImage:[UIImage imageNamed:@"tm_quick_menu_home"] forState:UIControlStateNormal];
    [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.deleteButton.layer.cornerRadius=3;
//    self.deleteButton.layer.masksToBounds=YES;
//    self.deleteButton.layer.borderWidth=1;
//    self.deleteButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.deleteButton.contentEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    self.deleteButton.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    [self.deleteButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.bottomContainerView addSubview:self.deleteButton];
    UIView * bottomSeparate= [[UIView alloc]init];
    self.bottomSeparate= bottomSeparate;
    self.bottomSeparate.backgroundColor=BackgroundGray;
    [self.bottomContainerView addSubview:self.bottomSeparate];
    
    
}
-(void)layoutMySubview
{
    CGFloat margin = 10 ;
    [self.topContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@30);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topContainerView).offset(margin);
        make.top.bottom.equalTo(self.topContainerView);
    }];
    [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(margin);
        make.top.bottom.equalTo(self.nameLabel);
    }];
    [self.defaultTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topContainerView).offset(-margin);
        make.top.bottom.equalTo(self.nameLabel);
    }];
    
    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topContainerView).offset(margin);
        make.right.equalTo(self.topContainerView).offset(-margin);
        make.top.equalTo(self.topContainerView.mas_bottom);
    }];
    
    [self.bottomContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topContainerView);
        make.top.equalTo(self.areaLabel.mas_bottom);
        make.height.equalTo(@60);
    }];

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomContainerView);
        make.left.right.equalTo(self);
    }];
    
    
    
    
    [self.midSeparate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomContainerView);
        make.top.equalTo(self.bottomContainerView).offset(margin);
        make.height.equalTo(@1);
    }];
    [self.bottomSeparate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.bottomContainerView);
        make.height.equalTo(@(margin));
    }];
    [self.setDefaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomContainerView).offset(margin);
        make.top.equalTo(self.midSeparate.mas_bottom);
        make.bottom.equalTo(self.bottomSeparate.mas_top);
        make.width.equalTo(@40);
    }];
    [self.setDefaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.setDefaultButton);
        make.height.equalTo(self.setDefaultButton);
        make.left.equalTo(self.setDefaultButton.mas_right).offset(margin);
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomContainerView).offset(-margin);
        make.centerY.equalTo(self.setDefaultButton);
        make.width.equalTo(@60);
        make.height.equalTo(@25);
    }];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.deleteButton.mas_left).offset(-margin);
        make.centerY.equalTo(self.setDefaultButton);
        make.width.equalTo(@60);
        make.height.equalTo(@25);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(AMCellModel *)model{
    _model=model;
    self.areaLabel.text=model.totalAddress;
    self.nameLabel.text=model.name;
    self.phoneNumberLabel.text=model.phoneNumber;
    self.isDefaultAddress=model.isDefaultAddress;
//    self.namel
}
-(void)setIsDefaultAddress:(BOOL)isDefaultAddress{
    _isDefaultAddress=isDefaultAddress;
    if (_isDefaultAddress) {
        self.defaultTag.hidden=NO;
        self.setDefaultButton.selected=YES;
    }else{
        self.defaultTag.hidden=YES;
        self.setDefaultButton.selected=NO;
    }
}
-(void)deleteButtonClick:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(deleteButtonClickAtCell:)]) {
        [self.delegate deleteButtonClickAtCell:self];
    }
    
}
-(void)editButtonClick:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(editButtonClickAtCell:)]) {
        [self.delegate editButtonClickAtCell:self];
    }
}
-(void)setDefaultButtonClick:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(setDefaultAddressAtCell:)]) {
        [self.delegate setDefaultAddressAtCell:self];
    }
    
}
@end
