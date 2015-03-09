//
//  MyNavgationVC.m
//  UITabBarController
//
//  Created by hx_leichunxiang on 15-3-5.
//  Copyright (c) 2015年 leichunxiang. All rights reserved.
//  功能描述：解决tabBar的导航控制push时，被push的viewcontroller隐藏tabBar。

#import "MyNavgationVC.h"

@interface MyNavgationVC ()

@end

@implementation MyNavgationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //解决tabBar的导航控制push时，被push的viewcontroller隐藏tabBar。
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];
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
