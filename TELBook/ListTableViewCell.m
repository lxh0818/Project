//
//  ListTableViewCell.m
//  TELBook
//
//  Created by 小爪乎黑 on 15/7/3.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self p_setupView];
    }
    
    return self;
}

- (void)p_setupView
{
    // 角标
    self.cornerImageView = [[UIImageView alloc] init];
    _cornerImageView.frame = CGRectMake(0, 0, 35, 40);
    _cornerImageView.backgroundColor = [UIColor blueColor];
    _cornerImageView.image = [UIImage imageNamed:@"corner.png"];
    [self.contentView addSubview:_cornerImageView];
    
    // 头像
    self.headImageView = [[UIImageView alloc] init];
    _headImageView.frame = CGRectMake(CGRectGetMidX(_cornerImageView.frame), CGRectGetMidY(_cornerImageView.frame), 100, 100);
    _headImageView.backgroundColor = [UIColor blueColor];
    
    _headImageView.layer.masksToBounds = YES;
    
    _headImageView.layer.cornerRadius = 50;
    
    [self.contentView addSubview:_headImageView];
    
    // 姓名
    self.nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame) + 50, CGRectGetMinY(_headImageView.frame), 80, 30);
//    _nameLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_nameLabel];
    
    // 电话
    self.phoneLabel = [[UILabel alloc] init];
    _phoneLabel.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame) + 10, 150, 30);
//    _phoneLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_phoneLabel];
    
    // sms
    self.smsButton = [CellButton buttonWithType:(UIButtonTypeSystem)];
    
    [_smsButton addTarget:self action:@selector(smsButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];

    [_smsButton setBackgroundImage:[UIImage imageNamed:@"sms.png"] forState:(UIControlStateNormal)];
    _smsButton.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_smsButton];
    
    
    // phone
    self.phoneButton = [CellButton buttonWithType:(UIButtonTypeSystem)];
    _phoneButton.backgroundColor = [UIColor blueColor];
    [_phoneButton setBackgroundImage:[UIImage imageNamed:@"phone.png"] forState:(UIControlStateNormal)];

    // 添加button点击事件
    [_phoneButton addTarget:self action:@selector(phoneButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.contentView addSubview:_phoneButton];


}

// button点击方法
// 打电话
- (void)phoneButtonAction:(CellButton *)sender
{
    // 让代理处理
    [self.delegate callBackPhoneButton:sender];

}

// 发短信
- (void)smsButtonAction:(CellButton *)sender
{
    [self.delegate callBackSmsButton:sender];

}


// 布局子视图
-(void)layoutSubviews
{
    [super layoutSubviews];

    
    
    _smsButton.frame = CGRectMake(CGRectGetMaxX(self.contentView.frame)- 50, CGRectGetMaxY(self.contentView.frame) - 40, 30, 30);
    
    _phoneButton.frame = CGRectMake(CGRectGetMinX(_smsButton.frame) - 50, CGRectGetMinY(_smsButton.frame), CGRectGetWidth(_smsButton.frame), CGRectGetHeight(_smsButton.frame));

}







// Cell高度
+ (CGFloat)cellHeight
{
    return 145;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
