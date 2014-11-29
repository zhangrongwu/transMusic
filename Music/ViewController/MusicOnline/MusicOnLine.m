//
//  MusicOnLine.m
//  Music
//
//  Created by lothario on 14-9-29.
//  Copyright (c) 2014年 lanou3g.com. All rights reserved.
//

#import "MusicOnLine.h"
#import "PininterestLikeMenu.h"
#import "ZYQSphereView.h"
#import "PhotoAlbum.h"
#import "NetworkHandler.h"
#import "SecondViewController.h"
#import "MyTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

#import "BBTableView.h"
#import "BBCell.h"
#define KEY_TITLE @"title"
#define KEY_IMAGE_NAME @"image_name"
#define KEY_IMAGE @"image"

#import "TwoViewController.h"
#import "ThreeViewController.h"

#import "FXBlurView.h"
#import "MONActivityIndicatorView.h"
#import <Accelerate/Accelerate.h>
#import "UIImageView+WebCache.h"

#import "INSSearchBar.h"
#import "NetWorkHandier.h"
#import "CloudView.h"
@interface MusicOnLine ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, MONActivityIndicatorViewDelegate, INSSearchBarDelegate>

//排行
{
    NSMutableArray *mDataSource;
}
@property (nonatomic, retain)BBTableView *tableView1;
@property (nonatomic, retain)NSMutableArray *arrayOfPaihang;





@property (nonatomic, retain)UIScrollView *scrollView;

//长按弹出按钮的属性
@property (nonatomic, assign) CGPoint beginLocation;
@property (nonatomic, strong) PininterestLikeMenu *menu;



//分类3D
@property (nonatomic, retain) ZYQSphereView *sphereView;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSMutableArray *arrOfTypeName;


//焦点
@property (nonatomic, strong) NSMutableArray *tableItems;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *idOfjiaodian;

//搜素
@property (nonatomic, strong) INSSearchBar *searchBarWithoutDelegate;
@property (nonatomic, strong) INSSearchBar *searchBarWithDelegate;

@property (nonatomic, retain) UIImageView *backimage;


@property (nonatomic, retain)UIImageView *imageOfWelcome;
@property (nonatomic, retain)NSTimer *timerOfWelcome;

@property (nonatomic, retain)NSArray *arr2;





@property (nonatomic, retain)UIButton *jiazai1;
@property (nonatomic, retain)UIButton *jiazai2;
@end

@implementation MusicOnLine

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.title = @"分类";
//        self.navigationController.navigationBarHidden = YES;
        
