
#import "GameVC.h"
#import "Tool.h"
#import "CCTapped.h"
#import "DetailVC.h"
#import <AVFoundation/AVFoundation.h>
static NSInteger coinW = 20;
static NSInteger coinH = 10;
static NSInteger cardT = 1.5;
@interface GameVC (){
    NSDictionary *_pokerDic;
    NSArray *_pokersArr;
    BOOL _isPlaymusic;
    NSInteger coinX;
    NSInteger coinY;
    NSMutableArray *ansArr;
    NSMutableArray *allCoinArr;
    NSMutableArray *cardArr;
    NSInteger chooseCoin;
}
@property (weak, nonatomic) IBOutlet UILabel *totalLab;
@property (weak, nonatomic) IBOutlet UIImageView *playerimg;
@property (weak, nonatomic) IBOutlet UIImageView *bankerImg;
@property (weak, nonatomic) IBOutlet UIImageView *tieimg;
@property (weak, nonatomic) IBOutlet UIImageView *glod_100Img;
@property (weak, nonatomic) IBOutlet UIImageView *gold_500Img;
@property (weak, nonatomic) IBOutlet UIImageView *gold_1000Img;
@property (nonatomic)UIImageView *ansImg;


@property (weak, nonatomic) IBOutlet UIImageView *playerCardimg1;
@property (weak, nonatomic) IBOutlet UIImageView *playerCardimg2;
@property (weak, nonatomic) IBOutlet UIImageView *playerCardimg3;
@property (weak, nonatomic) IBOutlet UIImageView *bankerCardimg1;
@property (weak, nonatomic) IBOutlet UIImageView *bankerCardimg2;
@property (weak, nonatomic) IBOutlet UIImageView *bankerCardimg3;
@property (weak, nonatomic) IBOutlet UILabel *playerAnsLab;
@property (weak, nonatomic) IBOutlet UILabel *bankerAnsLab;
@property (weak, nonatomic) IBOutlet UILabel *playerTotalLab;
@property (weak, nonatomic) IBOutlet UILabel *bankerTotalLab;
@property (weak, nonatomic) IBOutlet UILabel *tieTotalLab;

@property (nonatomic)NSInteger isPoBoT;//!<闲家1 庄家2 和局3
@property (strong, nonatomic) AVAudioPlayer *player;

@property (nonatomic, assign) BOOL isPlaymusic;

@end

@implementation GameVC

