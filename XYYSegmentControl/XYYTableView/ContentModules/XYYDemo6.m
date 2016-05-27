//
//  XYYDemo6.m
//  XYYSegmentControl
//
//  Created by xuyong on 16/5/9.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "XYYDemo6.h"
#import "XYYSegmentControl.h"
#import "RootViewController.h"

@interface XYYDemo6()<XYYSegmentControlDelegate>
@property (nonatomic, strong) XYYSegmentControl *slideSwitchView;
@property (nonatomic, strong)  NSArray               *itemArray;

@end

@implementation XYYDemo6

-(void)dealloc
{
    NSLog(@"XYYDemo6 dealloc-----");
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"XYYDemo6";
    [self buildSegment];
}

#pragma mark - 配置segment
-(void)buildSegment
{
    //注意：设置字体大小，颜色，的背景，并且itemArray,itemHighlight的值
    self.itemArray         = @[@"1"         ,@"2"         ,@"3"         ,@"4"         ,@"5"];
    NSArray *itemHighlight = @[@"1-selected",@"2-selected",@"3-selected",@"4-selected",@"5-selected"];
    
    self.slideSwitchView = [[XYYSegmentControl alloc] initWithFrame:CGRectMake(0 , 64 , self.view.frame.size.width, self.view.frame.size.height - 64)
                                                      sectionImages:self.itemArray
                                              sectionSelectedImages:itemHighlight
                                                             source:self];
    [self.slideSwitchView setUserInteractionEnabled:YES];
    //XYYSegmentControl代理
    self.slideSwitchView.segmentControlDelegate = self;
    
    //设置tab 颜色(可选)
    self.slideSwitchView.tabItemNormalColor = [UIColor blueColor];
    //设置tab 被选中的颜色(可选)
    self.slideSwitchView.tabItemSelectedColor = [UIColor redColor];
    //设置tab 背景颜色(可选)
    self.slideSwitchView.tabItemNormalBackgroundColor = [UIColor whiteColor];
    //设置tab 被选中的标识的颜色(可选)
    self.slideSwitchView.tabItemSelectionIndicatorColor = [UIColor orangeColor];
    //设置tab 被选中标识的风格
    self.slideSwitchView.tabSelectionStyle = XYYSegmentedControlSelectionStyleTextWidthStripe;
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
