//
//  SHBaseVC.m
//  wenyi
//
//  Created by Alex Wu on 15/5/22.
//  Copyright (c) 2015年 Alex Wu. All rights reserved.
//

#import "SHBaseVC.h"
#import "MBProgressHUD.h"

@interface SHBaseVC ()
{
    MBProgressHUD *hud;
}

@end

@implementation SHBaseVC

#pragma mark -
#pragma mark - custom methods

- (void)showProgressHud:(NSString*)message
{
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
    }
    hud.labelText = message;
    [hud show:YES];
}

- (void)hideProgressHud
{
    [hud hide:YES];
}

- (void)showMessage:(NSString *)message
{
    if (self.view.window==nil) {
        return;
    }
    MBProgressHUD *aHud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    
    // Configure for text only and offset down
    aHud.mode = MBProgressHUDModeText;
    aHud.animationType = MBProgressHUDAnimationFade;
    aHud.labelText = message;
    aHud.margin = 10.f;
    aHud.yOffset = 150.f;
    aHud.removeFromSuperViewOnHide = YES;
    
    [aHud hide:YES afterDelay:1.618];
}

#pragma mark -
#pragma mark - view controller lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appDelegate = [UIApplication sharedApplication].delegate;
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
