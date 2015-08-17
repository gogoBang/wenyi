//
//  DoctorVC.m
//  wenyi
//
//  Created by Alex Wu on 15/5/22.
//  Copyright (c) 2015年 Alex Wu. All rights reserved.
//

#import "DoctorVC.h"
#import "DoctorDetailVC.h"

@interface DoctorVC ()


@end

@implementation DoctorVC

#pragma mark -
#pragma mark - custom methods

- (IBAction)doctor:(id)sender
{
    DoctorDetailVC *doctor = [[DoctorDetailVC alloc] init];
    doctor.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:doctor animated:YES];
}

#pragma mark -
#pragma mark - view controller lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"问医";
    [self.navigationController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"wenyi_c.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
