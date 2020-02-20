//
//  HomeRefreshFooter.m
//  TTmall
//
//  Created by wangyuanfei on 2/17/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//
#import "HomeRefreshFooter.h"
@interface HomeRefreshFooter()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UISwitch *s;
@property(nonatomic,weak)UIImageView * logo ;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end


@implementation HomeRefreshFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 44;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont boldSystemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    

    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [self addSubview:loading];
    self.loading = loading;
    UIImageView *logo = [UIImageView  new];
    NSURL * u =[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cat.gif" ofType:nil]];
    
    [logo sd_setImageWithURL:u placeholderImage:nil options:SDWebImageCacheMemoryOnly];;
    
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];

}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    /**
     普通闲置状态
    MJRefreshStateIdle = 1,
    松开就可以进行刷新的状态
    MJRefreshStatePulling,
    正在刷新中的状态
    MJRefreshStateRefreshing,
    即将刷新的状态
    MJRefreshStateWillRefresh,
     所有数据加载完毕，没有更多的数据了
    MJRefreshStateNoMoreData
     */
    switch (state) {
           
        case 1:
            self.label.text = @"上拉加载更多";
            [self setupFrame];
            [self.loading stopAnimating];
            [self.s setOn:NO animated:YES];
//            self.logo.hidden=YES;
            break;
        case 3:
            [self.s setOn:YES animated:YES];
            self.label.text = @"拼命加载中";
            [self setupFrame];
            [self.loading startAnimating];
//            self.logo.hidden=NO;
            break;
        case 5:
            self.label.text = @"-- 亲,你看完了 --";
            [self.s setOn:NO animated:YES];
            [self.loading stopAnimating];
            self.logo.hidden=YES;
            self.label.frame = self.bounds;
            break;
        default:
            break;
    }
}

-(void)setupFrame
{

    CGSize  labelSize =  [self.label.text sizeWithFont:self.label.font];
    CGFloat margin = 5;
    CGFloat logoW = 44 ;
    CGFloat logoH = 19;
    self.logo.frame=CGRectMake((self.bounds.size.width-logoW)/2, margin, logoW, logoH);
    self.label.frame = CGRectMake((self.bounds.size.width-labelSize.width)/2, CGRectGetMaxY(self.logo.frame)+margin, labelSize.width, labelSize.height);
    
}
@end
