//
//  SecondViewController.m
//  QLScrollViewDemo
//
//  Created by qiu on 2018/6/2.
//  Copyright © 2018年 QiuFairy. All rights reserved.
//

#import "SecondViewController.h"
#import "Masonry.h"

#define SWIDTH [UIScreen mainScreen].bounds.size.width
#define SHEIGHT [UIScreen mainScreen].bounds.size.height

@interface SecondViewController ()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UILabel * titleLabel;
@property (nonatomic, weak) UILabel * timeLabel;
@property (nonatomic, weak) UILabel * contentLabel;

@property (nonatomic, assign, getter=openStatus) BOOL isOpen;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createView];
    [self __layoutSubViews];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"展开" style:UIBarButtonItemStyleDone target:self action:@selector(zhankai)];
    self.navigationItem.rightBarButtonItem =rightItem;
    
    self.isOpen = NO;
}
-(void)zhankai{
    self.isOpen = !self.openStatus;
    [_timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.openStatus) {
            make.height.equalTo(@100.f);
        }else{
            make.height.equalTo(@16.f);
        }
    }];
}
- (void)createView {
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16.f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor redColor];
    [scrollView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UILabel * timeLabel = [[UILabel alloc] init];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:11.f];
    timeLabel.textColor = [UIColor redColor];
    timeLabel.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    UILabel * contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:14.f];
    contentLabel.textColor = [UIColor darkGrayColor];
    contentLabel.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:contentLabel];
    _contentLabel = contentLabel;
    
    
    UIView * contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:contentView];
    _contentView = contentView;
    
}

- (void)__layoutSubViews {
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //此处得有一个宽度对照系
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(20.f);
        make.width.equalTo(self.scrollView);
        make.height.equalTo(@16.f);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5.f);
        make.left.equalTo(self.titleLabel).offset(10);
        make.right.equalTo(self.titleLabel).offset(-10);
        make.height.equalTo(@16.f);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(20.f);
        make.left.equalTo(self.titleLabel).offset(10);
        make.right.equalTo(self.titleLabel).offset(-10);
        make.bottom.equalTo(self.scrollView).offset(-10);// 设置与容器View底部高度固定，contentLabel高度变化的时候，由于设置了容器View的高度动态变化，底部距离固定。 此时contentView的高度变化之后，ScrollView的contentSize就发生了变化，适配文字内容，滑动查看超出屏幕文字。
        //        make.height.greaterThanOrEqualTo(@16.f);//高度动态变化 大于等于16
    }];
    
//    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentLabel.mas_bottom).offset(20.f);
//        make.width.equalTo(self.scrollView);
//        make.height.mas_equalTo(20);
//       make.bottom.equalTo(self.scrollView).offset(-10);
//    }];
    
    _titleLabel.text = @"测试效果";
    _timeLabel.text = [self getCurrentTimes];
    _contentLabel.text = @"为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）为什么要默认向上的阴影呢？尽管Core Animation是从图层套装演变而来（可以认为是为iOS创建的私有动画框架），但是呢，它却是在Mac OS上面世的，前面有提到，二者的Y轴是颠倒的。这就导致了默认的3个点位移的阴影是向上的。在Mac上，shadowOffset的默认值是阴影向下的，这样你就能理解为什么iOS上的阴影方向是向上的了（如图4.5）";
}
- (NSString *)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

@end
