//
//  View2Controller.m
//  QLMasonryDemo
//
//  Created by qiu on 2020/7/27.
//  Copyright © 2020 qiu. All rights reserved.
//

#import "View2Controller.h"
#import "Masonry.h"

#import "View2TableViewCell.h"
static NSString *cellId = @"cellId";

@interface View2Controller ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *defaultTitleListArr;
@property (nonatomic, strong) NSArray *defaultListArr;

@end

@implementation View2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我是天上的☁️";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self createUI];
    
    self.defaultTitleListArr = @[
    @"那天的风很热，吹的心里痒痒的，我喜欢你，我想和你在一起。",
    @"起风了，下雨了，小毛驴不见了，跑哪了，不知道，就是找不到了",
    @"我是哒哒哒哒哒哒多多多多",
    @"title2",
    @"title1",
    @"title122"
    ];
    self.defaultListArr = @[
        @"我是你心中的棉花糖，长得很漂亮，我也很好吃，但是你就吃不着。啦啦啦啦啦啦啦",
        @"这一路上走走停停，顺着少年漂流的痕迹，迈出车站的前一刻，竟有些犹豫，不禁笑这近乡情怯，仍无可避免，而长野的天，依旧那么暖",
        @"你的眼中 明暗交杂 一笑生花，暮色遮住你蹒跚的步伐，走进床头藏起的画，画中的你 低着头说话，我仍感叹于世界之大，也沉醉于儿时情话，不剩真假 不做挣扎 无谓笑话，我终将青春还给了她，连同指尖弹出的盛夏，心之所动 就随风去了，以爱之名 你还愿意吗",@"detail222222",@"detail222212121",@"detail啊啊啊啊啊"];
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
    tableView.estimatedRowHeight = 60;
    
    [tableView registerClass:[View2TableViewCell class] forCellReuseIdentifier:cellId];
    
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.bottom.equalTo(self.view);
    }];
    
    _tableView = tableView;
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.defaultListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
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
    View2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];

    cell.titleStr = self.defaultTitleListArr[indexPath.section];
    cell.timeStr = [NSString stringWithFormat:@"%@--index==%ld",@"2020-07-27",indexPath.section];
    cell.detailStr = self.defaultListArr[indexPath.section];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
