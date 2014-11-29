//
//  LeftViewController.m
//  Music
//
//  Created by lothario on 14-10-1.
//  Copyright (c) 2014年 lanou3g.com. All rights reserved.
//

#import "LeftViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>
#import "DXAlertView.h"
#import "PictureViewController.h"

#import "OurViewController.h"
#import "FXBlurView.h"

#import "Collection.h"
#import <Accelerate/Accelerate.h>

#import "JieshaoController.h"
@interface LeftViewController ()
@property (nonatomic,retain)UIImageView *background;
@property (nonatomic, retain)UIImage *image1;
@property (nonatomic, retain)UIButton *exitButton;
@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.background = [[UIImageView alloc] init];
        self.background.userInteractionEnabled = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    self.background.frame = self.view.bounds;
//    self.background.image = [UIImage imageNamed:@"pifu11.JPG"];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"leftBackground"] == nil) {
        //如果第一次
        [[NSUserDefaults standardUserDefaults] setObject:@"pifu11.JPG" forKey:@"leftBackground"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.background.image = [self blurryImage:[UIImage imageNamed:@"pifu11.JPG"] withBlurLevel:0.5];
        
    } else {
        //不是第一次
        self.background.image = [self blurryImage:[UIImage imageNamed:[[NSUserDefaults standardUserDefaults] objectForKey:@"leftBackground"]] withBlurLevel:0.5];
        
    }
    
    
    [self.view addSubview:self.background];

//    FXBlurView *mohu = [[FXBlurView alloc] initWithFrame:self.view.bounds];
//    mohu.userInteractionEnabled = YES;
//    mohu.blurEnabled = 0;
//    [self.view addSubview:mohu];
    
    //////////点击头像
    
    self.one = [UIButton buttonWithType:UIButtonTypeSystem];
    self.imageone = [[UIImageView alloc]initWithFrame:CGRectMake(30 , 60, 80, 80)];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"touxiang"] == nil) {
        //如果第一次
        [[NSUserDefaults standardUserDefaults] setObject:@"one.png" forKey:@"touxiang"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.image1 = [UIImage imageNamed:@"one.png"];
    } else {
        self.image1 = [UIImage imageNamed:[[NSUserDefaults standardUserDefaults] objectForKey:@"touxiang"]];
        //不是第一次
    }
//    image1 = [image1 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    self.imageone.image = self.image1;
    self.imageone.layer.cornerRadius = 40;
    self.imageone.layer.masksToBounds = YES;

    [self.view addSubview:self.imageone];
    self.one.frame = CGRectMake(125 , 115, 50, 30);
//    self.one.backgroundColor = [UIColor redColor];
    [self.one setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.one setTitle:@"登陆" forState:UIControlStateNormal];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"zhuangtai"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"zhuangtai"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"zhuangtai"] isEqualToString:@"1"]) {
            self.one.hidden = NO;
        } else{
            self.one.hidden = YES;
        }
    }
