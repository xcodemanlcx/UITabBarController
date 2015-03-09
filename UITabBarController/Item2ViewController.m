//
//  Item2ViewController.m
//  UITabBarController
//
//  Created by hx_leichunxiang on 15-3-5.
//  Copyright (c) 2015年 leichunxiang. All rights reserved.
//  功能描述：UITabBarController中视图控制器间的切换。

#import "Item2ViewController.h"
#import "ItemB2ViewController.h"
#import "MyTaBarVC.h"

@interface Item2ViewController ()

@end

@implementation Item2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Item2";
    
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 150, 100, 100);
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:40];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction:(UIButton *)sender
{
    //步骤一、二、三循序不能变，优先设置tabBarController.selectedIndex。不然设置无效。
    
    //步骤一
    self.tabBarController.selectedIndex = 1;
    
    //步骤二
    UINavigationController *nav = (UINavigationController *)self.tabBarController.viewControllers[1];
    ItemB2ViewController *b2 = [[ItemB2ViewController alloc] init];
    [nav pushViewController:b2 animated:YES];
    
    //步骤三
    [self.navigationController popViewControllerAnimated:NO];
    
    
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
