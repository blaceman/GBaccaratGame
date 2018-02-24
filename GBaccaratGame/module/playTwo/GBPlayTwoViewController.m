//
//  GBPlayTwoViewController.m
//  GBaccaratGame
//
//  Created by blaceman on 2018/2/9.
//  Copyright © 2018年 new4545. All rights reserved.
//

#import "GBPlayTwoViewController.h"
#import "GBPlayGameVC.h"

@interface GBPlayTwoViewController ()

@end

@implementation GBPlayTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationItem.title = @"游戏二";
    [self backGroundImageView];
}
-(void)backGroundImageView{
//    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiangqing1"]];
//    [self.view addSubview:backImageView];
//    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.offset(-100);
//        make.left.right.offset(0);
//    }];
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titlelabel];
    titlelabel.font = AdaptedFontSize(16);
    titlelabel.text = @"游戏说明";
    titlelabel.textColor = [UIColor whiteColor];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedHeight(100));
        make.left.right.offset(0);
    }];
    
    UILabel *contentLabel = [UILabel qc_text:@"1. 选择庄家或者闲家,并下注\n\n2. 使用3-8副牌,每副52张纸牌,洗在一起并置于发牌盒中,由荷官从中分发,各家力争手中有两张牌总点数为9或者接近9/k/q/j和10都记为0其它牌按牌面点数计点,计算时,各家手中的牌相加,但又论于最后一位数组。最终数字大的获胜" fontSize:13 colorHex:0xfefefe];
    contentLabel.numberOfLines = 0;
    [self.view addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titlelabel.mas_bottom).offset(AdaptedHeight(40));
        make.left.offset(AdaptedWidth(48));
        make.right.offset(AdaptedWidth(-48));
    }];
    
    
    UIButton *startGame = [UIButton qc_title:@"开始游戏" fontSize:16 titleColorHex:0x666666];
    startGame.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:startGame];
    startGame.layer.cornerRadius = AdaptedWidth(16);
    startGame.layer.masksToBounds = YES;
    [startGame mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel).offset(AdaptedHeight(200));
        make.centerX.offset(0);
        make.width.mas_equalTo(AdaptedWidth(250));
    }];
    WeakSelf
    [[startGame rac_signalForControlEvents:(UIControlEventTouchUpInside)]subscribeNext:^(__kindof UIControl * _Nullable x) {
        StrongSelf
        GBPlayGameVC *playGameVC = [GBPlayGameVC new];
//        [self presentViewController:playGameVC animated:YES completion:nil];
        [self.navigationController pushViewController:playGameVC animated:YES];
    }];
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