- (void)creatMp3:(NSString *)str{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:str ofType:@"mp3"];
    NSURL *audioUrl = [NSURL fileURLWithPath:audioPath];
    NSError *playerError;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioUrl error:&playerError];
    if (_player == NULL)
    {
        NSLog(@"fail to play audio :(");
        return;
    }
    //循环次数
    [_player setNumberOfLoops:-1];
    
    //播放声音
    [_player setVolume:0.1];
    
    //预备播放
    [_player prepareToPlay];
    
    //播放
    [_player play];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isPlaymusic = YES;
    allCoinArr = [@[]mutableCopy];
    cardArr = [@[]mutableCopy];
    [self creatMp3:@"理查德.克莱德曼 - Coup De Coeur"];
    _pokerDic = @{@"1_1":@"1",@"2_1":@"2",@"3_1":@"3",@"4_1":@"4",@"5_1":@"5",@"6_1":@"6",@"7_1":@"7",@"8_1":@"8",@"9_1":@"9",@"10_1":@"0",@"11_1":@"0",@"12_1":@"0",@"13_1":@"0",
                  @"1_2":@"1",@"2_2":@"2",@"3_2":@"3",@"4_2":@"4",@"5_2":@"5",@"6_2":@"6",@"7_2":@"7",@"8_2":@"8",@"9_2":@"9",@"10_2":@"0",@"11_2":@"0",@"12_2":@"0",@"13_2":@"0",
                  @"1_3":@"1",@"2_3":@"2",@"3_3":@"3",@"4_3":@"4",@"5_3":@"5",@"6_3":@"6",@"7_3":@"7",@"8_3":@"8",@"9_3":@"9",@"10_3":@"0",@"11_3":@"0",@"12_3":@"0",@"13_3":@"0",
                  @"1_4":@"1",@"2_4":@"2",@"3_4":@"3",@"4_4":@"4",@"5_4":@"5",@"6_4":@"6",@"7_4":@"7",@"8_4":@"8",@"9_4":@"9",@"10_4":@"0",@"11_4":@"0",@"12_4":@"0",@"13_4":@"0"};
    _pokersArr = [_pokerDic allKeys];
    [_glod_100Img whenTapped:^{
        chooseCoin = 100;
        _glod_100Img.image = [UIImage imageNamed:@"101"];
        _gold_500Img.image = [UIImage imageNamed:@"数字500"];
        _gold_1000Img.image = [UIImage imageNamed:@"数字1000"];
    }];
    [_gold_500Img whenTapped:^{
        chooseCoin = 500;
        _glod_100Img.image = [UIImage imageNamed:@"数字100"];
        _gold_500Img.image = [UIImage imageNamed:@"501"];
        _gold_1000Img.image = [UIImage imageNamed:@"数字1000"];
    }];
    [_gold_1000Img whenTapped:^{
        chooseCoin = 1000;
        _glod_100Img.image = [UIImage imageNamed:@"数字100"];
        _gold_500Img.image = [UIImage imageNamed:@"数字500"];
        _gold_1000Img.image = [UIImage imageNamed:@"1001"];
    }];
    [_playerimg whenTapped:^{
        if (_isPlaymusic == YES) {
            [Tool play:@"ce_chip"];
        }else{
            
        }
        _bankerImg.userInteractionEnabled = NO;
        _tieimg.userInteractionEnabled = NO;
        _isPoBoT = 1;
        if ([_totalLab.text integerValue] - chooseCoin < 0) {
            
        }else{
            if (chooseCoin == 100) {
                UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:_glod_100Img.frame];
                NewGoldImg.image = [UIImage imageNamed:@"数字100"];
                [_playerimg addSubview:NewGoldImg];
                [allCoinArr addObject:NewGoldImg];
                [UIView animateWithDuration:0.5 animations:^{
                    NewGoldImg.frame = CGRectMake(coinX, coinY, coinW, coinH);
                }];
                _playerTotalLab.text = [NSString stringWithFormat:@"%ld",[_playerTotalLab.text integerValue] +chooseCoin];
                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] - chooseCoin];
            }else if (chooseCoin == 500){
                UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:_gold_500Img.frame];
                NewGoldImg.image = [UIImage imageNamed:@"数字500"];
                [_playerimg addSubview:NewGoldImg];
                [allCoinArr addObject:NewGoldImg];
                [UIView animateWithDuration:0.5 animations:^{
                    NewGoldImg.frame = CGRectMake(coinX, coinY, coinW, coinH);
                }];
                _playerTotalLab.text = [NSString stringWithFormat:@"%ld",[_playerTotalLab.text integerValue] +chooseCoin];
                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] - chooseCoin];
            }else if (chooseCoin == 1000){
                UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:_gold_1000Img.frame];
                NewGoldImg.image = [UIImage imageNamed:@"数字1000"];
                [_playerimg addSubview:NewGoldImg];
                [allCoinArr addObject:NewGoldImg];
                [UIView animateWithDuration:0.5 animations:^{
                    NewGoldImg.frame = CGRectMake(coinX, coinY, coinW, coinH);
                }];
                _playerTotalLab.text = [NSString stringWithFormat:@"%ld",[_playerTotalLab.text integerValue] +chooseCoin];
                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] - chooseCoin];
            }
        }
    }];
    
    [_tieimg whenTapped:^{
        if (_isPlaymusic == YES) {
            [Tool play:@"ce_chip"];
        }else{
            
        }
        _bankerImg.userInteractionEnabled = NO;
        _playerimg.userInteractionEnabled = NO;
        _isPoBoT = 3;
        if ([_totalLab.text integerValue] - chooseCoin <0) {
            
        }else{
            if (chooseCoin == 100) {
                UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:_glod_100Img.frame];
                NewGoldImg.image = [UIImage imageNamed:@"数字100"];
                [_tieimg addSubview:NewGoldImg];
                [allCoinArr addObject:NewGoldImg];
                
                [UIView animateWithDuration:0.5 animations:^{
                    NewGoldImg.frame = CGRectMake(coinX, coinY, coinW, coinH);
                }];
                _tieTotalLab.text = [NSString stringWithFormat:@"%ld",[_tieTotalLab.text integerValue] +chooseCoin];
                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] - chooseCoin];
            }else if (chooseCoin == 500){
                UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:_gold_500Img.frame];
                NewGoldImg.image = [UIImage imageNamed:@"数字500"];
                [_tieimg addSubview:NewGoldImg];
                [allCoinArr addObject:NewGoldImg];
                [UIView animateWithDuration:0.5 animations:^{
                    NewGoldImg.frame = CGRectMake(coinX, coinY, coinW, coinH);
                }];
                _tieTotalLab.text = [NSString stringWithFormat:@"%ld",[_tieTotalLab.text integerValue] +chooseCoin];
                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] - chooseCoin];
            }else if (chooseCoin == 1000){
                UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:_gold_1000Img.frame];
                NewGoldImg.image = [UIImage imageNamed:@"数字1000"];
                [_tieimg addSubview:NewGoldImg];
                [allCoinArr addObject:NewGoldImg];
                [UIView animateWithDuration:0.5 animations:^{
                    NewGoldImg.frame = CGRectMake(coinX, coinY, coinW, coinH);
                }];
                _tieTotalLab.text = [NSString stringWithFormat:@"%ld",[_tieTotalLab.text integerValue] +chooseCoin];
                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] - chooseCoin];
            }
        }
    }];
    
    [_bankerImg whenTapped:^{
        if (_isPlaymusic == YES) {
            [Tool play:@"ce_chip"];
        }else{
            
        }
        _isPoBoT = 2;
        _playerimg.userInteractionEnabled = NO;
        _tieimg.userInteractionEnabled = NO;
        if ([_totalLab.text integerValue] - chooseCoin < 0) {
            
        }else{
            if (chooseCoin == 100) {
                UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:_glod_100Img.frame];
                NewGoldImg.image = [UIImage imageNamed:@"数字100"];
                [_bankerImg addSubview:NewGoldImg];
                [allCoinArr addObject:NewGoldImg];
                [UIView animateWithDuration:0.5 animations:^{
                    NewGoldImg.frame = CGRectMake(coinX, coinY, coinW, coinH);
                }];
                _bankerTotalLab.text = [NSString stringWithFormat:@"%ld",[_bankerTotalLab.text integerValue] +chooseCoin];
                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] - chooseCoin];
            }else if (chooseCoin == 500){
                UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:_gold_500Img.frame];
                NewGoldImg.image = [UIImage imageNamed:@"数字500"];
                [_bankerImg addSubview:NewGoldImg];
                [allCoinArr addObject:NewGoldImg];
                [UIView animateWithDuration:0.5 animations:^{
                    NewGoldImg.frame = CGRectMake(coinX, coinY, coinW, coinH);
                }];
                _bankerTotalLab.text = [NSString stringWithFormat:@"%ld",[_bankerTotalLab.text integerValue] +chooseCoin];
                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] - chooseCoin];
            }else if (chooseCoin == 1000){
                UIImageView *NewGoldImg = [[UIImageView alloc] initWithFrame:_gold_1000Img.frame];
                NewGoldImg.image = [UIImage imageNamed:@"数字1000"];
                [_bankerImg addSubview:NewGoldImg];
                [allCoinArr addObject:NewGoldImg];
                [UIView animateWithDuration:0.5 animations:^{
                    NewGoldImg.frame = CGRectMake(coinX, coinY, coinW, coinH);
                }];
                _bankerTotalLab.text = [NSString stringWithFormat:@"%ld",[_bankerTotalLab.text integerValue] +chooseCoin];
                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] - chooseCoin];
            }
        }
    }];
}
//当有一个或多个手指触摸事件在当前视图或window窗体中响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    coinX = point.x;
    coinY = point.y;
}

