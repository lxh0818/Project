//
//  SetViewController.h
//  TELBook
//
//  Created by 小爪乎黑 on 15/7/3.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetViewControllerDelegate <NSObject>

- (void)passValue:(NSIndexPath *)index;

@end

@interface SetViewController : UIViewController

@property (nonatomic,strong)NSIndexPath *indexPath;
// 代理
@property (nonatomic,weak)id<SetViewControllerDelegate>delegate;

@end
