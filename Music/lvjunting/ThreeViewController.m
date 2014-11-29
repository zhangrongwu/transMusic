//
//  ThreeViewController.m
//  find
//
//  Created by apple on 14-10-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ThreeViewController.h"
#import "TwoViewController.h"
#import "Mp3PlayerButton.h"
#import "NCMusicEngine.h"
#import "MainTableViewCell.h"
#import "NetWorkHandier.h"
#import "Music.h"
#import "UIImageView+WebCache.h"
#import "JingRoundView.h"
#import "YDSlider.h"
#import "Collection.h"
#import "MusicOnLine.h"
#import "LeftViewController.h"
#import "YRSideViewController.h"
#import "FXBlurView.h"
#import "pinglun.h"
#import "SDImageCache.h"
#import "CBAutoScrollLabel.h"

#import <Accelerate/Accelerate.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#define YDIMG(__name) [UIImage imageNamed:__name]
#define _changeColor ((arc4random() % 178)/255.0+0.1)


@interface ThreeViewController ()<NCMusicEngineDelegate,AVAudioPlayerDelegate>
{
    NCMusicEngine *_player;
    
    CGPoint beginPoint;
    

}
@property (nonatomic, retain)UIImageView *background;
@property (nonatomic, retain)FXBlurView *mohu;
@property (nonatomic, retain)UIButton *jiazai;
@property (nonatomic, retain)CBAutoScrollLabel *title1;

@property (nonatomic, retain)NSNumber *duration;

@property (nonatomic, retain)NSTimer *timer;
@end

@implementation ThreeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _player = [NCMusicEngine shareInstance];
        self.array = [NSMutableArray arrayWithCapacity:0];
        self.arrOfjiaodian = [NSArray array];
//        _player.playState = NCMusicEnginePlayStatePlaying;
        self.title1 = [[CBAutoScrollLabel alloc] initWithFrame:CGRectMake(20, 20, 280, 30)];
        self.duration = [[NSNumber alloc] init];

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    //判定为长按手势  需要的最短时间
    longPress.minimumPressDuration = 0.5;
    //判断为长按的三秒过程中, 允许用户手指移动的距离
//    longPress.allowableMovement = 320;
    
    
    [self.view addGestureRecognizer:longPress];
    [longPress release];


    
    
    
//
//    //让app能接受远程事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    //手势
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip];
    [swip release];


    self.buttoncount = 0;
//    NSLog(@"%@",self.mp3);
//    NSLog(@"%@",self.ID);
//    NSLog(@"-----------%@", self.arrOfjiaodian);
    UIButton *pushbutton = [UIButton buttonWithType:UIButtonTypeSystem];
//    pushbutton.backgroundColor = [UIColor redColor];
    pushbutton.frame = CGRectMake(-19, 518, 320+38, 60);
//    pushbutton.frame = CGRectMake(-10, self.background.frame.size.height-60, self.background.frame.size.width+20, 60);
    [pushbutton setTitle:@"查看评论" forState:UIControlStateNormal];
    [pushbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushbutton setBackgroundImage:[UIImage imageNamed:@"pinglun.png"] forState:UIControlStateNormal];
    [pushbutton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    

    
    self.background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
//    self.background.image = [UIImage imageNamed:@"pifu2.JPG"];
    self.background.image = [self blurryImage:[UIImage imageNamed:@"pifu2.JPG"] withBlurLevel:0.9];
    self.background.userInteractionEnabled = YES;
    [self.view addSubview:self.background];
    
//    self.mohu = [[FXBlurView alloc] initWithFrame:self.background.bounds];
//    self.mohu.userInteractionEnabled = YES;
//    self.mohu.blurEnabled = 10;
//    [self.view addSubview:self.mohu];
    
    
    
    

    self.title1.textAlignment = NSTextAlignmentCenter;
    [self.self.background addSubview:self.title1];
    
    UIImageView *biaoceng = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 30)];
    biaoceng.image = [UIImage imageNamed:@"title.png"];
    biaoceng.userInteractionEnabled = YES;
    [self.background addSubview:biaoceng];
    
    
    self.roundView = [[JingRoundView alloc]initWithFrame:CGRectMake(10, 100, 310, 300)];
    self.roundView.delegate = self;
    self.roundView.rotationDuration = 8.0;
    self.roundView.roundImage = [UIImage imageNamed:@"diao1.png"];
