//
//  FoldView.m
//  QLScrollViewDemo
//
//  Created by qiu on 2018/6/2.
//  Copyright © 2018年 QiuFairy. All rights reserved.
//

#import "FoldView.h"
#import <WebKit/WebKit.h>
@interface FoldView ()<WKNavigationDelegate,WKUIDelegate>

/** 组头名称 */
@property (nonatomic, weak) UILabel *titleLabel;

/** 箭头 */
@property (nonatomic, weak) UIImageView *arrowImageView;

/** 避免重复点击 */
@property (nonatomic, assign) BOOL IsAgain;

@property (nonatomic, assign) BOOL IsExpand;

@property (nonatomic, assign) BOOL isFirstLoad;

@property (nonatomic, assign) CGFloat viewHeight;

@property (nonatomic, weak) UIImageView *logoImageView;

@end
@implementation FoldView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        
        self.IsAgain = YES;
        self.IsExpand = NO;
        self.isFirstLoad = YES;
    }
    return self;
}

-(void)createUI{
    // 初始化
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 34)];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.text = @"我是item1";
    [self addSubview:titleLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-25, 17, 15, 10)];
    arrowImageView.image = [UIImage imageNamed:@"home_plan_up"];
    [self addSubview:arrowImageView];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 34, self.frame.size.width, 10)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    UIButton *reloadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    [reloadButton addTarget:self action:@selector(reloadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reloadButton];
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44, self.frame.size.width-20, 100)];
    [self addSubview:logoImageView];
    logoImageView.hidden = YES;
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
    [operationQueue addOperation:op];
    
    _logoImageView = logoImageView;
}
- (void)downloadImage{
    NSURL *imageUrl = [NSURL URLWithString:@"https://www.fmprc.gov.cn/web/images/logo.png"];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.logoImageView.image = image;
    });
}

/** 点击按钮控制器 */
- (void)reloadButtonClick {
    // 控制点击一下执行完毕之后再点击才能生效,避免重复点击
    if (!self.IsAgain) {
        return;
    }
    self.IsAgain = NO;
    // 旋转箭头
    [UIView animateWithDuration:.25 animations:^{
        if (self.IsExpand) {
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        } else {
            self.arrowImageView.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        self.IsAgain = YES;
        self.IsExpand = !self.IsExpand;
        self.logoImageView.hidden = !self.IsExpand;
        if (self.reloadSectionHeaderViewBlock && self.IsExpand) {
            self.reloadSectionHeaderViewBlock(150, self);
        }else{
            self.reloadSectionHeaderViewBlock(44, self);
        }
    }];
}

@end
