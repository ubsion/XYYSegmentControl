# XYYSegmentDemo（1.3.1）

##多页签显示，基于HMSegmentedControl再封装
最新demo：

![image](https://github.com/1273011249/XYYSegmentControl/blob/master/SegmentDemoTableview.gif)

正常显示:

![image](https://github.com/1273011249/XYYSegmentControl/blob/master/SegmentDemo_gif.gif)

被选中字体变大显示:

![image](https://github.com/1273011249/XYYSegmentControl/blob/master/SegmentDemo_add.gif)

##使用方法：

    -(void)buildSegment
    {
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
        //设置tab字体大小(可选)
        self.slideSwitchView.tabItemNormalFont  = 20;
        //被选中字体大小 (可选)
        self.slideSwitchView.tabItemSelectedFont = 25;
        //设置tab 被选中标识的风格
        self.slideSwitchView.tabSelectionStyle = XYYSegmentedControlSelectionStyleFullWidthStripe;
        //设置tab 被选中标识的位置
        self.slideSwitchView.tabSelectionIndicatorLocation = XYYSegmentedControlSelectionIndicatorLocationDown;
        [self.view addSubview:self.slideSwitchView];
    }
    ///---XYYSegmentControldelegate---
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

    -(void)slideSwitchView:(XYYSegmentControl *)view didselectTab:(NSUInteger)number
    {
        RootViewController *root = view.viewArray[number];
        [root rootLoadData:number];
    }

## 使用说明
 最新的版本增加了6个demo，分别介绍segment的各种用法：
 
 1.XYYDemo1--最常用的样式
 
 2.XYYDemo2--带有字体放大样式（仿网易）
 
 3.XYYDemo3--带有盒子效果的样式
 
 4.XYYDemo4--带有箭头选中效果的样式
 
 5.XYYDemo5--带有分界线的样式
 
 6.XYYDemo6--带有显示图片的样式
 
 这样示例是为了更快的集成组件，使用过程中有问题欢迎提问
 

## 版本
 ~~1.2.0 ：增加了可以调节字体大小；
         增加了选中字体放大效果;~~
         
 ~~1.3.0 ：
 优化架构；
 增加了新的功能;
 增加了6个demo例子;~~
    
    1.3.1：
    修正了控制器无法dealloc
    修正无法捕获点击事件

## pod 使用
~~pod 'XYYSegmentControl', '~> 0.0.1'~~

~~pod 'XYYSegmentControl', '~> 1.2.0'~~

~~pod 'XYYSegmentControl', '~> 1.3.0'~~

pod 'XYYSegmentControl', '~> 1.3.1'