//    self.background.image = [UIImage imageNamed:@"p7.png"];

    [self.background addSubview:self.roundView];
    
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(157, 60, 80, 120)];
    imageView.image = [UIImage imageNamed:@"diao2.png"];
    //        imageView.
    [self.background addSubview:imageView];
    [imageView release];

    self.play = [[Mp3PlayerButton alloc] initWithFrame:CGRectMake(0, 100, 310, 310)];

    self.play.playImage = [UIImage imageNamed:@"sb.png"];
    self.play.pauseImage = [UIImage imageNamed:@"sb.png"];
    [self.play setBackgroundImage:[UIImage imageNamed:@"sb.png"] forState:UIControlStateNormal];
    [self.play addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
    [self.background addSubview:self.play];
    [_player stop];
    
    
   NSString *data = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/detail?device=iPhone&trackId=%@", self.ID];
    
    NSLog(@"=========%@",  [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/detail?device=iPhone&trackId=%@", self.ID]);
    [NetWorkHandier getConnectionWithURL:data comletion:^(id result) {

        self.duration = [result objectForKey:@"duration"];
         self.images = [result objectForKey:@"coverLarge"];
//        NSLog(@"---------%@", self.images);
        

        self.title1.text = [result objectForKey:@"title"];


        if (![self.images isKindOfClass:[NSNull class]]) {
//              self.roundView.roundImage = [UIImage imageNamed:@"diao1.png"];
            [self.roundView.nv sd_setImageWithURL:[NSURL URLWithString:self.images]];
            
            [self.background sd_setImageWithURL:[NSURL URLWithString:self.images] placeholderImage:[self blurryImage:[UIImage imageNamed:@"p7.png"] withBlurLevel:0.9] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                
                [self configPlayingInfo:image title:self.title1.text doubles:self.duration];
                self.background.image = [self blurryImage:image withBlurLevel:0.9];

            }];
            
            
        } else {
            self.roundView.roundImage = [UIImage imageNamed:@"diao1.png"];
            self.background.image = [self blurryImage:[UIImage imageNamed:@"p7.png"] withBlurLevel:0.9];
        }
        self.roundView.isPlay = YES;

   [self.imageView release];
        
        
        if (self.biaoji == 10) {
            
            self.play.mp3URL = [NSURL URLWithString:self.mp3];
        } else {
            self.play.mp3URL = [NSURL URLWithString:[result objectForKey:@"playUrl64"]];
        }

        [_player playUrl:self.play.mp3URL];
        
        [self.jiazai removeFromSuperview];
//
    }];
    
    
    
    
    [_scrollView release];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(musicslide) userInfo:nil repeats:YES];
    
    
        self.slider3 = [[YDSlider alloc]init];
        self.slider3.frame = CGRectMake(0, 410, 320, 1);
        self.slider3.backgroundColor = [UIColor redColor];
    self.slider3.thumbTintColor = [UIColor redColor];
        self.slider3.value = 1;
//        _slider3.middleValue = 0.7;
        [_slider3 setThumbImage:YDIMG(@"player-progress-point") forState:UIControlStateNormal];
        [_slider3 setThumbImage:YDIMG(@"player-progress-point-h") forState:UIControlStateHighlighted];
        [_slider3 setMinimumTrackImage:[YDIMG(@"player-progress-h") resizableImageWithCapInsets:UIEdgeInsetsMake(4, 3, 5, 4) resizingMode:UIImageResizingModeStretch]];
         [_slider3 setMiddleTrackImage:[YDIMG(@"player-progress-loading") resizableImageWithCapInsets:UIEdgeInsetsMake(4, 3, 5, 4) resizingMode:UIImageResizingModeStretch]];
        [_slider3 setMaximumTrackImage:[YDIMG(@"player-progress") resizableImageWithCapInsets:UIEdgeInsetsMake(4, 3, 5, 4) resizingMode:UIImageResizingModeStretch]];
    [self.slider3 addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    self.slider3.minimumTrackTintColor = [UIColor colorWithRed:_changeColor green:_changeColor blue:_changeColor alpha:0.8];
    self.slider3.middleTrackTintColor = [UIColor colorWithRed:_changeColor green:_changeColor blue:_changeColor alpha:0.8];
        [self.background addSubview:self.slider3];
        // Do any additional setup after loading the view.
    //播放>>>>>>>>>>>>>>>>>>>>>>>>
    

    
    
    
    
    //下一曲
    self.play2 = [[Mp3PlayerButton alloc]initWithFrame:CGRectMake(200, self.background.frame.size.height*0.76, 50, 50)];
//    self.play2.mp3URL = [NSURL URLWithString:self.mp3str];
    self.play2.playImage = [UIImage imageNamed:@"next.png"];
    self.play2.pauseImage = [UIImage imageNamed:@"next.png"];
    [self.play2 setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [self.play2 addTarget:self action:@selector(playAudionext:) forControlEvents:UIControlEventTouchUpInside];
    [self.background addSubview:self.play2];
    //
    //    //上一曲
    //
    self.play3 = [[Mp3PlayerButton alloc]initWithFrame:CGRectMake(70, self.background.frame.size.height*0.76, 50, 50)];
//    self.play3.mp3URL = [NSURL URLWithString:self.mp3];
    //    self.play3.hidden = NO;
    self.play3.playImage = [UIImage imageNamed:@"last.png"];
    self.play3.pauseImage = [UIImage imageNamed:@"last.png"];
    [self.play3 setBackgroundImage:[UIImage imageNamed:@"last.png"] forState:UIControlStateNormal];
    [self.play3 addTarget:self action:@selector(playAudiolade:) forControlEvents:UIControlEventTouchUpInside];
    [self.background addSubview:self.play3];

    
    
    
    
//    [self.scrollView addSubview:self.tableView];
//    [_tableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"reuse"];

    
    // 启动
    [self.timer fire];
    
    
    
    //评论请求
    
    NSString *pinglun = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/comment?device=iPhone&pageId=1&pageSize=30&trackId=%@",self.ID];
        [NetWorkHandier getConnectionWithURL:pinglun comletion:^(id result) {
        self.dic1 = result;
    }];
    // Do any additional setup after loading the view.
    [self.background addSubview:pushbutton];
    self.temp = self.mp3index;

    
    
    
    
    
    self.jiazai = [[UIButton alloc] initWithFrame:CGRectMake(120, 300, 80, 50)];
    [self.jiazai setTitle:@"加载中..." forState:UIControlStateNormal];
    [self.jiazai setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.jiazai.backgroundColor = [UIColor whiteColor];
    self.jiazai.alpha = 0.7;
    self.jiazai.layer.cornerRadius = 10;
    [self.view addSubview:self.jiazai];
    [self.jiazai release];

    
}
- (void)buttonClicked:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%f", scrollView.contentOffset.y);
    if (scrollView ==  self.scrollView) {
        
        self.play.frame = CGRectMake(128, 197-scrollView.contentOffset.y, 64, 64);
        self.play2.frame = CGRectMake(200, 440-scrollView.contentOffset.y, 64, 50);
        self.play3.frame = CGRectMake(70, 440-scrollView.contentOffset.y, 64, 50);
        
    }
}
//大圆转点击事件
-(void)playStatuUpdate:(BOOL)playState
{
//    NSLog(@"%@...", playState ? @"Playing": @"Pause");
    
    
}
///////////////////////下一曲////////////////////////

- (void)playAudio:(Mp3PlayerButton *)button
{
    
    if (_player == nil) {
        _player = [[NCMusicEngine alloc] init];
        //_player.button = button;
        _player.delegate = self;
    }
    
//    if ([_player.button isEqual:button]) {
        if (_player.playState == NCMusicEnginePlayStatePlaying) {
            self.roundView.isPlay = NO;
            [_player pause];
        }
        else if(_player.playState==NCMusicEnginePlayStatePaused){
            self.roundView.isPlay = YES;

            [_player resume];
        } else if (_player.playState == NCMusicEnginePlayStateEnded) {
            self.roundView.isPlay = NO;
            [_player pause];
        }else{
            [_player playUrl:button.mp3URL];
        }
//     else {
//        [_player stop];
//        self.roundView.isPlay = YES;
////        NSLog(@"开始");
//
//        _player.button = button;
//        [_player playUrl:button.mp3URL];
//    }
}

- (void)playAudionext:(Mp3PlayerButton *)button
{
        if (self.mp3index < self.arrOfjiaodian.count-1) {
            self.roundView.isPlay = YES;

            NSString *data = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/detail?device=iPhone&trackId=%@", [self.arrOfjiaodian objectAtIndex:++self.mp3index]];
            [NetWorkHandier getConnectionWithURL:data comletion:^(id result) {
                
                [_player stop];
                [_player playUrl:[NSURL URLWithString:[result objectForKey:@"playUrl64"]]];
                self.title1.text = [result objectForKey:@"title"];

                self.roundView.nv.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"coverLarge"]]]];
                self.nameLabel.text = [result objectForKey:@"title"];
//                self.background.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"coverLarge"]]]];
                [self.background sd_setImageWithURL:[NSURL URLWithString:[result objectForKey:@"coverLarge"]] placeholderImage:[UIImage imageNamed:@"p7.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    self.background.image = [self blurryImage:image withBlurLevel:0.9];
                }];
                
                
            }];
        }
    
    
    
}
- (void)playAudiolade:(Mp3PlayerButton *)button
{
        if (self.mp3index > 0) {
            self.roundView.isPlay = YES;
            
            NSString *data = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/detail?device=iPhone&trackId=%@", [self.arrOfjiaodian objectAtIndex:--self.mp3index]];
            [NetWorkHandier getConnectionWithURL:data comletion:^(id result) {
                
                [_player stop];
                [_player playUrl:[NSURL URLWithString:[result objectForKey:@"playUrl64"]]];
                self.title1.text = [result objectForKey:@"title"];

                self.roundView.nv.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"coverLarge"]]]];
                self.nameLabel.text = [result objectForKey:@"title"];