//        self.navigationController.navigationBarHidden = YES;
        
        self.scrollView = [[UIScrollView alloc] init];
        self.arrayOfPaihang = [NSMutableArray array];
        self.arrOfTypeName = [NSMutableArray array];
        
        self.arrOfId = [NSMutableArray array];
        
        self.backimagepaihang = [[UIImageView alloc] init];
        
        self.kaiji = [[UIImageView alloc] init];
        self.backimage = [[UIImageView alloc] init];


        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(suibian1:) name:@"主题1" object:nil];
        [center addObserver:self selector:@selector(suibian2:) name:@"主题2" object:nil];
        [center addObserver:self selector:@selector(suibian3:) name:@"主题3" object:nil];
        [center addObserver:self selector:@selector(suibian4:) name:@"主题4" object:nil];
        [center addObserver:self selector:@selector(suibian5:) name:@"主题5" object:nil];

        
    }
    return self;
}
- (void)suibian1:(NSNotification *)noti
{
//    self.contentView.backgroundColor = ;
    self.backimagepaihang.image = nil;
    self.backimage.image = nil;
    self.view001.image = nil;
    self.view001.backgroundColor = [UIColor colorWithRed:0.63 green:0.17 blue:0.43 alpha:1];

    self.backimage.backgroundColor = [UIColor colorWithRed:0.63 green:0.17 blue:0.43 alpha:1];
    self.backimagepaihang.backgroundColor = [UIColor colorWithRed:0.63 green:0.17 blue:0.43 alpha:1];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"backGroundImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
}
- (void)suibian2:(NSNotification *)noti
{
    //    self.contentView.backgroundColor = ;
    self.backimagepaihang.image = nil;
    self.backimage.image = nil;
    self.view001.image = nil;
    self.view001.backgroundColor = [UIColor colorWithRed:0.00 green:0.55 blue:0.78 alpha:1];


    self.backimage.backgroundColor = [UIColor colorWithRed:0.00 green:0.55 blue:0.78 alpha:1];
    self.backimagepaihang.backgroundColor = [UIColor colorWithRed:0.00 green:0.55 blue:0.78 alpha:1];
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"backGroundImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];


    
}
- (void)suibian3:(NSNotification *)noti
{
    //    self.contentView.backgroundColor = ;
    static int a = 1;
//    self.backimagepaihang.image = [UIImage imageNamed:[NSString stringWithFormat:@"pifu%d.JPG", a]];
    self.backimagepaihang.image = [self blurryImage:[UIImage imageNamed:[NSString stringWithFormat:@"pifu%d.JPG", a]] withBlurLevel:0.5];
    self.view001.image = [self blurryImage:[UIImage imageNamed:[NSString stringWithFormat:@"pifu%d.JPG", a]] withBlurLevel:0.5];
    self.backimage.image = [self blurryImage:[UIImage imageNamed:[NSString stringWithFormat:@"pifu%d.JPG", a]] withBlurLevel:0.5];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"pifu%d.JPG", a] forKey:@"backGroundImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    if (a == 38) {
        a = 0;
    }
    a++;
    
    


}
- (void)suibian4:(NSNotification *)noti
{
    //    self.contentView.backgroundColor = ;
    self.backimagepaihang.image = nil;
    self.backimage.image = nil;
    self.view001.image = nil;
    self.view001.backgroundColor = [UIColor orangeColor];


    self.backimage.backgroundColor = [UIColor orangeColor];
    self.backimagepaihang.backgroundColor = [UIColor orangeColor];
    [[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:@"backGroundImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];



    
}
- (void)suibian5:(NSNotification *)noti
{
    //    self.contentView.backgroundColor = ;
    self.backimagepaihang.image = nil;
    self.backimage.image = nil;
    self.view001.image = nil;
    self.view001.backgroundColor = [UIColor blackColor];


    self.backimagepaihang.backgroundColor = [UIColor blackColor];
    self.backimage.backgroundColor = [UIColor blackColor];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"4" forKey:@"backGroundImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];


    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    


    
    
    
    
    
    
    
    //长按弹出按钮
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(popPininterestMenu:)];
    gesture.delegate = self;
    //判定为长按手势  需要的最短时间
    gesture.minimumPressDuration = 0.5;
    [self.view addGestureRecognizer:gesture];




    
    self.scrollView.frame = self.view.bounds;
    //scrollView的滚动范围
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*4+50, 0);
    //设置能否滚动
    self.scrollView.scrollEnabled = NO;
    //按页翻动
    self.scrollView.pagingEnabled = NO;
    //是否要滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //scrollView的偏移量(刚开始默认位置)
    self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width*2, 0);
    //scrollView的代理(需要签署协议)
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = YES;//防止乱跳

    
   //分类
    self.view001 = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    self.view001.backgroundColor = [UIColor blackColor];
