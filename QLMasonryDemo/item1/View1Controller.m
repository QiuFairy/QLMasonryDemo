//
//  View1Controller.m
//  QLMasonryDemo
//
//  Created by qiu on 2020/7/24.
//  Copyright © 2020 qiu. All rights reserved.
//

#import "View1Controller.h"
#import "Masonry.h"
#import "SecondViewController.h"
#import "FoldViewController.h"

#define SWIDTH [UIScreen mainScreen].bounds.size.width
#define SHEIGHT [UIScreen mainScreen].bounds.size.height

@interface View1Controller ()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UILabel * titleLabel;
@property (nonatomic, weak) UILabel * timeLabel;
@property (nonatomic, weak) UILabel * contentLabel;
@end

@implementation View1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createView];
    [self __layoutSubViews];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"测试展开" style:UIBarButtonItemStyleDone target:self action:@selector(zhankai)];
    self.navigationItem.leftBarButtonItem =leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStyleDone target:self action:@selector(nextVC)];
    self.navigationItem.rightBarButtonItem =rightItem;
}
-(void)zhankai{
//    [_timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@100.f);
//    }];
    FoldViewController *VC = [FoldViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)nextVC{
    SecondViewController *VC = [SecondViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)createView {
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    UIView * contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:contentView];
    _contentView = contentView;
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16.f];
    titleLabel.textColor = [UIColor redColor];
    [contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UILabel * timeLabel = [[UILabel alloc] init];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:11.f];
    timeLabel.textColor = [UIColor greenColor];
    [contentView addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    UILabel * contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:14.f];
    contentLabel.textColor = [UIColor darkGrayColor];
    contentLabel.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:contentLabel];
    _contentLabel = contentLabel;
    
}

- (void)__layoutSubViews {
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20.f);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@16.f);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5.f);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@16.f);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(20.f);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);// 设置与容器View底部高度固定，contentLabel高度变化的时候，由于设置了容器View的高度动态变化，底部距离固定。 此时contentView的高度变化之后，ScrollView的contentSize就发生了变化，适配文字内容，滑动查看超出屏幕文字。
        //        make.height.greaterThanOrEqualTo(@16.f);//高度动态变化 大于等于16
    }];
    
    _titleLabel.text = @"测试效果";
    _timeLabel.text = @"2020年07月24日";
    _contentLabel.text = @"为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）";
}
@end
