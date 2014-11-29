//
//  pinglun.m
//  Music
//
//  Created by apple on 14-10-13.
//  Copyright (c) 2014年 lanou3g.com. All rights reserved.
//

#import "pinglun.h"
#import "MainTableViewCell.h"
#import "Music.h"
#import "NetWorkHandier.h"
#import "UIImageView+AFNetworking.h"
#import "FXBlurView.h"
#import "MONActivityIndicatorView.h"
#import <Accelerate/Accelerate.h>
@interface pinglun ()<MONActivityIndicatorViewDelegate>
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) UIButton *jiazai;
@end

@implementation pinglun

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.array = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] init];
    indicatorView.numberOfCircles = 3;
    indicatorView.radius = 20;
    indicatorView.internalSpacing = 3;
    indicatorView.duration = 0.5;
    indicatorView.delay = 0.5;
    indicatorView.center = self.view.center;
    indicatorView.delegate = self;
    
    
    [indicatorView startAnimating];

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.userInteractionEnabled = YES;
    imageView.image = [self blurryImage:self.beijing withBlurLevel:0.9];
    [self.view addSubview:imageView];
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip];
    [swip release];
    
//    FXBlurView *mohu = [[FXBlurView alloc] initWithFrame:self.view.bounds];
//    mohu.blurEnabled = 10;
//    [self.view addSubview:mohu];

    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.rowHeight = 80;
    self.tableview.backgroundView = nil;
    
    
    //*****************************************
    [self.tableview registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"sb"];
//    [mohu addSubview:self.tableview];
    [self.view addSubview:self.tableview];
    
    
    
    
    self.jiazai = [[UIButton alloc] initWithFrame:CGRectMake(120, 300, 80, 50)];
    [self.jiazai setTitle:@"加载中..." forState:UIControlStateNormal];
    [self.jiazai setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.jiazai.backgroundColor = [UIColor whiteColor];
    self.jiazai.alpha = 0.7;
    self.jiazai.layer.cornerRadius = 10;
    [self.view addSubview:self.jiazai];
    [self.jiazai release];

    
    
    NSString *pinglun = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/comment?device=iPhone&pageId=1&pageSize=30&trackId=%@",self.ID];
    [NetWorkHandier getConnectionWithURL:pinglun comletion:^(id result) {
        self.dic1 = result;
        NSMutableArray *eventDics = [result objectForKey:@"list"];
        for (NSDictionary *dic in eventDics) {
            Music *eve = [[Music alloc]initWithDictionary:dic];
            [self.array addObject:eve];
            [eve release];
            [indicatorView stopAnimating];
            [self.jiazai removeFromSuperview];
            [self.tableview reloadData];
        }
        
    }];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < -60) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];

    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MainTableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"sb"];
    if (myCell == nil) {
        myCell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"sb"];
        
    }
    
    //********************
 
    
        Music *eve = [self.array objectAtIndex:indexPath.row];

        myCell.nameLabel.text = eve.peopleName;
    
        myCell.replyLabel.text = eve.content;
        
        myCell.floorLabel.text = [NSString stringWithFormat:@"%d楼",self.array.count - indexPath.row];
        id imageStr = eve.smallHeader;//照片

        NSURL *url = [NSURL URLWithString:imageStr];
        [myCell.pictImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei.png"]];
    
    myCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return myCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Music *music = [self.array objectAtIndex:indexPath.row];
    
    
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGRect rect = [music.content boundingRectWithSize:CGSizeMake(270,0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height + 80;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click:(UISwipeGestureRecognizer *)button
{
    

//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
}
- (UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index
{
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
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
    [_tableview release];
    [_array release];
    [_arr release];
    [_ID release];
    [_dic1 release];
    [_beijing release];
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