//    self.view001.image = [UIImage imageNamed:@"pifu17.JPG"];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] == nil) {
        //如果第一次
        [[NSUserDefaults standardUserDefaults] setObject:@"pifu2.JPG" forKey:@"backGroundImage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.view001.image = [self blurryImage:[UIImage imageNamed:@"pifu2.JPG"] withBlurLevel:0.8];
        
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] isEqualToString:@"1"]) {
        self.view001.backgroundColor = [UIColor colorWithRed:0.63 green:0.17 blue:0.43 alpha:1];
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] isEqualToString:@"2"]) {
        self.view001.backgroundColor = [UIColor colorWithRed:0.00 green:0.55 blue:0.78 alpha:1];
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] isEqualToString:@"3"]) {
        self.view001.backgroundColor = [UIColor orangeColor];
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] isEqualToString:@"4"]) {
        self.view001.backgroundColor = [UIColor blackColor];
    } else {
        //不是第一次
        
        self.view001.image = [self blurryImage:[UIImage imageNamed:[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"]] withBlurLevel:0.8];
        
    }

    
    
    
    
    
    self.view001.userInteractionEnabled = YES;
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] init];
    indicatorView.numberOfCircles = 3;
    indicatorView.radius = 20;
    indicatorView.internalSpacing = 3;
    indicatorView.duration = 0.5;
    indicatorView.delay = 0.5;
    indicatorView.center = self.view001.center;
    indicatorView.delegate = self;
    [self.view001 addSubview:indicatorView];
    
    [indicatorView startAnimating];

    
////    FXBlurView *mohu001 = [[FXBlurView alloc] initWithFrame:self.view001.bounds];
//    FXBlurView *mohu001 = [FXBlurView sharedInstance];
//    mohu001.frame = self.view001.bounds;
//    mohu001.userInteractionEnabled = YES;
//    mohu001.blurRadius = 80;
//    [self.view001 addSubview:mohu001];
////    [mohu001 release];


//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1:)];
//    
//    //设置需要点击几次才会触发
//    tap1.numberOfTapsRequired = 2;
//    
//    //将手势添加到imageView上
//    [self.view001 addGestureRecognizer:tap1];
//    [tap1 release];

    [self.scrollView addSubview:self.view001];
    
    
    NSMutableArray *arrayOfType = [NSMutableArray array];
    NSString *typeurl = @"http://mobile.ximalaya.com/m/category_tag_list?category=music&device=iPhone&type=album";
    [NetworkHandler getConnectionWithURL:typeurl completion:^(id result) {
        NSArray *arr = [result objectForKey:@"list"];
        for (NSDictionary *dic in arr) {
            NSString *tname = [dic objectForKey:@"tname"];
            [self.arrOfTypeName addObject:tname];
            tname = [tname substringToIndex:2];
            [arrayOfType addObject:tname];
        }
        self.sphereView = [[ZYQSphereView alloc] initWithFrame:CGRectMake(10, 0, 300, 250)];
        self.sphereView.center=CGPointMake(self.view.center.x, self.view.center.y-30);
        NSMutableArray *views = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arrayOfType count]; i++) {
            UIButton *subV = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 60)];
            subV.tag = i + 1;
            subV.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100. green:arc4random_uniform(100)/100. blue:arc4random_uniform(100)/100. alpha:1];
            [subV setTitle:[NSString stringWithFormat:@"%@",[arrayOfType objectAtIndex:i]] forState:UIControlStateNormal];
            subV.layer.masksToBounds=YES;
            subV.layer.cornerRadius=3;
            [subV addTarget:self action:@selector(subVClick:) forControlEvents:UIControlEventTouchUpInside];
            [views addObject:subV];
            [subV release];
        }
        
        [self.sphereView setItems:views];
        
        self.sphereView.isPanTimerStart=YES;
        [views release];
        
        [self.view001 addSubview:self.sphereView];
        [self.sphereView timerStart];
        [indicatorView stopAnimating];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(330, 10, 50, 50);
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [button release];
        
    }];
    
	   
    
    
    
    
    
    
    
    
    
    
