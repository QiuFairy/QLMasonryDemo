//
//  ViewController.m
//  QLMasonryDemo
//
//  Created by qiu on 2020/7/15.
//  Copyright © 2020 qiu. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "Test1ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *defaultListArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我是天上的☁️";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self createUI];
    
    self.defaultListArr = @[
    @[@"default",@"10010"],
    @[@"等高1",@"10011"],
    @[@"等高2",@"10012"],
    @[@"等宽",@"10013"],
    @[@"距离中心view和边距等宽",@"10014"],
    @[@"label高度自动",@"10015"],
    @[@"自动更新约束",@"10016"],
    @[@"多个view约束",@"10017"],
    @[@"多个view约束2",@"10018"]];
}
#pragma mark - 设置界面元素
- (void)createUI{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedRowHeight = 160;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.bottom.equalTo(self.view);
        // -- JJ
//        make.height.mas_equalTo(100);
//        .priorityLow()
    }];
    
    tableView.mas_key = @"view1_tableView";
    
    _tableView = tableView;
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.defaultListArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"identifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    NSArray *arr = self.defaultListArr[indexPath.row];
    cell.textLabel.text = arr[0];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Test1ViewController *test1VC = [[Test1ViewController alloc]init];
    NSArray *arr = self.defaultListArr[indexPath.row];
    test1VC.title = arr[0];
    NSInteger viewTypeNum = [arr[1] integerValue];
    //强制映射 -- JJ
    test1VC.viewType = (viewType)viewTypeNum;
    test1VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:test1VC animated:YES];
}


@end