//    self.one.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
//    [self.one setFont:[UIFont systemFontOfSize:15]];
    
    self.one.titleLabel.font = [UIFont systemFontOfSize:15];
    self.one.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.one addTarget:self action:@selector(loginBtnClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.one];
    //黑线
    self.viewone = [[UIView alloc]initWithFrame:CGRectMake(45, 150, 200, 0.3)];
    self.viewone.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.viewone];
    [_viewone release];
    
    /////////////////我的收藏
    self.two = [UIButton buttonWithType:UIButtonTypeSystem];
    self.imagetwo = [[UIImageView alloc]initWithFrame:CGRectMake(30 , 25, 30, 30)];
    UIImage *image2 = [UIImage imageNamed:@"two.png"];
    image2 = [image2 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    self.imagetwo.image = image2;
    [self.two addSubview:self.imagetwo];
    self.two.frame = CGRectMake(20 , 150, 260, 90);
    [self.two setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.two setTitle:@"   功能介绍" forState:UIControlStateNormal];
    self.two.contentEdgeInsets = UIEdgeInsetsMake(0,70, 0, 0);
//    [self.two setFont:[UIFont systemFontOfSize:15]];
    self.two.titleLabel.font = [UIFont systemFontOfSize:15];
    self.two.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.two addTarget:self action:@selector(ClickTwo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.two];
    //黑箱
    self.viewtwo = [[UIView alloc]initWithFrame:CGRectMake(45, 209, 200, 0.3)];
    self.viewtwo.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.viewtwo];
    [_viewtwo release];
    
    
    //////////////清除收藏
    self.three = [UIButton buttonWithType:UIButtonTypeSystem];
    self.imagethree = [[UIImageView alloc]initWithFrame:CGRectMake(30 , 25, 30, 25)];
    UIImage *image3 = [UIImage imageNamed:@"four.png"];
    image3 = [image3 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    self.imagethree.image = image3;
    [self.three addSubview:self.imagethree];
    self.three.frame = CGRectMake(20 , 220, 260, 80);
    [self.three setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.three setTitle:@"   清除内存" forState:UIControlStateNormal];
    self.three.contentEdgeInsets = UIEdgeInsetsMake(0,70, 0, 0);
//    [self.three setFont:[UIFont systemFontOfSize:15.0]];
    self.three.titleLabel.font = [UIFont systemFontOfSize:15];
    self.three.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.three addTarget:self action:@selector(ClickThree:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.three];
    //黑线
    self.viewthree = [[UIView alloc]initWithFrame:CGRectMake(45, 275, 200, 0.3)];
    self.viewthree.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.viewthree];
    [_viewthree release];
    
    
    
    
    //////////////关于我们
    self.four = [UIButton buttonWithType:UIButtonTypeSystem];
    //    self.four.backgroundColor = [UIColor greenColor];
    self.four.contentEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    self.imagefour = [[UIImageView alloc]initWithFrame:CGRectMake(30, 22, 30, 30)];
    UIImage *image4 = [UIImage imageNamed:@"three.png"];
    image4 = [image4 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    self.imagefour.image = image4;
    [self.four addSubview:self.imagefour];
    self.four.frame = CGRectMake(20 , 280, 260, 80);
    [self.four setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.four setTitle:@"   关于我们" forState:UIControlStateNormal];
//    [self.four setFont:[UIFont systemFontOfSize:15.0]];
    self.four.titleLabel.font = [UIFont systemFontOfSize:15];
    self.four.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.four addTarget:self action:@selector(ClickFour:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.four];
    //黑线
    self.viewfour = [[UIView alloc]initWithFrame:CGRectMake(45, 336, 200, 0.3)];
    self.viewfour.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.viewfour];
    [self.viewfour release];
    
    
    self.zhuti = [[UIButton alloc]initWithFrame:CGRectMake(0, 370, 220, 40)];
    self.zhuti.backgroundColor = [UIColor whiteColor];
    self.zhuti.alpha = 0.7;
//    self.label.textAlignment = UITextAlignmentCenter;
//    self.zhuti.font = [UIFont systemFontOfSize:15];
    [self.zhuti setTitle:@"百变主题" forState:UIControlStateNormal];
    self.zhuti.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.zhuti setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.zhuti addTarget:self action:@selector(changezhuti:) forControlEvents:UIControlEventTouchUpInside];
    self.zhuti.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.zhuti];
    
    
    self.imagecolor = [[UIImageView alloc]initWithFrame:CGRectMake(15, 375, 40, 35)];
    self.imagecolor.image = [UIImage imageNamed:@"diaodai.png"];
    [self.view addSubview:self.imagecolor];
    
    
    self.yellowView = [[UIView alloc]initWithFrame:CGRectMake(14, 429, 32, 32)];
    self.yellowView.backgroundColor = [UIColor whiteColor];
    self.yellowView.layer.cornerRadius = 16;
    [self.view addSubview:self.yellowView];
    
    self.yellow = [UIButton buttonWithType:UIButtonTypeSystem];
    self.yellow.frame = CGRectMake(1, 1, 30, 30);
    self.yellow.layer.cornerRadius = 15;
    self.yellow.backgroundColor = [UIColor colorWithRed:0.63 green:0.17 blue:0.43 alpha:1];
    [self.yellow addTarget:self action:@selector(yellow:) forControlEvents:UIControlEventTouchUpInside];
    [self.yellowView addSubview:self.yellow];
    
    self.blueView = [[UIView alloc]initWithFrame:CGRectMake(49, 429, 32, 32)];
    self.blueView.backgroundColor = [UIColor whiteColor];
    self.blueView.layer.cornerRadius = 16;
    [self.view addSubview:self.blueView];
    
    self.blue = [UIButton buttonWithType:UIButtonTypeSystem];
    self.blue.frame = CGRectMake(1, 1, 30, 30);
    self.blue.layer.cornerRadius = 15;
    self.blue.backgroundColor = [UIColor colorWithRed:0.00 green:0.55 blue:0.78 alpha:1];
    [self.blue addTarget:self action:@selector(blue:) forControlEvents:UIControlEventTouchUpInside];
    [self.blueView addSubview:self.blue];
    
    self.redView = [[UIView alloc]initWithFrame:CGRectMake(84, 429, 32, 32)];
    self.redView.backgroundColor = [UIColor whiteColor];
    self.redView.layer.cornerRadius = 16;
    [self.view addSubview:self.redView];
    
    self.red = [UIButton buttonWithType:UIButtonTypeSystem];
    self.red.frame = CGRectMake(1, 1, 30, 30);
    self.red.layer.cornerRadius = 15;
