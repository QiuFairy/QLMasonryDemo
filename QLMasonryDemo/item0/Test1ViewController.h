//
//  Test1ViewController.h
//  QLMasonryDemo
//
//  Created by qiu on 2020/7/22.
//  Copyright © 2020 qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, viewType) {
    viewTypeDefaultLayout = 10010,
    viewTypeDenggao1        ,//等高1
    viewTypeDenggao2        ,//等高2
    viewTypeDengkuan        ,//等宽
    viewTypeOneAtthreeloacl ,//距离中心view和边距等宽
    viewTypeLabelHeight     ,//label高度自动变化
    viewTypeUpdateLayout    //更新约束
};

NS_ASSUME_NONNULL_BEGIN

@interface Test1ViewController : UIViewController

@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, assign) viewType viewType;

@end

NS_ASSUME_NONNULL_END
