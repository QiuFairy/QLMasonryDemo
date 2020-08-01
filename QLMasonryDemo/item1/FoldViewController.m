//
//  FoldViewController.m
//  QLScrollViewDemo
//
//  Created by qiu on 2018/6/2.
//  Copyright © 2018年 QiuFairy. All rights reserved.
//

#import "FoldViewController.h"
#import "Masonry.h"
#import "FoldView.h"

#define SWIDTH [UIScreen mainScreen].bounds.size.width
#define SHEIGHT [UIScreen mainScreen].bounds.size.height


@interface FoldViewController ()
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UILabel * titleLabel;
@property (nonatomic, weak) UILabel * timeLabel;
@property (nonatomic, weak) UILabel * contentLabel;

@property (nonatomic, weak) FoldView *foldView;
@property (nonatomic, weak) FoldView *foldView2;
@end

@implementation FoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
    [self createlayout];
    
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
    
    FoldView *foldView = [[FoldView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 44)];
    foldView.backgroundColor = [UIColor whiteColor];
    foldView.reloadSectionHeaderViewBlock = ^(CGFloat viewHeight, FoldView *view) {
        [self zhankai:view.IsExpand viewHeight:viewHeight bgView:view];
    };
    [scrollView addSubview:foldView];
    _foldView = foldView;
    
    FoldView *foldView2 = [[FoldView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 44)];
    foldView2.backgroundColor = [UIColor whiteColor];
    foldView2.reloadSectionHeaderViewBlock = ^(CGFloat viewHeight, FoldView *view) {
        
        [self zhankai:view.IsExpand viewHeight:viewHeight bgView:view];
    };
    [scrollView addSubview:foldView2];
    _foldView2 = foldView2;
    
    UILabel * timeLabel = [[UILabel alloc] init];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:11.f];
    timeLabel.textColor = [UIColor redColor];
    timeLabel.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    NSMutableAttributedString *textAttrStr = [[NSMutableAttributedString alloc] init];
    
    //第一张图
    //NSTextAttach可以将图片转换为富文本内容
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"home_plan_up"];
    attach.bounds = CGRectMake(0, 0 , 15, 10);
    
    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
    [textAttrStr appendAttributedString:imgStr];
    
    [textAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@" 天上的风，吹呀吹"]];
    
//    NSDictionary *attriBute =@{NSKernAttributeName:[NSNumber numberWithFloat:10]};
//    [textAttrStr addAttributes:attriBute range:NSMakeRange(0, 1)];

    timeLabel.attributedText = textAttrStr;
        
}
-(void)zhankai:(BOOL)openStatus viewHeight:(CGFloat)height bgView:(FoldView *)view{
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        if (openStatus) {
            make.height.mas_equalTo(height);
        }else{
            make.height.mas_equalTo(44.f);
        }
    }];
}
- (void)createlayout {
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //此处得有一个宽度对照系
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(20.f);
        make.width.equalTo(self.scrollView);
        make.height.equalTo(@16.f);
    }];
    
    [_foldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20.f);
        make.left.equalTo(self.titleLabel).offset(0);
        make.right.equalTo(self.titleLabel).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [_foldView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.foldView.mas_bottom).offset(20.f);
        make.left.equalTo(self.titleLabel).offset(0);
        make.right.equalTo(self.titleLabel).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.foldView2.mas_bottom).offset(10.f);
        make.left.equalTo(self.titleLabel).offset(10);
        make.right.equalTo(self.titleLabel).offset(-10);
        make.height.equalTo(@40.f);
        make.bottom.equalTo(self.scrollView).offset(-10);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
