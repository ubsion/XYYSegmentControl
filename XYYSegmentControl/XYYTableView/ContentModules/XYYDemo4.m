//
//  XYYDemo4.m
//  XYYSegmentControl
//
//  Created by xuyong on 16/5/9.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "XYYDemo4.h"
#import "XYYSegmentControl.h"
#import "RootViewController.h"

@interface XYYDemo4()<XYYSegmentControlDelegate>
@property (nonatomic, strong) XYYSegmentControl *slideSwitchView;
@property (nonatomic,strong)  NSArray               *itemArray;

@end

@implementation XYYDemo4

-(void)dealloc
{
    NSLog(@"XYYDemo4 dealloc-----");
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"XYYDemo4";
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
    
    //注意：设置字体大小，颜色，的背景，并且tabSelectionStyle设置成XYYSegmentedControlSelectionStyleArrow 实现带有箭头
    
    //设置tab 颜色(可选)
    self.slideSwitchView.tabItemNormalColor = [UIColor blueColor];
    //设置tab 被选中的颜色(可选)
    self.slideSwitchView.tabItemSelectedColor = [UIColor redColor];
    //设置tab 背景颜色(可选)
    self.slideSwitchView.tabItemNormalBackgroundColor = [UIColor lightGrayColor];
    //设置tab 被选中的标识的颜色(可选)
    self.slideSwitchView.tabItemSelectionIndicatorColor = [UIColor orangeColor];
    //设置tab 被选中标识的风格
    self.slideSwitchView.tabSelectionStyle = XYYSegmentedControlSelectionStyleArrow;
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
    [self addChildViewController:root];
    root.title = _itemArray[number];
    return root;
}

- (void)slideSwitchView:(XYYSegmentControl *)view didselectTab:(NSUInteger)number
{
    RootViewController *root = view.viewArray[number];
    [root rootLoadData:number];
}
@end
