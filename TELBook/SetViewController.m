//
//  SetViewController.m
//  TELBook
//
//  Created by 小爪乎黑 on 15/7/3.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "SetViewController.h"
#import "AddView.h"
#import "SingleData.h"
#import "pinyin.h"

@interface SetViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)AddView *sv;

// 用来保存原来的名字
@property (nonatomic,copy)NSString *oldName;

@end

@implementation SetViewController


-(void)viewWillAppear:(BOOL)animated
{
    NSString *group = [SingleData shareDataHandle].groupArray[_indexPath.section];
    
    Person *p = [SingleData shareDataHandle].DataDict[group][_indexPath.row];
    self.oldName = p.name;
    
    _sv.headImageView.image = p.headIamge;
    _sv.nameTextField.text = p.name;
    _sv.telTextField.text = p.telNum;
    _sv.mailTextField.text = p.mail;
    _sv.infoTextView.text = p.info;

    


}

-(void)loadView
{
    self.sv = [[AddView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _sv;
    
    
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置
    self.sv.nameTitleLabel.text = @"姓名";
    self.sv.telTitleLabel.text = @"电话";
    self.sv.mailTitleLabel.text = @"短信";
    self.sv.infoTitelLabel.text = @"详情";
    
    [self.sv.finishButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.sv.cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
    
    
    
    [self.sv.finishButton addTarget:self action:@selector(finishButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.sv.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    // 开交互
    self.sv.headImageView.userInteractionEnabled = YES;
    // 轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    // 给图片添加手势
    [_sv.headImageView addGestureRecognizer:tap];

    
    
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

// 取消
- (void)cancelButtonAction:(UIButton *)sender
{

    [self dismissViewControllerAnimated:YES completion:nil];

}



// 完成点击方法
- (void)finishButtonAction:(UIButton *)sender
{
    
    // 判断是否于原来的名字一致
    if ([_oldName isEqualToString:_sv.nameTextField.text]) {
        
        NSString *group = [SingleData shareDataHandle].groupArray[_indexPath.section];
        
        Person *p = [SingleData shareDataHandle].DataDict[group][_indexPath.row];
        
        p.headIamge = _sv.headImageView.image ;
        p.name = _sv.nameTextField.text;
        p.telNum = _sv.telTextField.text;
        p.mail = _sv.mailTextField.text;
        p.info = _sv.infoTextView.text;
        
    }else{
        
        Person *p = [[Person alloc] init];
        
        p.headIamge = _sv.headImageView.image ;
        p.name = _sv.nameTextField.text;
        p.telNum = _sv.telTextField.text;
        p.mail = _sv.mailTextField.text;
        p.info = _sv.infoTextView.text;
        
        // 删除
        [[SingleData shareDataHandle] deletePerson:_indexPath];
        
        // 添加
        [[SingleData shareDataHandle] addPerosn:p];
        
        // 获取分组位置
        // 获取分组名
        NSString *first = [_sv.nameTextField.text uppercasePinYinFirstLetter];
        // 获取这是第几分组
        NSInteger section = [[SingleData shareDataHandle].groupArray indexOfObject:first];
        
        // 获取所在组内位置
        NSInteger row = [[SingleData shareDataHandle].DataDict[first] count] - 1;
        // 创建新的indexPath
        NSIndexPath *tempIndex = [NSIndexPath indexPathForRow:row inSection:section];
        
        // 回传
        [self.delegate passValue:tempIndex];
        
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];



}



// 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    self.sv.headImageView.image = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