//                self.background.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"coverLarge"]]]];
                
                [self.background sd_setImageWithURL:[NSURL URLWithString:[result objectForKey:@"coverLarge"]] placeholderImage:[UIImage imageNamed:@"p7.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    self.background.image = [self blurryImage:image withBlurLevel:0.9];
                }];
                
                
            
            }];
        }
        
    
    
    
}

- (void)sliderAction:(UISlider *)slider
{
    _player.player.currentTime = slider.value * [self.duration floatValue] ;
//    _player.player.currentTime = slider.value * _player.player.duration;

    
}
//音乐播放
- (void)musicslide
{
    self.slider3.value = _player.player.currentTime/[self.duration floatValue];
    self.slider3.middleValue = _player.player.duration/[self.duration floatValue];
    static int a = 1;
    
    if (_player.playState == NCMusicEnginePlayStateEnded) {
        if (a == 1) {
            [self playAudionext:self.play];
            a = 2;
        } else {
            return;
        }
        
    }
    if (_player.playState != NCMusicEnginePlayStateEnded) {
        a = 1;
    }
}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *a = @"dad";
    MainTableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:a];
    if (myCell == nil) {
        myCell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:a];
        
    }
    
    Music *eve = [self.array objectAtIndex:indexPath.row];
    myCell.nameLabel.text = eve.peopleName;
    
    myCell.replyLabel.text = eve.content;