//    //焦点
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, 568)];
    view1.backgroundColor = [UIColor clearColor];
    
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:view1.bounds];
//    imageView.image = [self blurryImage:[UIImage imageNamed:@"pifu21.JPG"] withBlurLevel:0.5];
//    [view1 addSubview:imageView];
    
    [self.scrollView addSubview:view1];
    
    
    self.arr = [[NSMutableArray alloc] init];
    self.idOfjiaodian = [[NSMutableArray alloc] init];
    // Load the items in the table
    self.tableItems = [[NSMutableArray alloc]init];
    [NetworkHandler getConnectionWithURL:@"http://mobile.ximalaya.com/m/subject_list?device=iPhone&page=1&per_page=20" completion:^(id result) {
        //处理数据
        self.arr = [result objectForKey:@"list"];
        //for循环将字典转化为movie对象
        for (NSDictionary *dic in self.arr) {
            if ([[dic objectForKey:@"contentType"] intValue] == 2) {
                
                NSString *imageurl = [dic objectForKey:@"coverPathBig"];
                [self.tableItems addObject:imageurl];
                NSString *idOfjiaodian = [dic objectForKey:@"specialId"];
                [self.idOfjiaodian addObject:idOfjiaodian];
            }
        }
//        NSLog(@"%@", self.idOfjiaodian);
//        [indicatorView stopAnimating];
        [self.jiazai1 removeFromSuperview];
        [self.tableView reloadData];
    }];
    
    
    self.tableView =  [[UITableView alloc] initWithFrame:view1.bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 121;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.showsHorizontalScrollIndicator = NO;
    [view1 addSubview:self.tableView];
    [_tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"parallaxCell"];

    self.jiazai1 = [[UIButton alloc] initWithFrame:CGRectMake(120, 300, 80, 50)];
    [self.jiazai1 setTitle:@"加载中..." forState:UIControlStateNormal];
    [self.jiazai1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.jiazai1.backgroundColor = [UIColor whiteColor];
    self.jiazai1.alpha = 0.7;
    self.jiazai1.layer.cornerRadius = 10;
    [view1 addSubview:self.jiazai1];
    [self.jiazai1 release];


    
    
    
    
    
    
    //排行
    [NetworkHandler getConnectionWithURL:@"http://mobile.ximalaya.com/m/explore_track_list?category_name=music&condition=hot&device=iPhone&page=1&per_page=20&tag_name=" completion:^(id result) {
        self.arrayOfPaihang = [result objectForKey:@"list"];
        for (NSDictionary *dic in self.arrayOfPaihang) {
            
            [self.arrOfId addObject:[dic objectForKey:@"id"]];
            
        }
//        [indicatorView stopAnimating];
        [self.jiazai2 removeFromSuperview];
        [self.tableView1 reloadData];
    }];
    
    
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(2*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view2.tag = 30;
    view2.backgroundColor = [UIColor colorWithRed:0.63 green:0.17 blue:0.43 alpha:1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
//    FXBlurView *mohu = [[FXBlurView alloc] initWithFrame:view2.bounds];
//    mohu.userInteractionEnabled = YES;
//    mohu.blurEnabled = 10;

    
    self.backimagepaihang.frame = view2.bounds;
//    self.backimagepaihang.image = [UIImage imageNamed:@"pifu21.JPG"];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] == nil) {
        //如果第一次
        [[NSUserDefaults standardUserDefaults] setObject:@"pifu2.JPG" forKey:@"backGroundImage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.backimagepaihang.image = [self blurryImage:[UIImage imageNamed:@"pifu2.JPG"] withBlurLevel:0.5];
        
    }  else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] isEqualToString:@"1"]) {
        self.backimagepaihang.backgroundColor = [UIColor colorWithRed:0.63 green:0.17 blue:0.43 alpha:1];
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] isEqualToString:@"2"]) {
        self.backimagepaihang.backgroundColor = [UIColor colorWithRed:0.00 green:0.55 blue:0.78 alpha:1];
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] isEqualToString:@"3"]) {
        self.backimagepaihang.backgroundColor = [UIColor orangeColor];
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] isEqualToString:@"4"]) {
        self.backimagepaihang.backgroundColor = [UIColor blackColor];
    } else {
        //不是第一次
        self.backimagepaihang.image = [self blurryImage:[UIImage imageNamed:[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"]] withBlurLevel:0.5];
        
    }
    
    
    
    
    
    self.backimagepaihang.userInteractionEnabled = YES;
    [view2 addSubview:self.backimagepaihang];
//    [view2 addSubview:mohu];
    
    
    //设置需要点击几次才会触发
    tap.numberOfTapsRequired = 2;
    
    //将手势添加到imageView上
    [view2 addGestureRecognizer:tap];
    [tap release];
//    [mohu release];
    
    
    [self.scrollView addSubview:view2];
    
    self.tableView1 = [[BBTableView alloc] initWithFrame:view2.bounds style:UITableViewStylePlain];
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView1.opaque=NO;
//    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView1.showsHorizontalScrollIndicator=NO;
    self.tableView1.showsVerticalScrollIndicator=NO;
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.rowHeight = 70;
//    self.tableView1.enableInfiniteScrolling = YES;
//    [self loadDataSource];
    [view2 addSubview:self.tableView1];
    
    self.jiazai2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 300, 80, 50)];
    [self.jiazai2 setTitle:@"加载中..." forState:UIControlStateNormal];
    [self.jiazai2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.jiazai2.backgroundColor = [UIColor whiteColor];
    self.jiazai2.alpha = 0.7;
    self.jiazai2.layer.cornerRadius = 10;
    [view2 addSubview:self.jiazai2];
    [self.jiazai2 release];
    
    
    
    
    
    
    
    
    
    

    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLogin"] == nil) {
        //如果第一次
    }
    else {
        //不是第一次
        self.imageOfWelcome = [[UIImageView alloc] initWithFrame:view2.bounds];
        self.imageOfWelcome.image = [UIImage imageNamed:@"welcome.JPG"];
        
        [view2 addSubview:self.imageOfWelcome];
        
        self.timerOfWelcome = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(welcome) userInfo:nil repeats:YES];
        [self.timerOfWelcome fire];
    }
    

    
    [self view3];

    
    
    self.scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView release];
    
    
}

