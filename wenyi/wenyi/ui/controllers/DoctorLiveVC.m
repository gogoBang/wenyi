//
//  DoctorLiveVC.m
//  wenyi
//
//  Created by Alex Wu on 15/5/22.
//  Copyright (c) 2015年 Alex Wu. All rights reserved.
//

#import "DoctorLiveVC.h"
#import "EaseMob.h"

@interface DoctorLiveVC ()<IChatManagerDelegate>

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
    if ([message.conversationChatter isEqualToString:@"1432311450759715"]&&msgBody.messageBodyType==eMessageBodyType_Text) {
        
        NSString *txt = ((EMTextMessageBody *)msgBody).text;
        if (txt.length>0) {
            [self.chatArray addObject:[NSString stringWithFormat:@"%@：%@", message.groupSenderName, txt]];
            [self.chatTV reloadData];
            [self.chatTV scrollRectToVisible:CGRectMake(0.0, self.chatTV.contentSize.height - 1, self.chatTV.contentSize.width, 1) animated:NO];
        }
    }
}

#pragma mark -
#pragma mark - view controller lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"张医生-呼吸内科";
    self.chatArray = [NSMutableArray array];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
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
