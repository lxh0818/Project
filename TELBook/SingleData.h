//
//  SingleData.h
//  TELBook
//
//  Created by 小爪乎黑 on 15/7/3.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface SingleData : NSObject

// 用来存取数据的
@property (nonatomic,strong)NSMutableDictionary *DataDict;
// 用来存储分组名
@property (nonatomic,strong)NSMutableArray *groupArray;

// 单例方法
+ (instancetype)shareDataHandle;

// 添加联系人
- (void)addPerosn:(Person *)aPerson;

// 删除联系人
- (void)deletePerson:(NSIndexPath *)indexPath;

// 查找联系人
- (Person *)searchPerosn:(NSIndexPath *)indexPath;


@end
