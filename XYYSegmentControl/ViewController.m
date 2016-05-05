//
//  ViewController.m
//  SegmentDemo
//
//  Created by xuyong on 16/4/27.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "ViewController.h"
#import "XYYSegmentControl.h"
#import "RootViewController.h"

@interface ViewController ()<XYYSegmentControlDelegate>
@property (nonatomic, strong) XYYSegmentControl *slideSwitchView;
@property (nonatomic,strong)  NSArray               *itemArray;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildSegment];
    
    //跳转指定页面
//    [self.slideSwitchView changeSlideAtSegmentIndex:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 配置segment
-(void)buildSegment
{
    self.itemArray = @[@"首页",@"游戏",@"娱乐",@"新闻",@"游戏",@"网页游戏",@"段子",@"科技"];
    self.slideSwitchView = [[XYYSegmentControl alloc]initWithFrame:CGRectMake(0 , 20 , self.view.frame.size.width, self.view.frame.size.height - 20) channelName:_itemArray source:self];
    [self.slideSwitchView setUserInteractionEnabled:YES];
    //XYYSegmentControl代理
    self.slideSwitchView.segmentControlDelegate = self;
    //设置tab 颜色(可选)
    self.slideSwitchView.tabItemNormalColor = [UIColor blueColor];
    //设置tab 被选中的颜色(可选)
    self.slideSwitchView.tabItemSelectedColor = [UIColor redColor];
    //设置tab 背景颜色(可选)
    self.slideSwitchView.tabItemNormalBackgroundColor = [UIColor lightGrayColor];
    //设置tab 被选中的标识的颜色(可选)
    self.slideSwitchView.tabItemSelectionIndicatorColor = [UIColor orangeColor];
    //设置tab字体大小(可选)
//    self.slideSwitchView.tabItemNormalFont  = 30;
    //设置tab 被选中标识的风格
    self.slideSwitchView.tabSelectionStyle = XYYSegmentedControlSelectionStyleFullWidthStripe;
    //设置tab 被选中标识的位置
    self.slideSwitchView.tabSelectionIndicatorLocation = XYYSegmentedControlSelectionIndicatorLocationDown;
    [self.view addSubview:self.slideSwitchView];
}

-(NSUInteger)numberOfTab:(XYYSegmentControl *)view
{
    return [self.itemArray count];//items决定
}

///待加载的控制器
-(UIViewController *)slideSwitchView:(XYYSegmentControl *)view viewOfTab:(NSUInteger)number
{
    RootViewController *root = [[RootViewController alloc] init];
    root.title = _itemArray[number];
    return root;
}

- (void)slideSwitchView:(XYYSegmentControl *)view didselectTab:(NSUInteger)number
{
    RootViewController *root = view.viewArray[number];
    [root rootLoadData:number];
}

@end