- (void)view3
{
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(3*self.view.frame.size.width+50, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view3.tag = 33;
    view3.backgroundColor = [UIColor colorWithRed:0.63 green:0.17 blue:0.43 alpha:1];
    
    
    
    self.backimage.frame = self.view.bounds;
    self.backimage.userInteractionEnabled = YES;
    
    [view3 addSubview:self.backimage];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] == nil) {
        //如果第一次
        [[NSUserDefaults standardUserDefaults] setObject:@"pifu2.JPG" forKey:@"backGroundImage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.backimage.image = [self blurryImage:[UIImage imageNamed:@"pifu2.JPG"] withBlurLevel:0.5];
        
    }  else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] isEqualToString:@"1"]) {
        self.backimage.backgroundColor = [UIColor colorWithRed:0.63 green:0.17 blue:0.43 alpha:1];
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] isEqualToString:@"2"]) {
        self.backimage.backgroundColor = [UIColor colorWithRed:0.00 green:0.55 blue:0.78 alpha:1];
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] isEqualToString:@"3"]) {
        self.backimage.backgroundColor = [UIColor orangeColor];
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"] isEqualToString:@"4"]) {
        self.backimage.backgroundColor = [UIColor blackColor];
    } else {
        //不是第一次
        self.backimage.image = [self blurryImage:[UIImage imageNamed:[[NSUserDefaults standardUserDefaults] objectForKey:@"backGroundImage"]] withBlurLevel:0.5];
        
    }
    
    
    
    //    NSString *data = @"http://mobile.ximalaya.com/m/explore_track_list?category_name=all&condition=daily&device=iPhone&page=1&per_page=20&tag_name=";
    //    [NetWorkHandier getConnectionWithURL:data comletion:^(id result) {
    //        self.result = result;
    
    
    
    
    
    
    
    //滚动
    
    
    //        NSArray *arr = [self.result objectForKey:@"list"];
    
    self.arr2 = [NSArray arrayWithObjects:@"椰壳电台", @"今晚80后脱口秀",@"刘鹤佳", @"枕边疯电台", @"晓松奇谈", @"郭德纲相声",@"罗辑思维脱口秀", @"糗事百科", @"晚上十点", @"纯色忧伤网络电台", @"佳期", @"晓松奇谈", @"今晚80后脱口秀", @"郭德纲相声", @"糗事百科", @"纯色忧伤网络电台", @"蔷薇岛屿RoseFM", @"枕边疯电台", @"一米阳光音乐台", @"郭德纲相声", nil];
        self.arr1 = [NSMutableArray arrayWithObjects:@"4115928", @"4238443", @"4215153", @"4226907", @"4226265", @"4212351", @"4214270", @"4245652", @"4229531", @"4226773", @"4237143", @"4201763", @"4168041", @"4212350", @"4222956", @"4226568", @"4168156", @"4215272", @"4241367", @"4212352", nil];
    
    //        for (NSDictionary *dic in arr) {
    //            [self.arr1 addObject:[dic objectForKey:@"nickname"]];
    //            //            NSLog(@"%@", [dic objectForKey:@"nickname"]);
    //        }
    self.cv=[[CloudView alloc] initWithFrame:CGRectMake(10, 110, view3.frame.size.width-20, view3.frame.size.height-150)];
    [self.cv reloadData:self.arr2];
    
    [view3 addSubview:self.cv];
    // Do any additional setup after loading the view, typically from a nib.
    view3.backgroundColor = [UIColor colorWithRed:0.00 green:0.55 blue:0.78 alpha:1];
    
    void(^push)(NSString *name) = ^(NSString *name){
//        for (UIView *v in self.cv.subviews) {
//            [v removeFromSuperview];
//        }
        

        
        TwoViewController *twoVC = [[TwoViewController alloc] init];
        twoVC.biaoji = 2;
        [self.navigationController pushViewController:twoVC animated:YES];
        
        NSString *url = [NSString stringWithFormat:@"http://mobile.ximalaya.com/s/mobile/search?condition=%%20%@&device=iPhone&page=1&per_page=20&scope=voice&sort=", name];
        twoVC.string = url;
        [twoVC release];
        
//        ThreeViewController *threeVC = [[ThreeViewController alloc] init];
//        [self presentViewController:threeVC animated:YES completion:^{
//            threeVC.ID = [self.arr1 objectAtIndex:[self.arr2 indexOfObject:name]];
//            threeVC.arrOfjiaodian = self.arr1;
//            threeVC.mp3index = [self.arr2 indexOfObject:name];
//
//        }];
//        [threeVC release];
    };
    self.cv.block = push;
    //    }];
    
    //                NSLog(@"%@",url);
    
    
    
    //下面的
    UILabel *descriptionLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, CGRectGetWidth(view3.bounds) - 40.0, 20.0)];
    descriptionLabel2.textColor = [UIColor whiteColor];
    //    descriptionLabel2.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];
    descriptionLabel2.text = @"搜索";
    
    [view3 addSubview:descriptionLabel2];
    
    self.searchBarWithDelegate = [[INSSearchBar alloc] initWithFrame:CGRectMake(70, 46, 44.0, 34.0)];
    
    self.searchBarWithDelegate.delegate = self;
    
    
    [view3 addSubview:self.searchBarWithDelegate];
    
    
    [self.scrollView addSubview:view3];
    [view3 release];
}


