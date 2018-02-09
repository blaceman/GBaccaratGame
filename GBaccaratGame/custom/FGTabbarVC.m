//
//  FGTabbarVC.m
//  miaobang
//
//  Created by qiuxiaofeng on 17/5/4.
//  Copyright © 2017年 figo. All rights reserved.
//

#import "FGTabbarVC.h"

#import "GBPlayOneViewController.h"
#import "GBPlayTwoViewController.h"
#import "GBMineViewController.h"


@interface FGTabbarVC ()

@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *normalImageNameArray;
@property (nonatomic,strong)NSMutableArray *selectedImageNameArray;
@property (nonatomic,strong)UIButton *complaintView;
@property (nonatomic,assign)BOOL middleItemStatue;
@end

@implementation FGTabbarVC
static UIView *view;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleArray = [NSMutableArray arrayWithArray:@[@"游戏一", @"游戏二",@"我的"]];

    NSMutableArray *arrNavi = [[NSMutableArray alloc]init];
    NSArray *arrVC = @[@"GBPlayOneViewController",@"GBPlayTwoViewController",@"GBMineViewController"];
    for (int i = 0; i < arrVC.count; i++) {
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[[NSClassFromString(arrVC[i]) alloc]init]];
        [arrNavi addObject:navi];
    }
    self.viewControllers = arrNavi;
    
    self.tabBar.translucent = NO;
    
    [self customizeTabBar];
}

- (void)customizeTabBar
{
    
    _normalImageNameArray = [NSMutableArray arrayWithArray:@[@"ic_main_tab_discover_normal",@"ic_main_tab_discover_normal",@"ic_main_tab_discover_normal"]];
    _selectedImageNameArray = [NSMutableArray arrayWithArray:@[@"ic_main_tab_discover_normal",@"ic_main_tab_discover_normal",@"ic_main_tab_discover_normal"]];
    
    NSUInteger index = 0;
    for (UINavigationController *navigationController in self.viewControllers) {
        
        UIViewController *viewController = navigationController.viewControllers.firstObject;
        
        NSString *title = self.titleArray[index];
        NSString *normalImageName = _normalImageNameArray[index];
        NSString *selectedImageName = _selectedImageNameArray[index];
        
        UIImage *normalImage = [UIImage imageNamed:normalImageName];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage tag:index];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromHex(0x949494)} forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromHex(0x1a5aa7)} forState:UIControlStateSelected];
        if ([normalImage respondsToSelector:@selector(imageWithRenderingMode:)]) {
            normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        [tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        tabBarItem.image = normalImage;
        tabBarItem.selectedImage = selectedImage;
        
        viewController.tabBarItem = tabBarItem;
        index++;
    }
    
}




@end
