//
//  MyTaBarVC.m
//  UITabBarController
//
//  Created by hx_leichunxiang on 15-2-28.
//  Copyright (c) 2015年 leichunxiang. All rights reserved.
//  功能描述：tabBar的半自定义与自定义；

#import "MyTaBarVC.h"
#import "UIImage+MyImage.h"
#import "Item1ViewController.h"
#include "ItemB1ViewController.h"
#import "MyNavgationVC.h"

#define kScreenWidth        [UIScreen mainScreen].applicationFrame.size.width
#define kTabbarHeight       49
#define kBaseTag 1000


@interface MyTaBarVC ()
{
    NSInteger _selectedIndex;
    UIImageView * bgView;
    NSArray * _titleItems;
}
@end

@implementation MyTaBarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _titleItems = @[@"首页",@"资讯",@"账户",@"设置"];
    
//    [self systemTabBar];
    
    [self customTabBar];
}

#pragma - mark 1、半自定义tabBar

//半自定义有bug：未选中时，背景是灰色。
- (void)systemTabBar
{
    NSArray * items = _titleItems;
    
    NSMutableArray *vcArr = [NSMutableArray array];
    for (int i = 0; i<4; i++)
    {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1];
        vc.title = items[i];
        
        //测试push时，tabBar是否隐藏
        if (i == 0)
        {
            vc = [[Item1ViewController alloc] init];
            vc.title = items[i];
        }
        else if (i == 1)
        {
            vc = [[ItemB1ViewController alloc] init];
            vc.title = items[i];
            vc.view.backgroundColor = [UIColor purpleColor];
        }
        
        MyNavgationVC *nav = [[MyNavgationVC alloc] initWithRootViewController:vc];
        
        //tabBarItem
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:items[i] image:nil tag:i];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:items[i] image:[UIImage imageWithName:[NSString stringWithFormat:@"tabbar_n_%d",i ]] selectedImage:[UIImage imageWithName:[NSString stringWithFormat:@"tabbar_s_%d",i ]]];
        tabBarItem.tag = i;
        nav.tabBarItem = tabBarItem;
        
        [vcArr addObject:nav];
    }
    
    self.viewControllers = [vcArr copy];
    
}

#pragma - mark 2、自定义tabBar
/*
 1、设置属性viewControllers；
 2、添加自定义背景view为系统tabBar子视图。
 */

- (void)customTabBar
{
    [self getViewControllers];
    
    [self initCustomTabBar];
}

- (NSArray *)getViewControllers
{
    //viewControllers
    NSArray * items = _titleItems;
    NSMutableArray *vcArr = [NSMutableArray array];
    for (int i = 0; i < items.count; i++)
    {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1];
        vc.title = items[i];
        
        //测试push时，tabBar是否隐藏
        if (i == 0)
        {
            vc = [[Item1ViewController alloc] init];
            vc.title = items[i];
        }
        else if (i == 1)
        {
            vc = [[ItemB1ViewController alloc] init];
            vc.title = items[i];
            vc.view.backgroundColor = [UIColor purpleColor];
        }
        
        MyNavgationVC *nav = [[MyNavgationVC alloc] initWithRootViewController:vc];
        nav.navigationBar.translucent = NO;
        
        
        [vcArr addObject:nav];
    }
    self.viewControllers = [vcArr copy];
    return vcArr;
}

- (void)initCustomTabBar
{
    //tabBar
    NSArray * items = _titleItems;

    bgView = [[UIImageView alloc] init];
    bgView.frame = CGRectMake(0, 0, kScreenWidth, kTabbarHeight);
    bgView.userInteractionEnabled = YES;
    [self.tabBar addSubview:bgView];
    
    for (int i = 0; i < items.count; i++)
    {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake( 30 + kScreenWidth/items.count*i, 5, kScreenWidth/items.count - 30*2, 22)];
        img.tag = 100 + i;
        img.image = [UIImage imageWithName:[NSString stringWithFormat:@"tabbar_n_%d",i ]];
        [self.tabBar addSubview:img];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/items.count*i, img.frame.origin.y + img.frame.size.height + 4, kScreenWidth/items.count, 12)];
        titleLabel.tag = 200 + i;
        titleLabel.text = items[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        [self.tabBar addSubview:titleLabel];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWidth/items.count*i, 0, kScreenWidth/items.count, kTabbarHeight);
        btn.tag = kBaseTag + i;
        [btn setBackgroundImage:[UIImage imageWithName:@"tabbar_back"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithName:@"tabbar_back_s"] forState:UIControlStateDisabled];
        [btn setBackgroundImage:[UIImage imageWithName:@"tabbar_back"] forState:UIControlStateHighlighted];

        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
        
        if (i == 0)
        {
            btn.enabled = NO;
            _selectedIndex = 0;
            img.image = [UIImage imageWithName:[NSString stringWithFormat:@"tabbar_s_%d",i ]];
            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_s_%d",i ]];

            titleLabel.textColor = [UIColor blueColor];
        }
    }
}

- (void)btnAction:(UIButton *)sender
{
    //tabBarVC 选中的VC 变化
    self.selectedIndex = sender.tag - kBaseTag;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (bgView)
    {
        UIButton *selectedBtn = (UIButton *)[bgView viewWithTag:kBaseTag + selectedIndex];
        [self tabBarBtnChange:selectedBtn];
    }
    
    [super setSelectedIndex:selectedIndex];
}

- (void)tabBarBtnChange:(UIButton *)sender
{
    //以前选中的 btn 、img 、label,变为normal状态。
    UIButton *selectedBtn = (UIButton *)[bgView viewWithTag:_selectedIndex + kBaseTag];
    selectedBtn.enabled = YES;
    UIImageView *img = (UIImageView *)[self.tabBar viewWithTag:_selectedIndex + 100];
    img.image = [UIImage imageWithName:[NSString stringWithFormat:@"tabbar_n_%li",(long)_selectedIndex]];
    UILabel *label = (UILabel *)[self.tabBar viewWithTag:_selectedIndex + 200];
    label.textColor = [UIColor grayColor];
    
    //现在选中的 btn 、img 、label,变为selected状态。
    _selectedIndex = sender.tag - kBaseTag;
    sender.enabled = NO;
    UIImageView *slectedImg = (UIImageView *)[self.tabBar viewWithTag:_selectedIndex + 100];
    slectedImg.image = [UIImage imageWithName:[NSString stringWithFormat:@"tabbar_s_%li",(long)_selectedIndex]];
    UILabel *selectedLabel = (UILabel *)[self.tabBar viewWithTag:_selectedIndex + 200];
    selectedLabel.textColor = [UIColor blueColor];
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
