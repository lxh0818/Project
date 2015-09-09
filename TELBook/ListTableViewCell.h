//
//  ListTableViewCell.h
//  TELBook
//
//  Created by 小爪乎黑 on 15/7/3.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellButton.h"

@protocol ListTabelViewDelegate <NSObject>

// 打电话代理方法
- (void)callBackPhoneButton:(CellButton *)aButton;
// 发短信代理方法
- (void)callBackSmsButton:(CellButton *)aButton;


@end

@interface ListTableViewCell : UITableViewCell

// 角标
@property (nonatomic,strong)UIImageView *cornerImageView;

// 头像
@property (nonatomic,strong)UIImageView *headImageView;

// 姓名
@property (nonatomic,strong)UILabel *nameLabel;

// 电话
@property (nonatomic,strong)UILabel *phoneLabel;

// 打电话
@property (nonatomic,strong)CellButton *phoneButton;

// 发短信
@property (nonatomic,strong)CellButton *smsButton;


// 代理
@property (nonatomic,weak)id<ListTabelViewDelegate>delegate;






// Cell高度
+ (CGFloat)cellHeight;

@end
