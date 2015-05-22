//
//  DoctorServiceVC.m
//  wenyi
//
//  Created by Alex Wu on 15/5/22.
//  Copyright (c) 2015年 Alex Wu. All rights reserved.
//

#import "DoctorServiceVC.h"
#import "EaseMob.h"

@interface DoctorServiceVC ()<IChatManagerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *chatTV;
@property (nonatomic, weak) IBOutlet UIView *inputView;
@property (nonatomic, weak) IBOutlet UITextView *inputTextView;
@property (nonatomic, strong) NSMutableArray *chatArray;

@end

@implementation DoctorServiceVC

#pragma mark -
#pragma mark - custom methods

- (IBAction)sendMessage:(id)sender
{
    NSString *inputStr = self.inputTextView.text;
    if (inputStr.length<=0) {
        return;
    }
    EMChatText *txtChat = [[EMChatText alloc] initWithText:inputStr];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:txtChat];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithReceiver:@"1432311450759715" bodies:@[body]];
    message.isGroup = YES; // 设置是否是群聊
    
    [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil];
    [self.chatArray addObject:[NSString stringWithFormat:@"我：%@", inputStr]];
    [self.chatTV reloadData];
    [self.chatTV scrollRectToVisible:CGRectMake(0.0, self.chatTV.contentSize.height - 1, self.chatTV.contentSize.width, 1) animated:NO];
    self.inputTextView.text = @"";
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.inputTextView resignFirstResponder];
    
    CGFloat height = 0;
    self.inputView.frame = CGRectMake(0, self.view.frame.size.height - height - self.inputView.frame.size.height, self.view.frame.size.width, self.inputView.frame.size.height);
    self.chatTV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.inputView.frame.origin.y);
    [self.chatTV scrollRectToVisible:CGRectMake(0.0, self.chatTV.contentSize.height - 1, self.chatTV.contentSize.width, 1) animated:NO];
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
#pragma mark - keyboard frame changed

-(void)keyboardWillChangeFrame:(NSNotification*)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* bValue = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];//更改后的键盘
    
    CGRect bFrame = [bValue CGRectValue];
    CGRect keyboardRect = [aValue CGRectValue];
    
    if (bFrame.origin.y == keyboardRect.origin.y) {
        return;
    }
    
    CGFloat height = keyboardRect.size.height;
    
    if (keyboardRect.origin.y<479) {
        //键盘弹出
        _inputView.frame = CGRectMake(0, self.view.frame.size.height-height-self.inputView.frame.size.height, self.view.frame.size.width, self.inputView.frame.size.height);
        CGRect aframe = self.inputView.frame;
        NSLog(@"frame: %f %f %f %f", aframe.origin.x, aframe.origin.y, aframe.size.width, aframe.size.height);

    } else {
        //键盘消失
        _inputView.frame = CGRectMake(0, self.view.frame.size.height-self.inputView.frame.size.height, self.view.frame.size.width, self.inputView.frame.size.height);
        CGRect aframe = self.inputView.frame;
        NSLog(@"frame: %f %f %f %f", aframe.origin.x, aframe.origin.y, aframe.size.width, aframe.size.height);
    }
    self.chatTV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.inputView.frame.origin.y);
    [self.chatTV scrollRectToVisible:CGRectMake(0.0, self.chatTV.contentSize.height - 1, self.chatTV.contentSize.width, 1) animated:NO];
    [self.view layoutIfNeeded];
    NSLog(@"ismain: %@", [NSThread isMainThread]?@"yes":@"no");
}

#pragma mark -
#pragma mark - view controller lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"张医生-呼吸内科";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.chatTV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)]];
    
    self.chatArray = [NSMutableArray array];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [[EaseMob sharedInstance].chatManager asyncJoinPublicGroup:@"1432311450759715" completion:^(EMGroup *group, EMError *error) {
        if (!error) {
            NSLog(@"入群成功");
        }
    } onQueue:nil];
}

- (void)dealloc
{
    [[EaseMob sharedInstance].chatManager asyncLeaveGroup:@"1432311450759715" completion:^(EMGroup *group, EMGroupLeaveReason reason, EMError *error) {
        if (!error) {
            NSLog(@"退出群组成功");
        }
    } onQueue:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