#pragma  -- mark 增加金币
- (IBAction)addCornBtn:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"尊敬的用户,感谢使用百家乐,系统给您赠送1000金币" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] +1000];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma  -- mark 关闭音乐
- (IBAction)closeMusicBtn:(UIButton *)sender {
    static NSInteger aaa;
    if (aaa%2 == 0) {
        [sender setImage:[UIImage imageNamed:@"20"] forState:UIControlStateNormal];
         [_player stop];
        _isPlaymusic = NO;
    }else{
        [sender setImage:[UIImage imageNamed:@"１０"] forState:UIControlStateNormal];
         [_player play];
        _isPlaymusic = YES;
    }
    aaa ++;
}
#pragma -- mark 开始游戏
- (void) timeEnough
{
    UIButton *btn=(UIButton*)[self.view viewWithTag:33];
    btn.selected=NO;
}
- (IBAction)beginBtn:(UIButton *)sender {
    if(sender.selected) return;
    sender.selected=YES;
    [self performSelector:@selector(timeEnough) withObject:nil afterDelay:8.0]; //3秒后又可以处理点击事件了

    if ([_playerTotalLab.text integerValue] == 0 && [_bankerTotalLab.text integerValue] == 0 && [_tieTotalLab.text integerValue] == 0) {
        if (_isPlaymusic == YES) {
            [Tool play:@"c_place_cn"];
        }else{
            
        }
    }else{
        if (_isPlaymusic == YES) {
            [Tool play:@"squeeze_open"];
        }else{
            
        }
        ansArr = [@[]mutableCopy];
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
        img1.image = [UIImage imageNamed:@"car_background"];
        [self.view addSubview:img1];
        [UIView animateWithDuration:cardT animations:^{
            if (_isPlaymusic == YES) {
                [Tool play:@"Players_cn"];
            }else{
                
            }
            img1.frame = _playerCardimg1.frame;
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cardT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
            img2.image = [UIImage imageNamed:@"car_background"];
            [self.view addSubview:img2];
            [UIView animateWithDuration:cardT animations:^{
                if (_isPlaymusic == YES) {
                    [Tool play:@"Bankers_cn"];
                }else{
                    
                }
                img2.frame = _bankerCardimg1.frame;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cardT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
                    img3.image = [UIImage imageNamed:@"car_background"];
                    [self.view addSubview:img3];
                    [UIView animateWithDuration:cardT animations:^{
                        if (_isPlaymusic == YES) {
                            [Tool play:@"Players_cn"];
                        }else{
                            
                        }
                        img3.frame = _playerCardimg2.frame;
                    }];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cardT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        UIImageView *img4 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
                        img4.image = [UIImage imageNamed:@"car_background"];
                        [self.view addSubview:img4];
                        [UIView animateWithDuration:cardT animations:^{
                            if (_isPlaymusic == YES) {
                                [Tool play:@"Bankers_cn"];
                            }else{
                                
                            }
                            img4.frame = _bankerCardimg2.frame;
                        }];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cardT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self FilpAnimations:img1];
                            [self FilpAnimations:img2];
                            [self FilpAnimations:img3];
                            [self FilpAnimations:img4];
                            _tieimg.userInteractionEnabled = YES;
                            _playerimg.userInteractionEnabled = YES;
                            _bankerImg.userInteractionEnabled = YES;
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cardT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                if ([ansArr[0] integerValue] + [ansArr[2] integerValue] < [ansArr[1] integerValue] + [ansArr[3] integerValue]) {
                                    //追加闲方
                                    if (_isPlaymusic == YES) {
                                        [Tool play:@"ba_1c2p_cn"];
                                    }else{
                                        
                                    }
                                    NSArray *arr = [self randomArray];
                                    NSInteger iii = arc4random()%3;
                                    UIImageView *img5 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
                                    img5.image = [UIImage imageNamed:arr[iii]];
                                    [self.view addSubview:img5];
                                    [UIView animateWithDuration:cardT animations:^{
                                        img5.frame = _playerCardimg3.frame;
                                    }];
                                    NSInteger playAns = [ansArr[0] integerValue] + [ansArr[2] integerValue] + [_pokerDic[arr[iii]] integerValue];
                                    NSInteger bankAns = [ansArr[1] integerValue] + [ansArr[3] integerValue];
                                    if (playAns>=10) {
                                        playAns = playAns - 10;
                                    }
                                    if (bankAns>=10) {
                                        bankAns = bankAns - 10;
                                    }
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        _playerAnsLab.text = [NSString stringWithFormat:@"%ld",(long)playAns];
                                        _bankerAnsLab.text = [NSString stringWithFormat:@"%ld",(long)bankAns];
                                        if (_isPlaymusic == YES) {
                                            [Tool play:@"Players_cn"];
                                        }else{
                                            
                                        }
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            NSString *playerAnsSound = [NSString stringWithFormat:@"no_%@_cn",[NSString stringWithFormat:@"%ld",(long)playAns]];
                                            NSString *bankerAnsSound = [NSString stringWithFormat:@"no_%@_cn",[NSString stringWithFormat:@"%ld",(long)bankAns]];
                                            if (_isPlaymusic == YES) {
                                                [Tool play:playerAnsSound];
                                            }else{
                                                
                                            }
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                if (_isPlaymusic == YES) {
                                                    [Tool play:@"Bankers_cn"];
                                                }else{
                                                    
                                                }
                                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                    if (_isPlaymusic == YES) {
                                                        [Tool play:bankerAnsSound];
                                                    }else{
                                                        
                                                    }
                                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                        [self.view addSubview:self.ansImg];
                                                        if (playAns > bankAns) {
                                                            NSLog(@"闲家赢");
                                                            if (_isPlaymusic == YES) {
                                                                [Tool play:@"c_playerwin_cn"];
                                                            }else{
                                                                
                                                            }
                                                            _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_playerTotalLab.text integerValue] *2];
                                                            if (_isPoBoT == 1) {
                                                                _ansImg.image = [UIImage imageNamed:@"win"];
                                                            }else{
                                                                _ansImg.image = [UIImage imageNamed:@"lose"];
                                                            }
                                                        }else if (playAns == bankAns){
                                                            NSLog(@"和局");
                                                            if (_isPlaymusic == YES) {
                                                                [Tool play:@"ba_tiwin_cn"];
                                                            }else{
                                                                
                                                            }
                                                            _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_tieTotalLab.text integerValue] *8];
                                                            if (_isPoBoT == 3) {
                                                                _ansImg.image = [UIImage imageNamed:@"win"];
                                                            }else{
                                                                _ansImg.image = [UIImage imageNamed:@"lose"];
                                                            }
                                                        }else{
                                                            NSLog(@"庄家赢");
                                                            if (_isPlaymusic == YES) {
                                                                [Tool play:@"ba_bwin_cn"];
                                                            }else{
                                                                
                                                            }
                                                            _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_bankerTotalLab.text integerValue] *2];
                                                            if (_isPoBoT == 2) {
                                                                _ansImg.image = [UIImage imageNamed:@"win"];
                                                            }else{
                                                                _ansImg.image = [UIImage imageNamed:@"lose"];
                                                            }
                                                        }
                                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
