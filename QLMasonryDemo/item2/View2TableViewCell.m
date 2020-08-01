//
//  View2TableViewCell.m
//  QLMasonryDemo
//
//  Created by qiu on 2020/7/27.
//  Copyright © 2020 qiu. All rights reserved.
//

#import "View2TableViewCell.h"
#import "Masonry.h"

@interface View2TableViewCell ()

@property (nonatomic, weak) UILabel *msgTitleLabel;
@property (nonatomic, weak) UILabel *msgTimeLabel;
@property (nonatomic, weak) UILabel *msgDetailLabel;

@end

@implementation View2TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor lightGrayColor];
        [self createCellUI];
        [self createUILayout];
    }
    return self;
}

- (void)setTitleStr:(NSString *)titleStr{
    self.msgTitleLabel.text = titleStr;
}
- (void)setTimeStr:(NSString *)timeStr{
    self.msgTimeLabel.text = timeStr;
}
-(void)setDetailStr:(NSString *)detailStr{
    self.msgDetailLabel.text = detailStr;
}

#pragma mark - UI
-(void)createCellUI{
    UILabel *msgTitleLabel= [[UILabel alloc]init];
    msgTitleLabel.font = [UIFont systemFontOfSize:18.0];
    msgTitleLabel.textColor = [UIColor redColor];
    msgTitleLabel.numberOfLines = 0;
    [self.contentView addSubview:msgTitleLabel];
    
    UILabel *msgTimeLabel = [[UILabel alloc]init];
    msgTimeLabel.font = [UIFont systemFontOfSize:18.0];
    msgTimeLabel.textColor = [UIColor redColor];
    msgTimeLabel.numberOfLines = 1;
    [self.contentView addSubview:msgTimeLabel];
    
    UILabel *msgDetailLabel = [[UILabel alloc]init];
    msgDetailLabel.font = [UIFont systemFontOfSize:14.0];
    msgDetailLabel.textColor = [UIColor redColor];
    msgDetailLabel.numberOfLines = 0;
    [self.contentView addSubview:msgDetailLabel];
    
    msgTitleLabel.backgroundColor = [UIColor greenColor];
    msgTimeLabel.backgroundColor = [UIColor orangeColor];
    msgDetailLabel.backgroundColor = [UIColor cyanColor];
    
    _msgTitleLabel = msgTitleLabel;
    _msgTimeLabel = msgTimeLabel;
    _msgDetailLabel = msgDetailLabel;
}
-(void)createUILayout{
    __weak typeof(self) weakSelf = self;
    [self.msgTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        make.top.mas_equalTo(strongSelf.contentView.mas_top).offset(10);
        make.left.mas_equalTo(strongSelf.contentView.mas_left).offset(10);
//        make.height.mas_greaterThanOrEqualTo(60);
//        make.bottom.mas_equalTo(strongSelf.contentView.mas_bottom).offset(-10).priority(500);
    }];
    
    [self.msgTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        make.top.equalTo(strongSelf.msgTitleLabel.mas_top);
        make.left.mas_equalTo(strongSelf.msgTitleLabel.mas_right).offset(10);
        make.right.mas_equalTo(strongSelf.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    [self.msgDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        make.top.equalTo(strongSelf.msgTitleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(strongSelf.contentView.mas_left).offset(10);
        make.right.mas_equalTo(strongSelf.contentView.mas_right).offset(-10);
        make.bottom.mas_equalTo(strongSelf.contentView.mas_bottom).offset(-10).priority(500);
    }];
    
    //抗压缩
    [self.msgTitleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];//宽度不够时，可以被压缩
    [self.msgTimeLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];//不可以被压缩，尽量显示完整
    
    //抗拉伸
    [self.msgTitleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow/*相比较他可以被拉伸*/
                                      forAxis:UILayoutConstraintAxisHorizontal];
    [self.msgTimeLabel setContentHuggingPriority:UILayoutPriorityRequired/*抗拉伸*/
                                      forAxis:UILayoutConstraintAxisHorizontal];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
