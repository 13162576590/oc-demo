//
//  CZShareViewController.m
//  网易彩票
//
//  Created by apple on 15-1-9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZShareViewController.h"
#import <MessageUI/MessageUI.h>

@interface CZShareViewController ()<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@end

@implementation CZShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化数据
    //初始化数据
    //第一组
    CZSettingItem *item1 = [CZSettingArrowItem itemWithIcon:@"MailShare" title:@"新浪微博"];
    CZSettingItem *item2= [CZSettingArrowItem itemWithIcon:@"MailShare" title:@"短信分享" ];
    
    //弱引用
    //__weak CZShareViewController *selfVc = self;
    
    //不要加*数
    __weak typeof(self) selfVc = self;
    
    //block 循环引用
    item2.operation = ^{
        //发短信 不能设置短信内容
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://10086"]];
        NSLog(@"====");
        //判断能否接收短信
        if (![MFMessageComposeViewController canSendText]) {
            return ;
        }
        
        //如果要设置内容，我使用MessageUI
        //1.创建MFMessageComposeViewController
        MFMessageComposeViewController *msgVc = [[MFMessageComposeViewController alloc] init];
        
        //设置电话
        msgVc.recipients = @[@"10086",@"10010"];
        
        //设置内容
        msgVc.body = @"恭喜你中奖，请选汇款.....";
        
        //设置代理
        msgVc.messageComposeDelegate = selfVc;
        
        //显示信息界面
        [selfVc presentViewController:msgVc animated:YES completion:nil];
    };

    CZSettingItem *item3 = [CZSettingArrowItem itemWithIcon:@"MailShare" title:@"邮件分享"];
    

    
    item3.operation = ^{
        //邮件分享 不能设置内容
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://123213412@qq.com"]];
        
        //创建MFMailComposeViewControler
        //在模拟器上是可以运行
        MFMailComposeViewController *mailVc = [[MFMailComposeViewController alloc] init];
        
        //设置接收邮件人
        [mailVc setToRecipients:@[@"123423@qq.com",@"qwew@qq.com"]];
        
        //抄送
        [mailVc setCcRecipients:@[@"123423@qq.com",@"qwew@qq.com"]];
        
        //密送
        [mailVc setBccRecipients:@[@"123423@qq.com",@"qwew@qq.com"]];
        
        //设置内容
        [mailVc setMessageBody:@"恭喜你中奖 ...." isHTML:NO];
        
        //设置代理
        mailVc.mailComposeDelegate = self;
        
        [selfVc presentViewController:mailVc animated:YES completion:nil];
        
    };
    CZSettingGroup *group1 = [[CZSettingGroup alloc] init];
    group1.items = @[item1,item2,item3];
    
    [self.cellData addObject:group1];

}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

#pragma mark 信息的代理方法
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
//    MessageComposeResultCancelled,
//    MessageComposeResultSent,
//    MessageComposeResultFailed
    if (result == MessageComposeResultCancelled || result == MessageComposeResultSent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

#pragma mark 邮件的代理方法
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
//    MFMailComposeResultCancelled,
//    MFMailComposeResultSaved,
//    MFMailComposeResultSent,
//    MFMailComposeResultFailed
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