//    NSLog(@"%@",eve.peopleName);
//    NSLog(@"%@",myCell.nameLabel.text);
    id imageStr = eve.smallHeader;//照片
    if (imageStr == [NSNull null] ) {
        myCell.pictImageView.image = [UIImage imageNamed:@"1.jpeg"];
//        NSLog(@"%@",imageStr);
        
    }else
    {
        NSURL *url = [NSURL URLWithString:imageStr];
//        [myCell.pictImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei.png"]];
        [myCell.pictImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei.png"]];
        
    }
    
    return myCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}



- (void)swipeAction:(UISwipeGestureRecognizer *)swipe
{
    
//    NSLog(@"向左");
    //    a.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - 单例实现
//static ThreeViewController *sharedObj = nil;
//+ (ThreeViewController*) sharedInstance  //第二步：实例构造检查静态实例是否为nil
//
//{
//    
//    @synchronized (self)
//    
//    {
//        
//        if (sharedObj == nil)
//            
//        {
//            
//            [[self alloc] init];
//            
//        }
//        
//    }
//    
//    return sharedObj;
//    
//}
//
//
//
//+ (id) allocWithZone:(NSZone *)zone //第三步：重写allocWithZone方法
//
//{
//    
//    @synchronized (self) {
//        
//        if (sharedObj == nil) {
//            
//            sharedObj = [super allocWithZone:zone];
//            
//            return sharedObj;
//            
//        }
//        
//    }
//    
//    return nil;
//    
//}
//
//
//
//- (id) copyWithZone:(NSZone *)zone //第四步
//
//{
//    
//    return self;
//    
//}
//
//
//
//- (id) retain
//
//{
//    
//    return self;
//    
//}
//
//
//
//- (unsigned) retainCount
//
//{
//    
//    return UINT_MAX;
//    
//}
//
//
//
//- (oneway void) release
//
//{
//    
//    
//}
//
//
//
//- (id) autorelease
//
//{
//    
//    return self;
//    
//}
//
//
//- (id)init
//
//{
//    
//    @synchronized(self) {
//        
//        [super init];//往往放一些要初始化的变量.
//        
//        return self;
//        
//    }
//}
//#pragma mark -


- (void)viewWillAppear:(BOOL)animated
{
//    self.biaoji = 1;
//    if (self.danlibiaoji !=1) {
//        
//        [self viewDidLoad];
//    }
}

- (void)click:(UIButton *)button
{
    
//    NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^");
    
    
    NSMutableArray *ar = [NSMutableArray array];
    ar = [self.dic1 objectForKey:@"list"];
    pinglun *ping = [[pinglun alloc]init];
    [ping setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    ping.ID = self.ID;
    ping.beijing = self.background.image;
    if (ar.count == 0) {
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无评论" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [a show];
    } else {
        
        [self presentViewController:ping animated:YES completion:^{
            
        }];
    }
//    [self.navigationController pushViewController:ping animated:YES];
    [ping release];
    
}

//图片的模糊处理

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}


- (void)dealloc
{
    [super dealloc];
//    [_player release];
    [_background release];
    [_mp3 release];
    [_scrollView release];
    [_images release];
    [_imageView release];
    [_smallimageview release];
    [_nameLabel release];
    [_musicLabel release];
    [_ID release];
    [_tableView release];
    [_slider3 release];
    [_play release];
    [_array release];
    [_dic1 release];
    [_smallview release];
    [_roundView release];
    [_button release];
    [_play2 release];
    [_play3 release];
    [_string release];
    [_mp3str release];
    [_arrOfjiaodian release];
    [_view1 release];
    [_arrrr release];
    [_mohu release];

}

//响应 远程控制 事件
-(void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeRemoteControl) {
        
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPause:
                
                [_player pause];
                NSLog(@"zanting");
                self.roundView.isPlay = NO;

                break;
                
            case UIEventSubtypeRemoteControlPlay:
                NSLog(@"kaizhi");
                [_player resume];
                self.roundView.isPlay = YES;

                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"上一曲");
                [self playAudiolade:self.play];
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"下一曲");
                [self playAudionext:self.play];
                break;
                
            default:
                break;
        }
    }
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    //长按的方法在手势的各个状态都会触发, 所以要进行判断
    beginPoint = [longPress locationInView:self.view];
    if (longPress.state == UIGestureRecognizerStateChanged)
    {
        self.slider3.value = beginPoint.x/(self.view.frame.size.width);
        _player.player.currentTime = beginPoint.x/(self.view.frame.size.width)*_player.player.duration;
        [self.timer invalidate];
    }
    else if (longPress.state == UIGestureRecognizerStateEnded)
    {
        
//        self.slider3.value = beginPoint.x/(self.view.frame.size.width);
//        _player.player.currentTime = beginPoint.x/(self.view.frame.size.width)*_player.player.duration;

    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(musicslide) userInfo:nil repeats:YES];
    [self.timer fire];
    
}





- (void)configPlayingInfo:(UIImage *)image title:(NSString *)title doubles:(NSNumber *)doubles
{
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:title forKey:MPMediaItemPropertyTitle];
//        [dict setObject:@"曲目艺术家" forKey:MPMediaItemPropertyArtist];
        [dict setObject:[[[MPMediaItemArtwork alloc] initWithImage:image] autorelease] forKey:MPMediaItemPropertyArtwork];
        
//         [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(_player.player.currentTime)] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; //音乐当前已经播放时间
//         _player.player.currentTime/_player.player.duration
//        [dict setObject:[NSNumber numberWithDouble:_player.player.duration] forKey:MPMediaItemPropertyPlaybackDuration];//歌曲总时间设置
//        NSNumber *number = [NSNumber numberWithDouble:doubles];
        
        [dict setObject:doubles forKey:MPMediaItemPropertyPlaybackDuration];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:nil];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
}//
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
