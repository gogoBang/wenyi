//
//  SHBaseVC.h
//  wenyi
//
//  Created by Alex Wu on 15/5/22.
//  Copyright (c) 2015年 Alex Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SHBaseVC : UIViewController

@property (nonatomic, weak) AppDelegate *appDelegate;

- (void)showProgressHud:(NSString*)message;
- (void)hideProgressHud;
- (void)showMessage:(NSString*)message;

@end
