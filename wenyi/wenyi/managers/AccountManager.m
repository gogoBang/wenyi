//
//  AccountManager.m
//  wenyi
//
//  Created by Alex Wu on 15/5/23.
//  Copyright (c) 2015年 Alex Wu. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager

static AccountManager *shareInstance = nil;

+ (AccountManager*)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[AccountManager alloc] init];
    });
    return shareInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        self.password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
    return self;
}

@end
