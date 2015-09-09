//
//  SingleData.m
//  TELBook
//
//  Created by 小爪乎黑 on 15/7/3.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "SingleData.h"
#import "pinyin.h"
static SingleData *sd = nil;

@implementation SingleData

-(instancetype)init
{
    if (self = [super init]) {
        self.DataDict = [NSMutableDictionary dictionary];
        // 制作数据
        [self p_makeData];
    }
    return self;
}


+ (instancetype)shareDataHandle
{
    if (sd == nil) {
        sd = [[SingleData alloc] init];
    }

    return sd;
}
// 重写groupArray的getter方法
-(NSMutableArray *)groupArray
{
    // 获取所有key值
    self.groupArray = [_DataDict allKeys].mutableCopy;
    
    // 排序
    [_groupArray sortUsingSelector:@selector(compare:)];

    return _groupArray;
}



// 添加联系人
- (void)addPerosn:(Person *)aPerson
{
    
    // 第一步： 获取首字母
    NSString *firstChar = [aPerson.name uppercasePinYinFirstLetter];
    
    // 第二步： 判断是否有改首字母对应的分组
    //          如果有直接添加，如果没有创建
    
    if (_DataDict[firstChar] == nil) {
        
        // 创建分组
        NSMutableArray *tempArr = [NSMutableArray arrayWithObject:aPerson];
        // 加入字典
        [_DataDict setObject:tempArr forKey:firstChar];
        
    }else{
        [_DataDict[firstChar] addObject:aPerson];
    }
}

// 删除联系人
- (void)deletePerson:(NSIndexPath *)indexPath
{
    // 拿到分组名
    NSString *group = self.groupArray[indexPath.section];
    
    // 判断如果要删除的人是该分组中最后一个将整个分组一起删除
    if ([_DataDict[group] count] <= 1) {
        
        // 删除整个分组
        [_DataDict removeObjectForKey:group];
    }else{
    
        [_DataDict[group] removeObjectAtIndex:indexPath.row];
    }
    





}

// 查找联系人
- (Person *)searchPerosn:(NSIndexPath *)indexPath
{
    NSString *group = [SingleData shareDataHandle].groupArray[indexPath.section];
    
    Person *p = [SingleData shareDataHandle].DataDict[group][indexPath.row];

    return p;

}





// 制作数据
- (void)p_makeData
{

    Person *p1 = [[Person alloc] init];
    p1.name = @"贝爷";
    p1.telNum = @"1888880000";
    p1.mail = @"12312@qq.com";
    p1.info = @"食物链顶端的男人";
    p1.headIamge = [UIImage imageNamed:@"person.png"];
    
    
    Person *p2 = [[Person alloc] init];
    p2.name = @"小金刚";
    p2.telNum = @"1889990000";
    p2.mail = @"133333@qq.com";
    p2.info = @"时空管理员";
    p2.headIamge = [UIImage imageNamed:@"person.png"];

    
    [self addPerosn:p1];
    [self addPerosn:p2];
}







@end
