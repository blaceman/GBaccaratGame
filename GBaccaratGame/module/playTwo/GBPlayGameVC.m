//
//  GBPlayGameVC.m
//  GBaccaratGame
//
//  Created by blaceman on 2018/2/24.
//  Copyright © 2018年 new4545. All rights reserved.
//

#import "GBPlayGameVC.h"

@implementation GBPlayGameVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.offset(0);
//        make.height.mas_equalTo(200);
//    }];
//
//    UIView *view1 = [UIView new];
//    view1.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:view1];
//    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.offset(0);
//        make.height.mas_equalTo(200);
//    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self orientationToPortrait:UIInterfaceOrientationLandscapeLeft];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self orientationToPortrait:UIInterfaceOrientationPortrait];
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
//强制旋转屏幕
- (void)orientationToPortrait:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];//前两个参数已被target和selector占用
    [invocation invoke];
    
}

@end
