//
//  MBMemoryCacheManger.m
//  miaobang
//
//  Created by admin on 2017/5/26.
//  Copyright © 2017年 figo. All rights reserved.
//

#import "MBMemoryCacheManger.h"
//APP调试
#ifdef DEBUG
#define ENABLE_ALLDEBUG 1 //开启总调试开关
#if ENABLE_ALLDEBUG
#define ENABLE_VIEW_DEBUG 0 //开启线框模式开关
#define ENABLE_CURRENTVC_DEBUG 1 //开启当前视图控制器开关
#endif
#else
#define ENABLE_VIEW_DEBUG 0
#define ENABLE_CURRENTVC_DEBUG 0
#endif

@implementation MBMemoryCacheManger
- (void)debuggingAppModule{
    //线框调试模块
#if ENABLE_VIEW_DEBUG
    [[UIView class] aspect_hookSelector:@selector(setFrame:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
        UIView *view = [info instance];
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = [UIColor jk_randomColor].CGColor;
    } error:nil];
#endif
    
    
    //打印当前视图控制器模块
#if ENABLE_CURRENTVC_DEBUG
    [[UIViewController class] aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        UIViewController *currentVC = [info instance];
        NSLog(@"------Current ViewController is:%@------",NSStringFromClass([currentVC class]));
    }error:nil];
  
#endif
    
}


+ (instancetype)sharedInstance{
    static MBMemoryCacheManger *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MBMemoryCacheManger alloc]init];
    });
    return sharedInstance;
}
@end
