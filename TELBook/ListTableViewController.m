//
//  ListTableViewController.m
//  TELBook
//
//  Created by 小爪乎黑 on 15/7/3.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListTableViewCell.h"
#import "DetailViewController.h"
#import "AddViewController.h"
#import "SingleData.h"

@interface ListTableViewController ()<ListTabelViewDelegate>

@property (nonatomic,weak)SingleData *sd;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册Cell
    [self.tableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:@"list"];
    
    // 有barButton
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(rightBarButtonItemAction:)];
    
    // 获取单例对象
    self.sd = [SingleData shareDataHandle];

  
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];

}


- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{
    NSLog(@"添加");
    AddViewController *addVC = [[AddViewController alloc] init];
    
    [self presentViewController:addVC animated:YES completion:nil];
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return _sd.groupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    
    return [_sd.DataDict[_sd.groupArray[section]] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list" forIndexPath:indexPath];
    

    //取出model对象
    Person *p = [[SingleData shareDataHandle] searchPerosn:indexPath];
    
    cell.nameLabel.text = p.name;
    cell.phoneLabel.text = p.telNum;
    cell.headImageView.image = p.headIamge;
    
    // 设置代理
    cell.delegate = self;
    
    // 表示cell上的button
    cell.phoneButton.buttonIndex = indexPath;
    
    
    return cell;
}

// Cell代理方法
// 打电话
- (void)callBackPhoneButton:(CellButton *)aButton
{
    
    // 找出对应的人然后打电话
    Person *p = [[SingleData shareDataHandle] searchPerosn:aButton.buttonIndex];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",p.telNum]]];
    
    

}
- (void)callBackSmsButton:(CellButton *)aButton
{
    // 找出对应联系人然后打电话
    Person *p = [[SingleData shareDataHandle] searchPerosn:aButton.buttonIndex];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",p.telNum]]];

}






- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sd.groupArray[section];
}


// 设置Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [ListTableViewCell cellHeight];
    
}

//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    // 将索引传入
    detailVC.indexPath = indexPath;

    [self.navigationController pushViewController:detailVC animated:YES];


}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
