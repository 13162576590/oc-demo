//
//  CZAboutViewController.m
//  网易彩票
//
//  Created by apple on 15-1-9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZAboutViewController.h"

@interface CZAboutViewController ()

@end

@implementation CZAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CZSettingItem *item1 = [CZSettingArrowItem itemWithIcon:nil title:@"评分支持"];
    
    item1.operation = ^{
        //跳到appstore 对应的应用的界面
        /*1.评分
        》使用UIApplication打开URL 如 "itms-apps://itunes.apple.com/cn/app/%@?mt=8"
        》注意把id替换成appid //eg.725296055
         //appid 与bundleId是不同，每一个应用上传到appstore之后，就会有一个ID,这个ID是纯数字
        》什么是appID,每个应用上架后就有个application ID
         */
        
        //itms-apps://itunes.apple.com/cn/app/725296055?mt=8
        NSString *url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/%@?mt=8",@"725296055"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
    };
    CZSettingItem *item2= [CZSettingArrowItem itemWithIcon:nil title:@"客户电话" ];
    item2.subTitle = @"10086";
    item2.operation = ^{
        //打电话
        NSURL *url = [NSURL URLWithString:@"tel://10010"];
        [[UIApplication sharedApplication] openURL:url];
    };
    
    CZSettingGroup *group = [[CZSettingGroup alloc] init];
    group.items = @[item1,item2];
    
    [self.cellData addObject:group];
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