//    self.red.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"suiji.png"]];
    self.red.backgroundColor = [UIColor redColor];
    [self.red setTitle:@"随机" forState:UIControlStateNormal];
    [self.red setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.red addTarget:self action:@selector(red:) forControlEvents:UIControlEventTouchUpInside];
    [self.redView addSubview:self.red];
    
    
    self.greenView = [[UIView alloc]initWithFrame:CGRectMake(119, 429, 32, 32)];
    self.greenView.backgroundColor = [UIColor whiteColor];
    self.greenView.layer.cornerRadius = 16;
    [self.view addSubview:self.greenView];
    
    self.green = [UIButton buttonWithType:UIButtonTypeSystem];
    self.green.frame = CGRectMake(1, 1, 30, 30);
    self.green.layer.cornerRadius = 15;
    self.green.backgroundColor = [UIColor orangeColor];
    [self.green addTarget:self action:@selector(green:) forControlEvents:UIControlEventTouchUpInside];
    [self.greenView addSubview:self.green];
    
    self.blackView = [[UIView alloc]initWithFrame:CGRectMake(154, 429, 32, 32)];
    self.blackView.backgroundColor = [UIColor whiteColor];
    self.blackView.layer.cornerRadius = 16;
    [self.view addSubview:self.blackView];
    
    self.black = [UIButton buttonWithType:UIButtonTypeSystem];
    self.black.frame = CGRectMake(1, 1, 30, 30);
    self.black.layer.cornerRadius = 15;
    self.black.backgroundColor = [UIColor blackColor];
    [self.black addTarget:self action:@selector(black:) forControlEvents:UIControlEventTouchUpInside];
    [self.blackView addSubview:self.black];
    
    
    self.exitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.exitButton setTitle:@"注销" forState:UIControlStateNormal];
    [self.exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.exitButton.frame = CGRectMake(80, 480, 30, 30);
    self.exitButton.frame = CGRectMake(115 , 115, 50, 30);
    self.exitButton.hidden = YES;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"zhuangtai"] isEqualToString:@"1"]) {
        self.exitButton.hidden = YES;
    } else{
        self.exitButton.hidden = NO;
    }

    
    [self.exitButton addTarget:self action:@selector(logoutButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.exitButton];

    self.imageone.tag = 10001;
    [self.imageone setUserInteractionEnabled:YES];
    
    
    
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    //设置需要点击几次才会触发方法
    tap.numberOfTapsRequired = 1;
    //设置需要几个手指点击
//    tap.numberOfTouchesRequired = 1;
    
    //将手势添加到imageView上
    [self.imageone addGestureRecognizer:tap];
    [tap release];

    
    
    // Do any additional setup after loading the view.
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    PictureViewController *PicVC = [[PictureViewController alloc]init];
    
    [self presentViewController:PicVC animated:YES completion:^{
        
    }];
    
    //设置block
    void(^changeView)(NSString *string) = ^(NSString *string){
//        self.imageone = string;
        UIImageView *imageview = (UIImageView *)[self.view viewWithTag:10001];
        imageview.layer.cornerRadius = 40;
        imageview.layer.masksToBounds = YES;
        imageview.image = [UIImage imageNamed:string];
        [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"touxiang"];

    };
    
    PicVC.block2 = changeView;
    
}