- (void)welcome
{
    static int a = 1;
    if (a == 2) {
//        [self.imageOfWelcome removeFromSuperview];
        [UIView animateWithDuration:1 animations:^{
            self.imageOfWelcome.alpha = 0;
        }];
        [self.timerOfWelcome invalidate];
    }
    a = 2;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //只要scrollView被滚动就就触发
    
//    NSLog(@"滚动触发");
    if (self.scrollView.contentOffset.x == 0 || self.scrollView.contentOffset.x == 320) {
        self.navigationController.navigationBarHidden = YES;
    }else{
        self.navigationController.navigationBarHidden = YES;
    }
    //焦点
    NSArray *visibleCells = [self.tableView visibleCells];
    
    for (MyTableViewCell *cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }


}

//分类
-(void)subVClick:(UIButton*)sender
{
    TwoViewController *twoVC = [[TwoViewController alloc] init];
//    NSLog(@"%@",[self.arrOfTypeName objectAtIndex:sender.tag]);
    twoVC.nameOfType = [self.arrOfTypeName objectAtIndex:sender.tag];
    twoVC.biaoji = 1;
    [self.navigationController pushViewController:twoVC animated:YES];
    
    [twoVC release];
    BOOL isStart=[self.sphereView isTimerStart];
    
    [self.sphereView timerStop];
    
    [UIView animateWithDuration:0.3 animations:^{
        sender.transform=CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            sender.transform=CGAffineTransformMakeScale(1, 1);
            if (isStart) {
                [self.sphereView timerStart];
            }
        }];
    }];
}

//长按弹出按钮
- (void)showMenu
{
    if (!self.menu) {
        PininterestLikeMenuItem *item0 = [[PininterestLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"center"]
                                                                           selctedImage:[UIImage imageNamed:@"center-highlighted"]
                                                                          selectedBlock:^(void) {
                                                                              NSLog(@"item 0 selected");
                                                                                                                                                            self.scrollView.contentOffset = CGPointMake(0, 0);
//                                                                              self.title = @"分类";
                                                                          }];
        PininterestLikeMenuItem *item1 = [[PininterestLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"center"]
                                                                           selctedImage:[UIImage imageNamed:@"center-highlighted"]
                                                                          selectedBlock:^(void) {
                                                                              NSLog(@"item 1 selected");
                                                                              self.scrollView.contentOffset = CGPointMake(320, 0);
//                                                        self.title = @"焦点";
                                                                              
                                                                          }];
        PininterestLikeMenuItem *item2 = [[PininterestLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"center"]
                                                                           selctedImage:[UIImage imageNamed:@"center-highlighted"]
                                                                          selectedBlock:^(void) {
                                                                              NSLog(@"item 2 selcted");
//                                                                              self.title = @"排行";
                                                                              
                                                                              self.scrollView.contentOffset = CGPointMake(640, 0);
                                                                          }];
        PininterestLikeMenuItem *item3 = [[PininterestLikeMenuItem alloc] initWithImage:[UIImage imageNamed:@"center"]
                                                                           selctedImage:[UIImage imageNamed:@"center-highlighted"]
                                                                          selectedBlock:^(void) {
                                                                              NSLog(@"item 3 selcted");
                                                                              
                                                                              UIView *view = [self.view viewWithTag:33];
                                                                              [view removeFromSuperview];
//
                                                                              [self view3];
                                                                              self.scrollView.contentOffset = CGPointMake(640+320+50, 0);                                                                          }];
        
        NSArray *subMenus = @[item0, item1, item2, item3];
        
        self.menu = [[PininterestLikeMenu alloc] initWithSubMenus:subMenus withStartPoint:self.beginLocation];
    }
    
    [self.menu show];
    
}

