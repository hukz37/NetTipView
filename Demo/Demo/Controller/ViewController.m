//
//  ViewController.m
//  Demo
//
//  Created by hukezhu on 16/5/10.
//  Copyright © 2016年 hukezhu. All rights reserved.
//

#import "ViewController.h"
#import "NewListViewController.h"
#import "NetTipView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}
/**
 *  @author hu, 16-05-10 14:05:29
 *
 *  点击按钮跳转到新闻列表页面
 *
 *
 */
- (IBAction)btnClick:(id)sender {
    
    NewListViewController *newListVc = [[NewListViewController alloc]init];
    [self.navigationController pushViewController:newListVc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
