//
//  Person.h
//  TELBook
//
//  Created by 小爪乎黑 on 15/7/3.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Person : NSObject


@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *telNum;
@property (nonatomic,copy)NSString *info;
@property (nonatomic,copy)NSString *mail;
@property (nonatomic,strong)UIImage *headIamge;

@end
