//
//  GBPlayGameVC.m
//  GBaccaratGame
//
//  Created by blaceman on 2018/2/24.
//  Copyright © 2018年 new4545. All rights reserved.
//

#import "GBPlayGameVC.h"
#import "GBPlayeGameView.h"

@implementation GBPlayGameVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
//    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    
    GBPlayeGameView *gameBackgroundView = [[GBPlayeGameView alloc]init];
    [self.view addSubview:gameBackgroundView];
    [gameBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self orientationToPortrait:UIInterfaceOrientationLandscapeRight];

}
-(void)viewWillDisappear:(BOOL)animated{
    [self orientationToPortrait:UIInterfaceOrientationPortrait];
//    self.tabBarController.tabBar.hidden = NO;
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
