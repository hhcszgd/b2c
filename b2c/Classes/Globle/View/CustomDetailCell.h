//
//  CustomDetailCell.h
//  b2c
//
//  Created by wangyuanfei on 4/8/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ActionBaseView.h"

//@protocol CustomDetailCellDelegate <NSObject>
/** 当前cell的点击 */
//-(void) customDetailCellClickWith:(ActionBaseView*)sender;

//@end


@interface CustomDetailCell : ActionBaseView
//@property(nonatomic,weak)id <CustomDetailCellDelegate> CustomDetailCellDelegate ;
@property(nonatomic,assign)BOOL arrowHidden ;

@property(nonatomic,strong)UIImage * leftImage ;
@property(nonatomic,copy)NSString * leftTitle ;
@property(nonatomic,copy)NSString * rightDetailTitle ;
@property(nonatomic,strong)UIImage * rightImage ;
@property(nonatomic,strong)UIFont * leftTitleFont ;
@property(nonatomic,strong)UIFont * rightDetailTitleFont ;
@property(nonatomic,strong)UIColor * rightDetailTitleColor ;

@end
