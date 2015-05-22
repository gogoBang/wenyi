//
//  DoctorLiveVC.m
//  wenyi
//
//  Created by Alex Wu on 15/5/22.
//  Copyright (c) 2015年 Alex Wu. All rights reserved.
//

#import "DoctorLiveVC.h"
#import "EaseMob.h"

@interface DoctorLiveVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *chatTV;
@property (nonatomic, strong) NSMutableArray *chatArray;

@end

@implementation DoctorLiveVC

#pragma mark -
#pragma mark - custom methods

- (IBAction)doctorService:(id)sender
{
    
}

#pragma mark -
#pragma mark - tableView delegate and data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chatArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *chatCellIdentifier = @"chatCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chatCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chatCellIdentifier];
    }
    cell.textLabel.text = [self.chatArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark - chat manager delegate methods

-(void)didReceiveMessage:(EMMessage *)message
{
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
    switch (msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
            NSString *txt = ((EMTextMessageBody *)msgBody).text;
            NSLog(@"收到的文字是 txt -- %@",txt);
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark - view controller lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"张医生-呼吸内科";
    self.chatArray = [NSMutableArray array];
    for (int i = 0; i <= 100; i ++) {
        [self.chatArray addObject:[NSString stringWithFormat:@"chatContent%i", i]];
    }
    
    [[EaseMob sharedInstance].chatManager asyncJoinPublicGroup:@"1432311450759715" completion:^(EMGroup *group, EMError *error) {
        if (!error) {
            NSLog(@"入群成功");
        }
    } onQueue:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[EaseMob sharedInstance].chatManager asyncLeaveGroup:@"1432311450759715" completion:^(EMGroup *group, EMGroupLeaveReason reason, EMError *error) {
        if (!error) {
            NSLog(@"退出群组成功");
        }
    } onQueue:nil];
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
