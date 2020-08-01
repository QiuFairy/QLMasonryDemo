//
//  Test1ViewController.m
//  QLMasonryDemo
//
//  Created by qiu on 2020/7/22.
//  Copyright © 2020 qiu. All rights reserved.
//

#import "Test1ViewController.h"
#import "Masonry.h"
#import "QLIntervalView.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleStr;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    switch (self.viewType) {
        case viewTypeDefaultLayout:
            [self defaultLayout];
        break;
        case viewTypeDenggao1:
            [self denggao1];
            break;
         case viewTypeDenggao2:
            [self denggao2];
            break;
          case viewTypeDengkuan:
            [self dengkuan];
            break;
        case viewTypeOneAtthreeloacl:
            [self oneAtthreeloacl];
            break;
        case viewTypeLabelHeight:
            [self labelHeight];
            break;
        case viewTypeUpdateLayout:
            [self viewUpdateLayout];
            break;
        default:
            break;
    }
    
}

- (void)labelHeight{
    UILabel *label1 = [[UILabel alloc]init];
    label1.numberOfLines = 0;
    label1.backgroundColor = [UIColor greenColor];
    label1.textColor = [UIColor orangeColor];
    [self.view addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(20, 10, 0, 10));
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    label1.text = @"短视的吉安市的哈时间的话卡萨大石街道哈萨克几点回家爱神的箭客户撒的会撒娇肯定会看见爱上的会撒娇肯定会卡萨大可视对讲卡萨的接口撒谎的卡萨";
}

- (void)defaultLayout{
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view).insets(UIEdgeInsetsMake(20, 10, 0, 10));
        make.height.mas_equalTo(100);
        make.left.equalTo(self.view.mas_left).offset(100).priorityHigh();//所以此处未生效
        
    }];
}

- (void)denggao1{
    /**
     下面的例子是通过给equalTo()方法传入一个数组，设置数组中子视图及当前make对应的视图之间等高。
     
     需要注意的是，下面block中设置边距的时候，应该用insets来设置，而不是用offset。
     因为用offset设置right和bottom的边距时，这两个值应该是负数，所以如果通过offset来统一设置值会有问题。
     */
    
    CGFloat padding = 10;
    
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    UIView *yellowView = [[UIView alloc]init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];

    /**********  等高   ***********/
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).insets(UIEdgeInsetsMake(padding, padding, 0, padding));
        make.bottom.equalTo(blueView.mas_top).offset(-padding);
    }];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, 0, padding));
        make.bottom.equalTo(yellowView.mas_top).offset(-padding);
    }];

    /**
     下面设置make.height的数组是关键，通过这个数组可以设置这三个视图高度相等。其他例如宽度之类的，也是类似的方式。
     */
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, padding, padding));
        make.height.equalTo(@[blueView, redView]);
    }];
}

- (void)denggao2{
    // 等高
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    UIView *yellowView = [[UIView alloc]init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    NSArray *viewArr = @[redView,blueView,yellowView];
    [viewArr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    [viewArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
    }];
}

- (void)dengkuan{
    // 等宽
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    UIView *yellowView = [[UIView alloc]init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    NSArray *viewArr = @[redView,blueView,yellowView];
    [viewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    [viewArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(15);
        make.height.mas_equalTo(100);
    }];
}

- (void)oneAtthreeloacl{
    // 距离中心view和边距等宽
    QLIntervalView *topView = [[QLIntervalView alloc]init];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(115);
    }];
}

- (void)createView{
    /**
     此处可以自适应宽度，title不可以被压缩，所以最小也得全部显示
     [self.groupLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];//不可以被压缩，尽量显示完整
     [self.timeLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];//不可以被压缩，尽量显示完整
     [self.groupNameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];//宽度不够时，可以被压缩
     [self.timeLabel setContentHuggingPriority:UILayoutPriorityRequired
                                       forAxis:UILayoutConstraintAxisHorizontal];//抱紧
     [self.groupLabel setContentHuggingPriority:UILayoutPriorityRequired
                                       forAxis:UILayoutConstraintAxisHorizontal];
     */
    

//    /**********  等宽   ***********/
//    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(padding, padding, padding, 0));
//        make.right.equalTo(blueView.mas_left).offset(-padding);
//    }];
//    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(padding, 0, padding, 0));
//        make.right.equalTo(yellowView.mas_left).offset(-padding);
//    }];
//    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.right.equalTo(self.view).insets(UIEdgeInsetsMake(padding, 0, padding, padding));
//        make.width.equalTo(@[redView, blueView]);
//    }];
}

- (void)viewUpdateLayout{
    // 等宽
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) { make.center.equalTo(self.view);
        // 这里通过mas_equalTo给size设置了基础数据类型的参数，参数为CGSize的结构体
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];

    // 为了更清楚的看出约束变化的效果，在显示两秒后更新约束。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 指定更新size，其他约束不变。
        [redView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    });
}

@end
