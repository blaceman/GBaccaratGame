//
//  GBPlayeGameView.m
//  GBaccaratGame
//
//  Created by blaceman on 2018/3/5.
//  Copyright © 2018年 new4545. All rights reserved.
//

#import "GBPlayeGameView.h"

@interface GBPlayeGameView()

@end
@implementation GBPlayeGameView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    UIImageView *imgBackView = [UIImageView qc_imageString:@"bgImg"];
    [self addSubview:imgBackView];
    imgBackView.contentMode = UIViewContentModeScaleAspectFit;
    [imgBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    UIButton *backButton = [UIButton qc_imageString:@"叉掉" imageStringSelected:@"叉掉"];
    [self addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset((16));
        make.top.offset((32));
        make.width.height.mas_equalTo(32);
    }];
    
    
    UIButton *startButton = [UIButton qc_imageString:@"６" imageStringSelected:@"６"];
    startButton.backgroundColor = UIColorFromRandom;
    [self addSubview:startButton];
    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset((-32));
        make.bottom.offset(-48);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *detailButton = [UIButton qc_imageString:@"５" imageStringSelected:@"５"];
    [self addSubview:detailButton];
    [detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset((32));
        make.bottom.offset(-48);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(44);
    }];

    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
@end
