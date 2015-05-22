//
//  LoginVC.m
//  wenyi
//
//  Created by Alex Wu on 15/5/22.
//  Copyright (c) 2015年 Alex Wu. All rights reserved.
//

#import "LoginVC.h"
#import "EaseMob.h"

@interface LoginVC ()

@property (nonatomic, weak) IBOutlet UITextField *usernameTF;
@property (nonatomic, weak) IBOutlet UITextField *passwordTF;

@end

@implementation LoginVC

#pragma mark -
#pragma mark - custom methods

- (IBAction)dismissKeyboard:(id)sender
{
    [self.usernameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

- (void)loginResult
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)login:(id)sender
{
    [self dismissKeyboard:nil];
    [self showProgressHud:@"login..."];

    __weak LoginVC *weakSelf = self;
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.usernameTF.text password:self.passwordTF.text completion:^(NSDictionary *loginInfo, EMError *error) {
        [weakSelf hideProgressHud];
        if (!error && loginInfo) {
            NSLog(@"登录成功");
            [weakSelf showMessage:@"登录成功"];
            [weakSelf loginResult];
        } else {
            NSLog(@"登录失败");
            [weakSelf showMessage:@"登录失败"];
        }
    } onQueue:nil];
}

#pragma mark -
#pragma mark - view controller lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"登录";
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
