//
//  HomeVC.m
//  wenyi
//
//  Created by Alex Wu on 15/5/22.
//  Copyright (c) 2015年 Alex Wu. All rights reserved.
//

#import "HomeVC.h"
#import "LoginVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"99问医";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        LoginVC *loginVC = [[LoginVC alloc] init];
        [self.appDelegate.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:YES completion:nil];
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
