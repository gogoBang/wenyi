//
//  DoctorDetailVC.m
//  wenyi
//
//  Created by Alex Wu on 15/5/22.
//  Copyright (c) 2015年 Alex Wu. All rights reserved.
//

#import "DoctorDetailVC.h"
#import "DoctorLiveVC.h"
#import "DoctorServiceVC.h"

@interface DoctorDetailVC ()

@end

@implementation DoctorDetailVC

#pragma mark -
#pragma mark - custom methods

- (IBAction)doctorLive:(id)sender
{
    DoctorLiveVC *liveVC = [[DoctorLiveVC alloc] init];
    [self.navigationController pushViewController:liveVC animated:YES];
}

- (IBAction)doctorService:(id)sender
{
    DoctorServiceVC *serviceVC = [[DoctorServiceVC alloc] init];
    [self.navigationController pushViewController:serviceVC animated:YES];
}

#pragma mark -
#pragma mark - view controller lifecycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"呼吸内科";
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
