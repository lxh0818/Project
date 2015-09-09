//
//  CellButton.h
//  TELBook
//
//  Created by 小爪乎黑 on 15/7/3.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellButton : UIButton

// 用这个属性来识别cell上的button
@property (nonatomic,strong)NSIndexPath *buttonIndex;

@end
