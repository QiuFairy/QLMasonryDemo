//
//  QLIntervalView.m
//  QLMasonryDemo
//
//  Created by qiu on 2020/7/22.
//  Copyright © 2020 qiu. All rights reserved.
//

#import "QLIntervalView.h"
#import "Masonry.h"

@interface QLIntervalView ()

@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UIView *centerView;

@end
 
@implementation QLIntervalView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
        
        [self setupLayout];
    }
    return self;
}
#pragma mark - UI
- (void)setupUI{
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:titleView];
    
    UIView *centerView = [[UIView alloc]init];
    centerView.backgroundColor = [UIColor blackColor];
    [self addSubview:centerView];
    
    _titleView = titleView;
    _centerView = centerView;
}

#pragma mark -- 采用等间隔
- (void)setupLayout{
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(76);
        
    }];
    
    /*!
     此处是为了设置将titleView的center固定在1/4处
     */
    UIView *spaceOneView = [[UIView alloc]init];
    spaceOneView.backgroundColor = [UIColor redColor];
    UIView *spaceTwoView = [[UIView alloc]init];
    spaceTwoView.backgroundColor = [UIColor redColor];
    [self addSubview:spaceTwoView];
    [self addSubview:spaceOneView];
    [spaceOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(spaceTwoView.mas_width);
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(1);
    }];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(spaceOneView.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(40);
    }];
    [spaceTwoView mas_makeConstraints:^(MASConstraintMaker *make) {

       make.top.equalTo(self.mas_top).offset(20); make.left.equalTo(self.titleView.mas_right).offset(0);
        make.right.equalTo(self.centerView.mas_left).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
}
@end
