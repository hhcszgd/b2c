//
//  HomeBaseVC.m
//  b2c
//
//  Created by wangyuanfei on 3/23/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "HomeBaseVC.h"
#import "HSearchVC.h"
#import "QRCodeScannerVC.h"
@interface HomeBaseVC ()<UISearchBarDelegate>
@property(nonatomic,strong)UIImage * img ;
@property(nonatomic,weak)UIButton * scrollToTopButton ;
@property(nonatomic,weak)UILabel * searchContentLabel ;

@end

@implementation HomeBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.backButtonHidden=YES;
    UIButton * scrollToTopButton = [[UIButton alloc]initWithFrame:CGRectMake(screenW-60, screenH-132, 44, 44)];
    self.scrollToTopButton=scrollToTopButton;
    [self.scrollToTopButton setImage:[UIImage imageNamed:@"SHJ_Collection"] forState:UIControlStateNormal];
    [self.view addSubview:self.scrollToTopButton];
    [self.scrollToTopButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupNavigationBarSubview];

}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"准备输入搜索内容")

}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,searchText)
}
-(void)setupNavigationBarSubview
{
    ActionBaseView * messageButton = [[ActionBaseView alloc]init];
    [messageButton addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
//    [messageButton addTarget:self andSel:@selector(messageClick)];
    messageButton.backgroundColor = randomColor;
     ActionBaseView * saoCode = [[ActionBaseView alloc]init];
    [saoCode addTarget:self action:@selector(saoCode:) forControlEvents:UIControlEventTouchUpInside];
//    [saoCode addTarget:self andSel:@selector(saoCode)];
    saoCode.backgroundColor = randomColor;
    ActionBaseView * searchBar = [[ActionBaseView alloc]init];
    self.navigationBarRightActionViews = @[messageButton];
    self.navigationBarLeftActionViews = @[saoCode];
    [searchBar addTarget:self action:@selector(skipToSearchVC:) forControlEvents:UIControlEventTouchUpInside];
//    [searchBar addTarget:self andSel:@selector(skipToSearchVC)];
    self.searchView =searchBar;
    //设置完searchBar再布局里面的子控件
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, searchBar.bounds.size.height, searchBar.bounds.size.height)];//放大镜
    [searchBar addSubview:img];
    UILabel * text = [[UILabel alloc]initWithFrame:CGRectMake(img.bounds.size.width, 0, searchBar.bounds.size.width-img.bounds.size.width, img.bounds.size.height)];
    self.searchContentLabel=text;
    text.textColor = [UIColor lightGrayColor];
    self.searchContentText=@"当季流行";
//    text.backgroundColor=randomColor;
    [searchBar addSubview:text];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"test")
}
-(void)saoCode:(ActionBaseView*)sender
{
    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HAppliancesCenterVC"];
    QRCodeScannerVC * scannerVC = [[QRCodeScannerVC alloc] init ];
    [self.navigationController presentViewController:scannerVC animated:YES completion:^{
        
    }];
//    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HomeBaseVC"];
}

-(void)messageClick:(ActionBaseView*)sender
{
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"跳转消息控制器")
    [ [SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HMessageVC"];
}
-(void)skipToSearchVC:(ActionBaseView*)sender
{
    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HSearchVC"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (self.tableView.contentOffset.y<0) {
        
        [UIView animateWithDuration:0.25 animations:^{
            [self changenavigationBarAlphaWithScale:0];
        }];
        
    }else if(self.tableView.contentOffset.y<100){
        [UIView animateWithDuration:0.25 animations:^{
            [self changenavigationBarAlphaWithScale:1];
        }];
         [self changenavigationBarBackGroundAlphaWithScale:self.tableView.contentOffset.y*0.01];
        
        
    }else if (self.tableView.contentOffset.y<screenH*2){
         [self changenavigationBarBackGroundAlphaWithScale:1];
        self.scrollToTopButton.hidden=YES;
    }else{
        self.scrollToTopButton.hidden=NO;
        if (!self.scrollToTopButton.hidden)
        [self.view bringSubviewToFront:self.scrollToTopButton];
        [self changenavigationBarBackGroundAlphaWithScale:1];
    }
    
}
-(void)scrollToTop
{
    if (self.tableView ) {
         [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGSize size =  self.tableView.contentSize;
//    size.height += 10 ;
    self.tableView.contentSize = size;
}
-(void)setSearchContentText:(NSString *)searchContentText{
    _searchContentText=searchContentText;
    self.searchContentLabel.text = searchContentText;
}


@end
