//
//  CZHelpViewController.m
//  网易彩票
//
//  Created by apple on 15-1-9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZHelpViewController.h"
#import "CZHtmlPage.h"
#import "CZWebViewController.h"

@interface CZHelpViewController ()

/**
 *  所有的见面信息，存储CZHtmlPage对象
 */
@property(nonatomic,strong)NSArray *htmls;

@end

@implementation CZHelpViewController

-(NSArray *)htmls{
    if (!_htmls) {
         //从help.json加载数据
        
        //1.获取json路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"help.json" ofType:nil];
        
        //2.把json转成NSData
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        //3.再把NSData转成数组
        
        //json的序列化 "就是把数据转成字典/数组"
        NSArray *helpArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",obj);
        
        //4.遍历数组里字典，转成模型
        NSMutableArray *htmlsM =[NSMutableArray array];
        for (NSDictionary *dict in helpArr) {
            CZHtmlPage *htmlPage = [CZHtmlPage htmlPageWithDict:dict];
            [htmlsM addObject:htmlPage];
        }
        
        _htmls = htmlsM;
    }
    
    return _htmls;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.htmls);
    
    //把htmls的数据转成cellData显示的数据
    CZSettingGroup *group = [[CZSettingGroup alloc] init];
    
    
    NSMutableArray *items = [NSMutableArray array];
    for (CZHtmlPage *htmlPage in self.htmls) {
        CZSettingArrowItem *item = [CZSettingArrowItem itemWithIcon:nil title:htmlPage.title];
        [items addObject:item];
    }
    group.items = items;
    
    [self.cellData addObject:group];
    
   
    //如果要在应用里显示的网页
    //使用一个叫UIWebView控件，这个控制就能显示网页
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //进入一个叫 “网页的控制器”
    
    // 1.创建一个导航控制器,设置它的子控制器为 “网页的控制器”
    CZWebViewController *webVc = [[CZWebViewController alloc] init];
    
    // 设置模型数据
    webVc.htmlPage = self.htmls[indexPath.row];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVc];
    
    
    // 2.以模态窗口的方式来打开控制器
    [self presentViewController:nav animated:YES completion:nil];
    
    
}

@end