#pragma mark -- 游戏结束，移除桌面元素
                                                           /* if (_isPoBoT == 1) {
                                                                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_playerTotalLab.text integerValue] *2];
                                                                _playerTotalLab.text = @"";
                                                            }else if (_isPoBoT == 2){
                                                                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_bankerTotalLab.text integerValue] *2];
                                                                _bankerTotalLab.text = @"";
                                                            }else if(_isPoBoT == 3){
                                                                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_tieTotalLab.text integerValue] *8];
                                                                _tieTotalLab.text = @"";
                                                            }*/
                                                            _playerTotalLab.text = @"";
                                                            _bankerTotalLab.text = @"";
                                                            _tieTotalLab.text = @"";
                                                            for (UIImageView *img in allCoinArr) {
                                                                [img removeFromSuperview];
                                                            }
                                                            img1.image = [UIImage imageNamed:@""];
                                                            img2.image = [UIImage imageNamed:@""];
                                                            img3.image = [UIImage imageNamed:@""];
                                                            img4.image = [UIImage imageNamed:@""];
                                                            img5.image = [UIImage imageNamed:@""];
                                                            _playerTotalLab.text = @"";
                                                            _tieTotalLab.text = @"";
                                                            _bankerTotalLab.text = @"";
                                                            _playerAnsLab.text = @"";
                                                            _bankerAnsLab.text = @"";
                                                            _glod_100Img.image = [UIImage imageNamed:@"数字100"];
                                                            _gold_500Img.image = [UIImage imageNamed:@"数字500"];
                                                            _gold_1000Img.image = [UIImage imageNamed:@"数字1000"];
                                                            chooseCoin = 0;
                                                            [self.ansImg removeFromSuperview];
                                                        });
                                                    });
                                                });
                                            });
                                        });
                                    });
                                    
                                }else if ([ansArr[0] integerValue] + [ansArr[2] integerValue] > [ansArr[1] integerValue] + [ansArr[3] integerValue]){
                                    //追加庄方
                                    if (_isPlaymusic == YES) {
                                        [Tool play:@"ba_1c2b_cn"];
                                    }else{
                                        
                                    }
                                    NSArray *arr = [self randomArray];
                                    NSInteger iii = arc4random()%3;
                                    UIImageView *img6 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 10, 0, 0)];
                                    img6.image = [UIImage imageNamed:arr[iii]];
                                    [self.view addSubview:img6];
                                    [UIView animateWithDuration:cardT animations:^{
                                        img6.frame = _bankerCardimg3.frame;
                                    }];
                                    NSInteger playAns = [ansArr[0] integerValue] + [ansArr[2] integerValue];
                                    NSInteger bankAns = [ansArr[1] integerValue] + [ansArr[3] integerValue] + [_pokerDic[arr[iii]] integerValue];
                                    if (playAns>=10) {
                                        playAns = playAns - 10;
                                    }
                                    if (bankAns>=10) {
                                        bankAns = bankAns - 10;
                                    }
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        _playerAnsLab.text = [NSString stringWithFormat:@"%ld",(long)playAns];
                                        _bankerAnsLab.text = [NSString stringWithFormat:@"%ld",(long)bankAns];
                                        if (_isPlaymusic == YES) {
                                            [Tool play:@"Players_cn"];
                                        }else{
                                            
                                        }
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            NSString *playerAnsSound = [NSString stringWithFormat:@"no_%@_cn",[NSString stringWithFormat:@"%ld",(long)playAns]];
                                            NSString *bankerAnsSound = [NSString stringWithFormat:@"no_%@_cn",[NSString stringWithFormat:@"%ld",(long)bankAns]];
                                            if (_isPlaymusic == YES) {
                                                [Tool play:playerAnsSound];
                                            }else{
                                                
                                            }
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                if (_isPlaymusic == YES) {
                                                    [Tool play:@"Bankers_cn"];
                                                }else{
                                                    
                                                }
                                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                    if (_isPlaymusic == YES) {
                                                        [Tool play:bankerAnsSound];
                                                    }else{
                                                        
                                                    }
                                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                        [self.view addSubview:self.ansImg];
                                                        if (playAns > bankAns) {
                                                            NSLog(@"闲家赢");
                                                            if (_isPlaymusic == YES) {
                                                                [Tool play:@"c_playerwin_cn"];
                                                            }else{
                                                                
                                                            }
                                                            _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_playerTotalLab.text integerValue] *2];
                                                            if (_isPoBoT == 1) {
                                                                _ansImg.image = [UIImage imageNamed:@"win"];
                                                            }else{
                                                                _ansImg.image = [UIImage imageNamed:@"lose"];
                                                            }
                                                        }else if (playAns == bankAns){
                                                            NSLog(@"和局");
                                                            if (_isPlaymusic == YES) {
                                                                [Tool play:@"ba_tiwin_cn"];
                                                            }else{
                                                                
                                                            }
                                                            _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_tieTotalLab.text integerValue] *8];
                                                            if (_isPoBoT == 3) {
                                                                _ansImg.image = [UIImage imageNamed:@"win"];
                                                            }else{
                                                                _ansImg.image = [UIImage imageNamed:@"lose"];
                                                            }
                                                        }else{
                                                            NSLog(@"庄家赢");
                                                            if (_isPlaymusic == YES) {
                                                                [Tool play:@"ba_bwin_cn"];
                                                            }else{
                                                                
                                                            }
                                                            _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_bankerTotalLab.text integerValue] *2];
                                                            if (_isPoBoT == 2) {
                                                                _ansImg.image = [UIImage imageNamed:@"win"];
                                                            }else{
                                                                _ansImg.image = [UIImage imageNamed:@"lose"];
                                                            }
                                                        }
                                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
