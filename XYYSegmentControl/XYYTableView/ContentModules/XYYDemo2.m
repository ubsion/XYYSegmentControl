//
//  XYYDemo2.m
//  XYYSegmentControl
//
//  Created by xuyong on 16/5/9.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "XYYDemo2.h"
#import "XYYSegmentControl.h"
#import "RootViewController.h"

@interface XYYDemo2()<XYYSegmentControlDelegate>
@property (nonatomic, strong) XYYSegmentControl *slideSwitchView;
@property (nonatomic,strong)  NSArray               *itemArray;

@end

@implementation XYYDemo2
-(void)dealloc
{
    NSLog(@"XYYDemo2 dealloc-----");
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"XYYDemo2";
    [self buildSegment];
}

#pragma mark - 配置segment
-(void)buildSegment
{
    self.itemArray = @[@"首页",@"游戏",@"娱乐",@"新闻",@"游戏",@"网页游戏",@"段子",@"科技"];
    self.slideSwitchView = [[XYYSegmentControl alloc]initWithFrame:CGRectMake(0 , 64 , self.view.frame.size.width, self.view.frame.size.height - 64) channelName:_itemArray source:self];
    [self.slideSwitchView setUserInteractionEnabled:YES];
    //XYYSegmentControl代理
    self.slideSwitchView.segmentControlDelegate = self;
    
    //注意：设置字体大小，颜色，的背景，并且tabSelectionIndicatorLocation设置成XYYSegmentedControlSelectionIndicatorLocationNone 实现木有被选中效果
    
    //设置tab 颜色(可选)
    self.slideSwitchView.tabItemNormalColor = [UIColor blueColor];
    //设置tab 被选中的颜色(可选)
    self.slideSwitchView.tabItemSelectedColor = [UIColor redColor];
//    //设置tab 背景颜色(可选)
//    self.slideSwitchView.tabItemNormalBackgroundColor = [UIColor lightGrayColor];
//    //设置tab 被选中的标识的颜色(可选)
//    self.slideSwitchView.tabItemSelectionIndicatorColor = [UIColor orangeColor];
    
    
    //设置tab字体大小(可选)
    self.slideSwitchView.tabItemNormalFont  = 20;
    //被选中字体大小 (可选)
    self.slideSwitchView.tabItemSelectedFont = 25;
    //设置tab 被选中标识的位置
    self.slideSwitchView.tabSelectionIndicatorLocation = XYYSegmentedControlSelectionIndicatorLocationNone;

    
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