- (void)popPininterestMenu:(UIGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self.view.window];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.beginLocation = location;
        [self showMenu];
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        [self.menu updataLocation:location];
    }
    else{
        self.beginLocation = CGPointZero;
        [self.menu finished:location];
        self.menu = nil;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}


//焦点
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self scrollViewDidScroll:nil];
//}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView1) {
//        return  [mDataSource count];
//        NSLog(@"====%d", [self.arrayOfPaihang count]);
        return [self.arrayOfPaihang count];
    }

    return self.tableItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //排行
    if (tableView == self.tableView1) {
        static NSString *test = @"table";
        BBCell *cell = (BBCell*)[tableView dequeueReusableCellWithIdentifier:test];
        if( !cell )
        {
            cell = [[BBCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:test];
        }
        [cell setCellTitle:[[self.arrayOfPaihang objectAtIndex:indexPath.row] objectForKey:@"title"]];
        
        NSString *str = [[self.arrayOfPaihang objectAtIndex:indexPath.row] objectForKey:@"coverSmall"];
        if (![str isKindOfClass:[NSNull class]]) {
            
            NSString *newStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSURL *url = [NSURL URLWithString:newStr];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
            
            request.HTTPMethod = @"GET";
            
            //2.连接服务器
            
            
            //参数1:请求
            //参数2:请求结束之后, 返回到哪个线程继续执行任务
            //参数3:请求结束执行block中的内容
            [cell setIcon:[self circleImage:[UIImage imageNamed:@"zhanwei.png"] withParam:0]];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                
                //data是完整的请求完毕的数据
                if (data != nil) {
                    
                    //[cell setIcon:[UIImage imageWithData:data]];
                    [cell setIcon:[self circleImage:[UIImage imageWithData:data] withParam:0]];
                }
            }];
        }

        
        
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        return cell;

    }
 //焦点
    static NSString *CellIdentifier = @"parallaxCell";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    [cell.myImageView setImageWithURL:[NSURL URLWithString:[self.tableItems objectAtIndex:indexPath.row]]placeholderImage:[UIImage imageNamed:@"zhanwei.png"]];
    
    [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:[self.tableItems objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"zhanwei.png"]];
    
    cell.label.text = [[self.arr objectAtIndex:indexPath.row] objectForKey:@"title"];

    cell.selectionStyle = UITableViewCellEditingStyleNone;

    return cell;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // Get visible cells on table view.
//    NSArray *visibleCells = [self.tableView visibleCells];
//    
//    for (MyTableViewCell *cell in visibleCells) {
//        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView1) {
        ThreeViewController *threeVC = [[ThreeViewController alloc] init];
        
        threeVC.arrOfjiaodian = self.arrOfId;
        threeVC.mp3index = indexPath.row;

//        NSLog(@"===%@",self.arrOfId);
        threeVC.ID = [self.arrOfId objectAtIndex:indexPath.row];
//        NSLog(@"===%ld", (long)indexPath.row);
        [threeVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];

        [self presentViewController:threeVC animated:YES completion:^{
            
        }];
//        [self.navigationController pushViewController:threeVC animated:YES];
        [threeVC release];
        
    }else{
    
//    self.navigationController.navigationBarHidden = NO;
    SecondViewController *secondVC = [[SecondViewController alloc]init];
        secondVC.biaoji = 2;
        secondVC.idOfjiaodian = [self.idOfjiaodian objectAtIndex:indexPath.row];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:secondVC];
//    secondVC.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:secondVC animated:YES];
        [secondVC release];
    }
}




//图片变圆
-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //we need to update the cells as the table might have changed its dimensions after rotation
    // [self setupShapeFormationInVisibleCells];
    
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    //update the cells to form the circle shape
//    //[self setupShapeFormationInVisibleCells];
//}

//无限
//- (IBAction)enableInfiniteScrolling:(id)sender
//{
//    [self.tableView setEnableInfiniteScrolling:[sender isOn]];
//    [self.tableView reloadData];
//}
//左右
//- (IBAction)switchDirections:(id)sender
//{
//    [self.tableView setContentAlignment:[sender selectedSegmentIndex] ? eBBTableViewContentAlignmentRight : eBBTableViewContentAlignmentLeft];
//    [self.tableView reloadData];
//}