#pragma mark -- 游戏结束，移除桌面元素
                                                         /*   if (_isPoBoT == 1) {
                                                                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_playerTotalLab.text integerValue] *2];
                                                                _playerTotalLab.text = @"";
                                                            }else if (_isPoBoT == 2){
                                                                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_bankerTotalLab.text integerValue] *2];
                                                                _bankerTotalLab.text = @"";
                                                            }else if(_isPoBoT == 3){
                                                                _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_tieTotalLab.text integerValue] *8];
                                                                _tieTotalLab.text = @"";
                                                            }*/
                                                            _playerTotalLab.text = @"";
                                                            _bankerTotalLab.text = @"";
                                                            _tieTotalLab.text = @"";
                                                            for (UIImageView *img in allCoinArr) {
                                                                [img removeFromSuperview];
                                                            }
                                                            img1.image = [UIImage imageNamed:@""];
                                                            img2.image = [UIImage imageNamed:@""];
                                                            img3.image = [UIImage imageNamed:@""];
                                                            img4.image = [UIImage imageNamed:@""];
                                                            img6.image = [UIImage imageNamed:@""];
                                                            _playerTotalLab.text = @"";
                                                            _tieTotalLab.text = @"";
                                                            _bankerTotalLab.text = @"";
                                                            _playerAnsLab.text = @"";
                                                            _bankerAnsLab.text = @"";
                                                            _glod_100Img.image = [UIImage imageNamed:@"数字100"];
                                                            _gold_500Img.image = [UIImage imageNamed:@"数字500"];
                                                            _gold_1000Img.image = [UIImage imageNamed:@"数字1000"];
                                                            chooseCoin = 0;
                                                            [self.ansImg removeFromSuperview];
                                                        });
                                                    });
                                                });
                                            });
                                        });
                                    });
                                    
                                }else{
                                    //和局
                                    if (_isPlaymusic == YES) {
                                        [Tool play:@"ba_tiwin_cn"];
                                    }else{
                                        
                                    }
                                    [self.view addSubview:self.ansImg];
                                    if (_isPoBoT == 3) {
                                        _ansImg.image = [UIImage imageNamed:@"win"];
                                    }else{
                                        _ansImg.image = [UIImage imageNamed:@"lose"];
                                    }
                                    _totalLab.text = [NSString stringWithFormat:@"%ld",[_totalLab.text integerValue] + [_tieTotalLab.text integerValue] *8];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        _playerTotalLab.text = @"";
                                        _bankerTotalLab.text = @"";
                                        _tieTotalLab.text = @"";
                                        for (UIImageView *img in allCoinArr) {
                                            [img removeFromSuperview];
                                        }
                                        img1.image = [UIImage imageNamed:@""];
                                        img2.image = [UIImage imageNamed:@""];
                                        img3.image = [UIImage imageNamed:@""];
                                        img4.image = [UIImage imageNamed:@""];
                                        _playerTotalLab.text = @"";
                                        _tieTotalLab.text = @"";
                                        _bankerTotalLab.text = @"";
                                        _playerAnsLab.text = @"";
                                        _bankerAnsLab.text = @"";
                                        _glod_100Img.image = [UIImage imageNamed:@"数字100"];
                                        _gold_500Img.image = [UIImage imageNamed:@"数字500"];
                                        _gold_1000Img.image = [UIImage imageNamed:@"数字1000"];
                                        chooseCoin = 0;
                                        [self.ansImg removeFromSuperview];
                                    });
                                }
                            });
                        });
                    });
                });
            }];
        });
    }
}
- (void)FilpAnimations:(UIImageView *)img{
    NSArray *arr = [self randomArray];
    NSInteger iii = arc4random()%3;
    [ansArr addObject:_pokerDic[arr[iii]]];
    [UIView beginAnimations:@"View Filp" context:nil];
    [UIView setAnimationDelay:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:img cache:NO];
    [UIView commitAnimations];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        img.image = [UIImage imageNamed:arr[iii]];
    });
}
- (IBAction)cancleBtn:(id)sender {
    _glod_100Img.image = [UIImage imageNamed:@"数字100"];
    _gold_500Img.image = [UIImage imageNamed:@"数字500"];
    _gold_1000Img.image = [UIImage imageNamed:@"数字1000"];
    chooseCoin = 0;
    _tieimg.userInteractionEnabled = YES;
    _playerimg.userInteractionEnabled = YES;
    _bankerImg.userInteractionEnabled = YES;
    _totalLab.text = [NSString stringWithFormat:@"%ld",[_playerTotalLab.text integerValue] + [_tieTotalLab.text integerValue] + [_bankerTotalLab.text integerValue] + [_totalLab.text integerValue]];
    _playerTotalLab.text = @"";
    _tieTotalLab.text = @"";
    _bankerTotalLab.text = @"";
    for (UIImageView *img in allCoinArr) {
        [img removeFromSuperview];
    }
}
- (void)removeCardImg{
    _playerCardimg1.image = [UIImage imageNamed:@""];
    _playerCardimg2.image = [UIImage imageNamed:@""];
    _playerCardimg3.image = [UIImage imageNamed:@""];
    _bankerCardimg1.image = [UIImage imageNamed:@""];
    _bankerCardimg2.image = [UIImage imageNamed:@""];
    _bankerCardimg3.image = [UIImage imageNamed:@""];
    _playerAnsLab.text = @"";
    _bankerAnsLab.text = @"";
}
- (UIImageView *)ansImg
{
    if(!_ansImg)
    {
        _ansImg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _ansImg ;
}
- (IBAction)detailBtn:(id)sender {
    [self presentViewController:[DetailVC new] animated:YES completion:nil];
}
#pragma mark -- 随机数
-(NSArray *)randomArray
{
    //随机数从这里边产生
    NSMutableArray *startArray=[[NSMutableArray alloc] initWithArray:_pokersArr];
    //随机数产生结果
    NSMutableArray *resultArray=[[NSMutableArray alloc] initWithCapacity:0];
    //随机数个数
    NSInteger m=4;
    for (int i=0; i<m; i++) {
        int t=arc4random()%startArray.count;
        resultArray[i]=startArray[t];
        startArray[t]=[startArray lastObject]; //为更好的乱序，故交换下位置
        [startArray removeLastObject];
    }
    return resultArray;
}
@end
