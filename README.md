# masonry 自动化约束用法

## 本Demo主要介绍masonry的用法.

> Masonry 是在Autolayout的基础上进行的一次封装。
> 
> https://github.com/SnapKit/Masonry

### 1、用Masonry创建一个完整的约束应该是这样的

![image](https://github.com/QiuFairy/QLMasonryDemo/blob/master/png1.png)
```
//view1的左边距离父View左边10个点：
[view1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(view1.superview.mas_left).multipliedBy(1).offset(10);
}];
```

对应到上图的表达式：

- `Item1`: make MASConstraintMaker类型，view1的承载对象，表示View1
- `Attribute`: left 表示左边。left的make的属性。返回值为MASConstraint类型
- `Relationship`: equalTo 表示"="。equalTo是MASConstraint的属性
- `Item2`: view1.superview
- `Attribute2`: `mas_left` 同样表示左边，`mas_left`是Masonry给view加的属性，为了不重名，加了mas前缀
- `Multiplier`: multipliedBy(1) 系数(倍数)为1
- `Constant`: offset(10) 常数为10

### 2、Masonry基础API

```
mas_makeConstraints()    添加约束
mas_remakeConstraints()  移除之前的约束，重新添加新的约束
mas_updateConstraints()  更新约束，写哪条更新哪条，其他约束不变

equalTo()       参数是对象类型，一般是视图对象或者mas_width这样的坐标系对象
mas_equalTo()   和上面功能相同，参数可以传递基础数据类型对象，可以理解为比上面的API更强大

width()         用来表示宽度，例如代表view的宽度
mas_width()     用来获取宽度的值。和上面的区别在于，一个代表某个坐标系对象，一个用来获取坐标系对象的值
```

### 3、更新约束和布局

```
- (void)updateConstraintsIfNeeded  调用此方法，如果有标记为需要重新布局的约束，则立即进行重新布局，内部会调用updateConstraints方法
- (void)updateConstraints          重写此方法，内部实现自定义布局过程
- (BOOL)needsUpdateConstraints     当前是否需要重新布局，内部会判断当前有没有被标记的约束
- (void)setNeedsUpdateConstraints  标记需要进行重新布局
```

###4、 Masonry对比

```
Masonry本质上就是对系统AutoLayout进行的封装，包括里面很多的API，都是对系统API进行了一次二次包装。
typedef NS_OPTIONS(NSInteger, MASAttribute) {
    MASAttributeLeft = 1 << NSLayoutAttributeLeft,
    MASAttributeRight = 1 << NSLayoutAttributeRight,
    MASAttributeTop = 1 << NSLayoutAttributeTop,
    MASAttributeBottom = 1 << NSLayoutAttributeBottom,
    MASAttributeLeading = 1 << NSLayoutAttributeLeading,
    MASAttributeTrailing = 1 << NSLayoutAttributeTrailing,
    MASAttributeWidth = 1 << NSLayoutAttributeWidth,
    MASAttributeHeight = 1 << NSLayoutAttributeHeight,
    MASAttributeCenterX = 1 << NSLayoutAttributeCenterX,
    MASAttributeCenterY = 1 << NSLayoutAttributeCenterY,
    MASAttributeBaseline = 1 << NSLayoutAttributeBaseline,
};
```

### 5、常用方法
#### a、设置内边距
```
/** 
 设置yellow视图和self.view等大，并且有10的内边距。
 注意根据UIView的坐标系，下面right和bottom进行了取反。所以不能写成下面这样，否则right、bottom这两个方向会出现问题。
 make.edges.equalTo(self.view).with.offset(10);
 
 除了下面例子中的offset()方法，还有针对不同坐标系的centerOffset()、sizeOffset()、valueOffset()之类的方法。
 */
[self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).with.offset(10);
    make.top.equalTo(self.view).with.offset(10);
    make.right.equalTo(self.view).with.offset(-10);
    make.bottom.equalTo(self.view).with.offset(-10);
}];
```

#### b、通过insets简化设置内边距的方式
```
// 下面的方法和上面例子等价，区别在于使用insets()方法。
[self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
    // 下、右不需要写负号，insets方法中已经为我们做了取反的操作了。
    make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
}];
```

#### c、更新约束
```
// 设置greenView的center和size，这样就可以达到简单进行约束的目的
[self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
    // 这里通过mas_equalTo给size设置了基础数据类型的参数，参数为CGSize的结构体
    make.size.mas_equalTo(CGSizeMake(300, 300));
}];

// 为了更清楚的看出约束变化的效果，在显示两秒后更新约束。
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    // 指定更新size，其他约束不变。
    [self.greenView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
});
```

#### d、大于等于和小于等于某个值的约束
```
[self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
    // 设置宽度小于等于200
    make.width.lessThanOrEqualTo(@200);
    // 设置高度大于等于10
    make.height.greaterThanOrEqualTo(@(10));
}];

self.textLabel.text = @"这是测试的字符串。能看到1、2、3个步骤，第一步当然是上传照片了，要上传正面近照哦。上传后，网站会自动识别你的面部，如果觉得识别的不准，你还可以手动修改一下。左边可以看到16项修改参数，最上面是整体修改，你也可以根据自己的意愿单独修改某项，将鼠标放到选项上面，右边的预览图会显示相应的位置。";
```

textLabel只需要多设置一个属性即可

```
self.textLabel.numberOfLines = 0;
```

#### e、使用基础数据类型当做参数
```
/** 
 如果想使用基础数据类型当做参数，Masonry为我们提供了"mas_xx"格式的宏定义。
 这些宏定义会将传入的基础数据类型转换为NSNumber类型，这个过程叫做封箱(Auto Boxing)。

 "mas_xx"开头的宏定义，内部都是通过MASBoxValue()函数实现的。
 这样的宏定义主要有四个，分别是mas_equalTo()、mas_offset()和大于等于、小于等于四个。
 */
[self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
    make.width.mas_equalTo(100);
    make.height.mas_equalTo(100);
}];
```

#### f、设置约束优先级
```
/** 
 Masonry为我们提供了三个默认的方法，priorityLow()、priorityMedium()、priorityHigh()，这三个方法内部对应着不同的默认优先级。
 除了这三个方法，我们也可以自己设置优先级的值，可以通过priority()方法来设置。
 */
[self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
    make.width.equalTo(self.view).priorityLow();
    make.width.mas_equalTo(20).priorityHigh();
    make.height.equalTo(self.view).priority(200);
    make.height.mas_equalTo(100).priority(1000);
}];
```
```
Masonry也帮我们定义好了一些默认的优先级常量，分别对应着不同的数值，优先级最大数值是1000。
static const MASLayoutPriority MASLayoutPriorityRequired = UILayoutPriorityRequired;
static const MASLayoutPriority MASLayoutPriorityDefaultHigh = UILayoutPriorityDefaultHigh;
static const MASLayoutPriority MASLayoutPriorityDefaultMedium = 500;
static const MASLayoutPriority MASLayoutPriorityDefaultLow = UILayoutPriorityDefaultLow;
static const MASLayoutPriority MASLayoutPriorityFittingSizeLevel = UILayoutPriorityFittingSizeLevel;
```

#### g、设置约束比例
```
// 设置当前约束值乘以多少，例如这个例子是redView的宽度是self.view宽度的0.2倍。
[self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
    make.height.mas_equalTo(30);
    make.width.equalTo(self.view).multipliedBy(0.2);
}];
```
#### h、等间隔约束

```
/**
    *  axisType         轴线方向
    *  fixedSpacing     间隔大小
    *  fixedItemLength  每个控件的固定长度/宽度
    *  leadSpacing      头部间隔
    *  tailSpacing      尾部间隔
    *
    */
//1. 等间隔排列 - 多个控件间隔固定，控件长度/宽度变化
- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType
withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing
tailSpacing:(CGFloat)tailSpacing;

//2. 等间隔排列 - 固定item宽度，左右间距
- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType
withFixedItemLength:(CGFloat)fixedItemLength
leadSpacing:(CGFloat)leadSpacing
tailSpacing:(CGFloat)tailSpacing;
```
### 6、设置key

当约束冲突发生的时候，我们经常为找不到是哪个View冲突的而烦恼，这一堆View是个什么东西呀？

```
"<MASLayoutConstraint:0x7f8de483fb10 UIView:0x7f8de2f53870.left == UIView:0x7f8de2f586c0.left>",
"<MASLayoutConstraint:0x7f8de4818b50 UIView:0x7f8de2f53870.right == UIView:0x7f8de2f586c0.right>",
"<MASLayoutConstraint:0x7f8de4818870 UIView:0x7f8de2f53870.width == 100>",
"<NSLayoutConstraint:0x7f8de4847e90 UIView:0x7f8de2f586c0.width == 375>"

Will attempt to recover by breaking constraint 
<MASLayoutConstraint:0x7f8de4818870 UIView:0x7f8de2f53870.width == 100>
```

这时候我们可以设置View的key:

```
self.view.mas_key = @"self.view";
view1.mas_key = @"view1";
```
设置之后再看一下，哈哈，现在好多了。可以清晰的知道是哪个view了

```
"<MASLayoutConstraint:0x7fcd98d17c40 UIView:view1.left == UIView:self.view.left>",
"<MASLayoutConstraint:0x7fcd98d2b2c0 UIView:view1.right == UIView:self.view.right>",
"<MASLayoutConstraint:0x7fcd98d2adb0 UIView:view1.width == 100>",
"<NSLayoutConstraint:0x7fcd98e42050 UIView:self.view.width == 375>"

Will attempt to recover by breaking constraint 
<MASLayoutConstraint:0x7fcd98d2adb0 UIView:view1.width == 100>
```
大家可能会觉得这样一个一个设置，多麻烦啊！别着急，Masonry提供了批量设置的宏MASAttachKeys
只需要一句代码即可全部设置：

`MASAttachKeys(self.view,view1);`

--
# BY QiuFairy 