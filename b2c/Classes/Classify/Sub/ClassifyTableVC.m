//
//  ClassifyTableVC.m
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ClassifyTableVC.h"
#import "ClassifyFirstLevelModel.h"
#import "MJExtension.h"
@interface ClassifyTableVC ()
/**一级分类的数组*/
@property (nonatomic, strong) NSMutableArray *catelogyList;
@property (nonatomic, strong) ClassifyFirstLevelModel *selectCateModel;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation ClassifyTableVC

- (NSMutableArray *)catelogyList {
    if (_catelogyList == nil) {
        _catelogyList = [NSMutableArray array];
    }
    
    return _catelogyList;
}


#pragma mark - 初始化
- (instancetype)init {
    
    return [super initWithStyle:UITableViewStylePlain];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据,从沙河中取数据
    
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString * filePath = [path stringByAppendingPathComponent:@"categary.plist"];
    NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    
    [self.tableView reloadData];
    
    
    //第一个被选中
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (self.catelogyList.count == 0) {
        
    }else{
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    }
    
    
    // 去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    // 取消滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    // 不允许下拉
    self.tableView.bounces = YES;
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 返回本页面时，重新选中原来的选项
    [self.tableView selectRowAtIndexPath:_selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.catelogyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    // 设置cell背景
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_cell_normal_h"]];
    // 设置cell被选中时的背景
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_cell_redline"]];
    
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    // 设置cell内容
    ClassifyFirstLevelModel *model = self.catelogyList[indexPath.row];
    cell.textLabel.text = model.classify_name;
    
    
    return cell;
}
#pragma mark - <UITableViewDelegate>
#pragma mark 取消选中后做什么
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 点击cell会怎么样
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 保存所选cell位置
    _selectedIndexPath = indexPath;
    // 滚到顶端
    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    // 字体变红
    [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor redColor];
    
    
    //现在被选中的model
    ClassifyFirstLevelModel *selectModel = self.catelogyList[indexPath.row];
    //避免重复刷新
    if ([_selectCateModel.id isEqualToString:selectModel.id] == NO) {
        _selectCateModel = selectModel;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"categary" object:nil userInfo:@{@"indexPath":indexPath}];
    }
    
    
    
    
    
}


@end
