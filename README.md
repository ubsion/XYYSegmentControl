# XYYSegmentDemo
##多页签显示，基于HMSegmentedControl再封装，

![image](https://github.com/1273011249/XYYSegmentControl/blob/master/SegmentDemo_gif.gif)

##使用方法：
    
self.itemArray = @[@"首页",@"游戏",@"娱乐",@"新闻",@"游戏",@"网页游戏",@"段子",@"科技"];
    
self.slideSwitchView = [[XYYSegmentControl alloc]initWithFrame:CGRectMake(0 , 20 , self.view.frame.size.width, self.view.frame.size.height - 20) channelName:_itemArray source:self];
    
[self.slideSwitchView setUserInteractionEnabled:YES];
    
//XYYSegmentControl代理

self.slideSwitchView.segmentControlDelegate = self;
    
//设置tab 颜色

self.slideSwitchView.tabItemNormalColor = [UIColor blueColor];

//设置tab 被选中的颜色

self.slideSwitchView.tabItemSelectedColor = [UIColor redColor];
    
//设置tab 背景颜色

self.slideSwitchView.tabItemNormalBackgroundColor = [UIColor lightGrayColor];

//设置tab 被选中的标识的颜色

self.slideSwitchView.tabItemSelectionIndicatorColor = [UIColor orangeColor];

//设置tab 被选中标识的风格

self.slideSwitchView.tabSelectionStyle = XYYSegmentedControlSelectionStyleFullWidthStripe;

//设置tab 被选中标识的位置

self.slideSwitchView.tabSelectionIndicatorLocation = XYYSegmentedControlSelectionIndicatorLocationDown;

[self.view addSubview:self.slideSwitchView];

## pod 使用
pod 'XYYSegmentControl', '~> 0.0.1'


