//
//  ViewController.m
//  GBaccaratGame
//
//  Created by blaceman on 2018/2/5.
//  Copyright © 2018年 new4545. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic , strong) NSArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"--测试--");
    NSLog(@"%@" , self.arr[2]);

}


- (NSArray *)arr {
    if (!_arr) {
        _arr = [NSArray array];
    }
    return _arr;
}

@end
