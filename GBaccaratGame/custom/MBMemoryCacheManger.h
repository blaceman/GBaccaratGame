//
//  MBMemoryCacheManger.h
//  miaobang
//
//  Created by admin on 2017/5/26.
//  Copyright © 2017年 figo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 单例
 */
@interface MBMemoryCacheManger : NSObject
//单例
+ (instancetype)sharedInstance;

//线框
- (void)debuggingAppModule;


@end