//双击手势触发的方法
- (void)tapAction:(UITapGestureRecognizer *)tap
{
//    NSLog(@"点击");
    static int a = 2;
    if (a > 1 && a < 15) {
        
        [NetworkHandler getConnectionWithURL:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_track_list?category_name=music&condition=hot&device=iPhone&page=%d&per_page=20&tag_name=",a] completion:^(id result) {
            self.arrayOfPaihang = [result objectForKey:@"list"];
            self.arrOfId = [NSMutableArray array];
            for (NSDictionary *dic in self.arrayOfPaihang) {
                
                [self.arrOfId addObject:[dic objectForKey:@"id"]];
                
            }

            [self.tableView1 reloadData];
        }];
        a++;
    }

    

}



-(void)dealloc
{
    [super dealloc];
    [_tableView release];
    [_arr release];
    [_str release];
    [_dic release];
    [_arr1 release];
    [_cv release];
    [_searchBarWithDelegate release];
    [_searchBarWithoutDelegate release];
    [_backimage release];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)buttonClicked:(UIButton *)button
{
    NSLog(@"ad");
}
#pragma mark 引导页
- (void)viewWillAppear:(BOOL)animated{
    // all settings are basic, pages with custom packgrounds, title image on each page
    self.navigationController.navigationBarHidden = YES;
    UIView *view = [self.view viewWithTag:33];
    [view removeFromSuperview];
    //
    [self view3];


    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLogin"] == nil) {
        //如果第一次
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isFirstLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        static int a = 1;
        if (a == 1) {
            
            [self showIntroWithCrossDissolve];
            [super viewDidAppear:animated];
            a++;
        }
    } else {
        //不是第一次
    }
    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isFirstLogin"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Ranklist";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.bgImage = [UIImage imageNamed:@"01"];
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"search page";
    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    page2.bgImage = [UIImage imageNamed:@"02"];
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"3D technology";
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.bgImage = [UIImage imageNamed:@"03"];
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}
//- (void)tapAction1:(UITapGestureRecognizer *)tap
//{
//    static int a = 1;
//    if (a == 38) {
//        a = 1;
//    }
//    if (a<38) {
////        self.view001.image = [UIImage imageNamed:[NSString stringWithFormat:@"pifu%d.JPG", a]];
//        self.view001.image = [self blurryImage:[UIImage imageNamed:[NSString stringWithFormat:@"pifu%d.JPG", a]] withBlurLevel:0.5];
//        a++;
//    }
//}

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
//搜索
//改变下面点击后弹出搜索框的位置
- (CGRect)destinationFrameForSearchBar:(INSSearchBar *)searchBar
{
    return CGRectMake(70, 56, 220, 30);
}
//每次点击下面放大镜的触发方法(开始触发)
- (void)searchBar:(INSSearchBar *)searchBar willStartTransitioningToState:(INSSearchBarState)destinationState
{
    NSLog(@"每次点击下面放大镜的触发方法");
    
    [self.view endEditing:YES];
    
}
//每次点击下面放大镜的触发方法(结束触发)
- (void)searchBar:(INSSearchBar *)searchBar didEndTransitioningFromState:(INSSearchBarState)previousState
{
    NSLog(@"每次点击下面放大镜的触发方法");
}
//点击键盘上的<return>触发的点击事件
- (void)searchBarDidTapReturn:(INSSearchBar *)searchBar
{
    NSLog(@"点击键盘上的<return>触发的点击事件");
    self.str = [NSString string];
    self.str = searchBar.searchField.text;
    NSLog(@"=======%@",searchBar.searchField.text);
    NSLog(@"+++++++%@",self.str);
    //http://mobile.ximalaya.com/s/mobile/search?condition=%20aaaaaaaaa&device=iPhone&page=1&per_page=20&scope=voice&sort= HTTP/1.1
    //遇到百分号在前面再加一个%
    self.str = [NSString stringWithFormat:@"http://mobile.ximalaya.com/s/mobile/search?condition=%%20%@&device=iPhone&page=1&per_page=20&scope=voice&sort=", self.str];
    //    NSLog(@"**************************************%@",self.str);
    TwoViewController *two = [[TwoViewController alloc]init];
    two.string = self.str;
    two.biaoji = 2;
    [self.navigationController pushViewController:two animated:YES];
    [two release];
    
    for (UIView *v in self.cv.subviews) {
        [v removeFromSuperview];
    }
    
}
//获取每个值
- (void)searchBarTextDidChange:(INSSearchBar *)searchBar
{
    NSLog(@"%@", searchBar.searchField.text);

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
