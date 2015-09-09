//
//  AddViewController.m
//  TELBook
//
//  Created by 小爪乎黑 on 15/7/3.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "AddViewController.h"
#import "AddView.h"
#import "Person.h"
#import "SingleData.h"

@interface AddViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)AddView *av;

@end

@implementation AddViewController

-(void)loadView
{
    self.av = [[AddView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _av;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置
    self.av.nameTitleLabel.text = @"姓名";
    self.av.telTitleLabel.text = @"电话";
    self.av.mailTitleLabel.text = @"短信";
    self.av.infoTitelLabel.text = @"详情";
    
    [self.av.finishButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.av.cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
    
    
    
    
    
    
    
    
    
    // 开交互
    self.av.headImageView.userInteractionEnabled = YES;
    // 轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    // 给图片添加手势
    [_av.headImageView addGestureRecognizer:tap];
    
    // 给取消按钮添加点击事件
    [self.av.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 确定按钮的点击事件
    [self.av.finishButton addTarget:self action:@selector(finishButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
  
}
// 手势响应方法
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"添加图片");
    // 1.初始化相册控制器
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    // 允许编辑
    picker.allowsEditing = YES;
    // 数据源
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //设置代理
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];



}

// 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    self.av.headImageView.image = info[UIImagePickerControllerEditedImage]
    ;

    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 取消按钮点击事件
- (void)cancelButtonAction:(UIButton *)sender
{
    // 取消模态视图
    [self dismissViewControllerAnimated:YES completion:nil];

}

// 确定确定按钮的点击方法
- (void)finishButtonAction:(UIButton *)sender
{
    
    
    
    if (_av.nameTextField.text.length == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alertView show];
        
        
        
    }else{
        
        
        // 获取联系人信息 准备存入
        Person *p = [[Person alloc] init];
        
        p.name = _av.nameTextField.text;
        p.telNum = _av.telTextField.text;
        p.mail = _av.mailTextField.text;
        p.info = _av.infoTextView.text;
        p.headIamge = _av.headImageView.image;
        
        // 添加
        [[SingleData shareDataHandle] addPerosn:p];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    
    
    }
    
    


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
