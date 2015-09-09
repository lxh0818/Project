//
//  DetailViewController.m
//  TELBook
//
//  Created by 小爪乎黑 on 15/7/3.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "DetailViewController.h"
#import "SetViewController.h"
#import "DetailView.h"
#import "SingleData.h"

@interface DetailViewController ()<UIAlertViewDelegate,SetViewControllerDelegate>

@property (nonatomic,strong)DetailView *dv;

@end

@implementation DetailViewController

-(void)loadView
{
    self.dv = [[DetailView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _dv;

}

- (void)viewWillAppear:(BOOL)animated
{
//    NSString *group = [SingleData shareDataHandle].groupArray[_indexPath.section];
//    
//    Person *p = [SingleData shareDataHandle].DataDict[group][_indexPath.row];

    
    Person *p = [[SingleData shareDataHandle] searchPerosn:_indexPath];
    self.dv.nameLabel.text = p.name;
    self.dv.telLabel.text = p.telNum;
    self.dv.mailLabel.text = p.mail;
    self.dv.infoTextView.text = p.info;
    self.dv.headImageView.image = p.headIamge;
    


}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置
    self.dv.part1.text = @"信息";
    self.dv.telTitleLabel.text = @"电话";
    self.dv.mailTitleLabel.text = @"邮箱";
    self.dv.part2.text = @"详情";
    [self.dv.phoneButton setBackgroundImage:[UIImage imageNamed:@"phone.png"] forState:(UIControlStateNormal)];
    [self.dv.smsButton setBackgroundImage:[UIImage imageNamed:@"sms.png"] forState:(UIControlStateNormal)];
    [self.dv.mailButton setBackgroundImage:[UIImage imageNamed:@"mail.png"] forState:(UIControlStateNormal)];
    [self.dv.deleteButton setTitle:@"删除该联系人" forState:(UIControlStateNormal)];
    self.dv.deleteButton.layer.borderWidth = 1;
    self.dv.deleteButton.layer.cornerRadius = 5;


    // 电话
    [self.dv.phoneButton addTarget:self action:@selector(phoneButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 短信
    [self.dv.smsButton addTarget:self action:@selector(smsButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 邮件
    [self.dv.mailButton addTarget:self action:@selector(mailButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];

    
    
    // 删除按钮点击事件
    [self.dv.deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 右barbutton
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemEdit) target:self action:@selector(rightBarButtonItemAction:)];
    
    
}

// 打电话
- (void)phoneButtonAction:(UIButton *)sender
{
    Person *p = [[SingleData shareDataHandle] searchPerosn:_indexPath];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",p.telNum]]];

}

// 发短信

- (void)smsButtonAction:(UIButton *)sender
{
    Person *p = [[SingleData shareDataHandle] searchPerosn:_indexPath];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",p.telNum]]];
    
    
}



// 发邮件

- (void)mailButtonAction:(UIButton *)sender
{
    Person *p = [[SingleData shareDataHandle] searchPerosn:_indexPath];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",p.mail]]];
    
    
}





// 右barButton点击方法
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{

    SetViewController *setVC = [[SetViewController alloc] init];
    // 设置代理
    setVC.delegate = self;
    setVC.indexPath = _indexPath;
    
    [self presentViewController:setVC animated:YES completion:nil];
    

}



// 删除按钮点击方法
- (void)deleteButtonAction:(UIButton *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
    

}
// alertView代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
            
        case 1:
            
            // 删除该对象
            [[SingleData shareDataHandle] deletePerson:_indexPath];
            // 删完退出
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            break;
            
        default:
            break;
    }


}

// 实现传值代理方法

-(void)passValue:(NSIndexPath *)index
{
    self.indexPath = index;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