- (void)ClickOne:(UIButton *)button
{
    NSLog(@"登陆");
}
- (void)ClickTwo:(UIButton *)button
{
//    NSLog(@"收藏");
    JieshaoController *a = [[JieshaoController alloc] init];
//    [a release];
    [self presentViewController:a animated:YES completion:^{
        
    }];
    
}
- (void)ClickThree:(UIButton *)button
{
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"清除缓存" leftButtonTitle:nil rightButtonTitle:@"sure"];
    [alert show];
    alert.rightBlock = ^() {
        dispatch_async(
                       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                       , ^{
                           NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                           NSLog(@"___%@", cachPath);
                           NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                           NSLog(@"files :%d",[files count]);
                           for (NSString *p in files) {
                               NSError *error;
                               NSString *path = [cachPath stringByAppendingPathComponent:p];
                               if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                                   [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                               }
                           }
                           [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
        
        
    };
    alert.dismissBlock = ^() {
        NSLog(@"无操作");
        
    };
    
    //    NSLog(@"内存");
}
-(void)clearCacheSuccess
{

}



- (void)ClickFour:(UIButton *)button
{

    OurViewController *our = [[OurViewController alloc] init];
    
    [self presentViewController:our animated:YES completion:^{
        
    }];
    
    
    [our release];
    
}

- (void)yellow:(UIButton *)button
{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:@"主题1" object:@"附带的参数" userInfo:nil];
//    [center postNotificationName:@"" object:<#(id)#>]

    
}
- (void)blue:(UIButton *)button
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:@"主题2" object:@"附带的参数" userInfo:nil];

    NSLog(@"蓝");
}
- (void)red:(UIButton *)button
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:@"主题3" object:@"附带的参数" userInfo:nil];

    NSLog(@"红");
}
- (void)green:(UIButton *)button
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:@"主题4" object:@"附带的参数" userInfo:nil];

    NSLog(@"绿");
    
}
- (void)black:(UIButton *)button
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:@"主题5" object:@"附带的参数" userInfo:nil];
    NSLog(@"黑");
}

- (void)loginBtnClickHandler:(id)sender
{
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               
                               
                               if (result)
                               {
                                   [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"zhuangtai"];
                                   [[NSUserDefaults standardUserDefaults] synchronize];
                                   self.one.hidden = YES;
                                   self.exitButton.hidden = NO;

                                   
                                   PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
                                   [query whereKey:@"uid" equalTo:[userInfo uid]];
                                   
                                   [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                       
                                       if ([objects count] == 0)
                                       {
                                           PFObject *newUser = [PFObject objectWithClassName:@"UserInfo"];
                                           [newUser setObject:[userInfo uid] forKey:@"uid"];
                                           [newUser setObject:[userInfo nickname] forKey:@"name"];
                                           [newUser setObject:[userInfo profileImage] forKey:@"icon"];
                                           [newUser saveInBackground];
                                           
                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"欢迎注册" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                                           [alertView show];
                                           [alertView release];
                                       }
                                       else
                                       {

                                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"欢迎回来" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                                               [alertView show];
                                               [alertView release];
                                       }
                                   }];
                                   
                                   
                                   
                            }
                               
                           }];}

- (void)logoutButtonClickHandler:(id)sender
{
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (result) {
            
            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"真的注销?" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
            [alert show];
            alert.leftBlock = ^() {
                //        NSLog(@"left button clicked");
            };
            alert.rightBlock = ^() {
                
                [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
                self.one.hidden = NO;
                self.exitButton.hidden = YES;
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"zhuangtai"];
                [[NSUserDefaults standardUserDefaults] synchronize];

                
            };
            alert.dismissBlock = ^() {
            };
        }
    }];

    
}
- (void)changezhuti:(UIButton *)button
{
    static int a = 1;
//    self.background.image = [UIImage imageNamed:[NSString stringWithFormat:@"pifu%d.JPG", a]];
    NSString *name = [NSString stringWithFormat:@"pifu%d.JPG", a];
    self.background.image = [self blurryImage:[UIImage imageNamed:name] withBlurLevel:0.5];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"pifu%d.JPG", a] forKey:@"leftBackground"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    if (a == 38) {
        a = 1;
    }
    a++;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
