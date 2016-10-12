//
//  SZSlideSwitchManager.m
//  Lianxi
//
//  Created by admin on 15/5/14.
//  Copyright (c) 2015年 TIXA. All rights reserved.
//

#import "XYYSegmentControl.h"
#import "HMSegmentedControl.h"

static const CGFloat kHeightOfTopScrollView = 44.0f;
static const CGFloat kImagesHeightOfTopScrollView = 54.0f;

@interface XYYSegmentControl()
@property (nonatomic, strong) HMSegmentedControl *hmSegmentedControl;

@property (nonatomic,strong) NSArray *sectionImages;
@property (nonatomic,strong) NSArray *sectionSelectedImages;

@end

@implementation XYYSegmentControl

#pragma mark - 初始化参数
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValues];
    }
    return self;
}

/**
 *  @author XuYong
 *
 *  初始化
 *
 *  @param frame   框架
 *  @param channel 平台数组
 *  @parm  srcController 传不传都无所谓，为了不使用户更新库修改代码，暂且保留该字段。
 *  @return 实例化
 */
- (id)initWithFrame:(CGRect)frame channelName:(NSArray *)channel source:(UIViewController *)srcController
{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewArray       = [[NSMutableArray alloc] init];
        self.channelName     = [channel copy];
        self.segmentController = srcController;
        [self initValues];
    }
    return self;
}

/**
 *  @author XuYong
 *
 *  初始化
 *
 *  @param frame   框架
 *  @param sectionImages 图片数组
 *  @param sectionSelectedImages 被选中的图片数组
 *  @parm  srcController 传不传都无所谓，为了不使用户更新库修改代码，暂且保留该字段。
 *  @return 实例化
 */
- (id)initWithFrame:(CGRect)frame sectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages source:(UIViewController *)srcController
{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewArray       = [[NSMutableArray alloc] init];
        self.sectionImages   = [sectionImages copy];
        self.sectionSelectedImages = [sectionSelectedImages copy];
        //_segmentController 不建议使用
//        _segmentController = srcController;
        [self initImagesValues];
    }
    return self;
}

///初始化
- (void)initValues
{
    [self createTopView];//创建分布式
    [self createRootView];
    _isBuildUI = NO;
}

///初始化图片
- (void)initImagesValues
{
    [self createImageTopView];//创建分布式
    [self createImagesRootView];
    _isBuildUI = NO;
}

-(void)setSegmentControlDelegate:(id<XYYSegmentControlDelegate>)segmentControlDelegate
{
    _segmentControlDelegate = segmentControlDelegate;
    [self buildUI];
}

-(void)setTabItemSelectionIndicatorColor:(UIColor *)tabItemSelectionIndicatorColor
{
    self.hmSegmentedControl.selectionIndicatorColor = tabItemSelectionIndicatorColor;
}

-(void)setTabItemNormalBackgroundColor:(UIColor *)tabItemNormalBackgroundColor
{
    self.hmSegmentedControl.backgroundColor = tabItemNormalBackgroundColor;//[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
}

-(void)setTabItemNormalColor:(UIColor *)tabItemNormalColor
{
    _tabItemNormalColor = tabItemNormalColor;
    self.hmSegmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : tabItemNormalColor} ;//@{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

-(void)setTabItemSelectedColor:(UIColor *)tabItemSelectedColor
{
    _tabItemSelectedColor = tabItemSelectedColor;
    self.hmSegmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : tabItemSelectedColor};//@{NSForegroundColorAttributeName : [UIColor orangeColor]};
}

-(void)setTabSelectionStyle:(XYYSegmentedControlSelectionStyle)tabSelectionStyle
{
    HMSegmentedControlSelectionStyle HMSelectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    if (tabSelectionStyle == HMSegmentedControlSelectionStyleTextWidthStripe)
    {
        HMSelectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        
    }else if (tabSelectionStyle == HMSegmentedControlSelectionStyleFullWidthStripe)
    {
        HMSelectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        
    }else if (tabSelectionStyle == HMSegmentedControlSelectionStyleBox)
    {
        HMSelectionStyle = HMSegmentedControlSelectionStyleBox;
        
    }else if (tabSelectionStyle == HMSegmentedControlSelectionStyleArrow)
    {
        HMSelectionStyle = HMSegmentedControlSelectionStyleArrow;
        
    }
    self.hmSegmentedControl.selectionStyle = HMSelectionStyle;
}

-(void)setTabSelectionIndicatorLocation:(XYYSegmentedControlSelectionIndicatorLocation)tabSelectionIndicatorLocation
{
    HMSegmentedControlSelectionIndicatorLocation selectionIndicatorLocation  = HMSegmentedControlSelectionIndicatorLocationNone;
    if (tabSelectionIndicatorLocation == HMSegmentedControlSelectionIndicatorLocationUp)
    {
        selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationUp;
        
    }else if (tabSelectionIndicatorLocation == HMSegmentedControlSelectionIndicatorLocationDown)
    {
        selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        
    }else if (tabSelectionIndicatorLocation == HMSegmentedControlSelectionIndicatorLocationNone)
    {
        selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
        
    }
    self.hmSegmentedControl.selectionIndicatorLocation = selectionIndicatorLocation;
}

-(void)setTabItemNormalFont:(CGFloat)fontSize
{
    if (_tabItemNormalColor) {
        //设置了tab颜色
        self.hmSegmentedControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName : _tabItemNormalColor};
    }else
    {
        self.hmSegmentedControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    }
}

-(void)setTabItemSelectedFont:(CGFloat)fontSize
{
    if (_tabItemSelectedColor) {
        //设置了tab颜色
        self.hmSegmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName : _tabItemSelectedColor};
    }else
    {
        self.hmSegmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    }
}

-(void)setVerticalDividerEnabled:(BOOL)verticalDividerEnabled
{
    self.hmSegmentedControl.verticalDividerEnabled = verticalDividerEnabled;
    if (verticalDividerEnabled) {
        self.hmSegmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 20, 0, 20);
    }
}

-(void)setVerticalDividerColor:(UIColor *)verticalDividerColor
{
    self.hmSegmentedControl.verticalDividerColor = verticalDividerColor;
}

-(void)setVerticalDividerWidth:(CGFloat)verticalDividerWidth
{
    self.hmSegmentedControl.verticalDividerWidth = verticalDividerWidth;
}

#pragma mark - views
/**
 *创建标签页
 */
-(void)createTopView
{
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    self.hmSegmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, viewWidth, kHeightOfTopScrollView)];
//    self.hmSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.hmSegmentedControl.sectionTitles = _channelName;
    self.hmSegmentedControl.selectedSegmentIndex = 0;
    //默认colors
    self.hmSegmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
    self.hmSegmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.hmSegmentedControl.backgroundColor = [UIColor whiteColor];
    self.hmSegmentedControl.selectionIndicatorColor = [UIColor redColor];
    //默认style
    self.hmSegmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.hmSegmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    [self addSubview:self.hmSegmentedControl];
    
    __weak typeof(self) weakSelf = self;
    [self.hmSegmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf segmentClicked:index];
    }];
}

/**
 *创建根视图
 */
-(void)createRootView
{
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView , self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [self addSubview:_rootScrollView];
}

/**
 *创建带有图片的标签页
 */
-(void)createImageTopView
{
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    NSMutableArray *sectionImagesArray = [[NSMutableArray alloc] init];
    [self.sectionImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [sectionImagesArray addObject:[UIImage imageNamed:self.sectionImages[idx]]];
    }];
    NSMutableArray *sectionSelectedImagesArray = [[NSMutableArray alloc] init];
    [self.sectionSelectedImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [sectionSelectedImagesArray addObject:[UIImage imageNamed:self.sectionSelectedImages[idx]]];
    }];
    
    // Segmented control with images
    self.hmSegmentedControl  = [[HMSegmentedControl alloc] initWithSectionImages:sectionImagesArray
                                                           sectionSelectedImages:sectionSelectedImagesArray];
    self.hmSegmentedControl.frame = CGRectMake(0, 0, viewWidth, kImagesHeightOfTopScrollView);
//    self.hmSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.hmSegmentedControl.sectionTitles = _channelName;
    self.hmSegmentedControl.selectedSegmentIndex = 0;
    //默认colors
    self.hmSegmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
    self.hmSegmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.hmSegmentedControl.backgroundColor = [UIColor whiteColor];
    self.hmSegmentedControl.selectionIndicatorColor = [UIColor redColor];
    //默认style
    self.hmSegmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.hmSegmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    [self addSubview:self.hmSegmentedControl];
    
    __weak typeof(self) weakSelf = self;
    [self.hmSegmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf segmentClicked:index];
    }];
}

/**
 *创建带有图片的根视图
 */
-(void)createImagesRootView
{
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kImagesHeightOfTopScrollView , self.bounds.size.width, self.bounds.size.height - kImagesHeightOfTopScrollView)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [self addSubview:_rootScrollView];
}


/**
 *  @author XuYong, 15-05-15 16:05:14
 *
 *  跳转指定segment
 *
 *  @param index 依次是当前的segmentBar
 */
-(void)changeSlideAtSegmentIndex:(NSInteger)index
{
    [self segmentClicked:index];
    [self.hmSegmentedControl setSelectedSegmentIndex:index animated:YES];
}

#pragma mark - 创建控件
/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI
{
    NSUInteger number = [self.segmentControlDelegate numberOfTab:self];
    for (int i=0; i<number; i++) {
        UIViewController *vc = [self.segmentControlDelegate slideSwitchView:self viewOfTab:i];
        [_viewArray addObject:vc];
        [_rootScrollView addSubview:vc.view];
        [self.segmentController addChildViewController:vc];
    }
    _isBuildUI = YES;
    //选中第一个view
    if (self.segmentControlDelegate && [self.segmentControlDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.segmentControlDelegate slideSwitchView:self didselectTab:_userSelectedChannelID ];
    }
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
}

//当横竖屏切换时可通过此方法调整布局
- (void)layoutSubviews
{
    //创建完子视图UI才需要调整布局
    if (_isBuildUI) {
        //更新主视图的总宽度
        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewArray count], 0);
        
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(0+_rootScrollView.bounds.size.width*i, 0,
                                           _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
        }
        //滚动到选中的视图
        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID )*self.bounds.size.width, 0) animated:NO];
    }
}


#pragma mark - 顶部滚动视图逻辑方法
- (void)segmentClicked:(NSInteger)index
{
    [self.rootScrollView setContentOffset:CGPointMake(index * self.bounds.size.width, 0) animated:NO];
    if (self.segmentControlDelegate && [self.segmentControlDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.segmentControlDelegate slideSwitchView:self didselectTab:index];
    }
    _userSelectedChannelID = index;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark 主视图逻辑方法
//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;
    }
}
//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        //判断用户是否左滚动还是右滚动
        if (_userContentOffsetX < scrollView.contentOffset.x) {
            _isLeftScroll = YES;
        }
        else {
            _isLeftScroll = NO;
        }
    }
}
//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        //调整顶部滑条按钮状态
        int index = (int)scrollView.contentOffset.x/self.bounds.size.width ;
        [self.hmSegmentedControl setSelectedSegmentIndex:index animated:YES];
        [self segmentClicked:index];
    }
}

////传递滑动事件给下一层
//-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
//{
//    //当滑道左边界时，传递滑动事件给代理
//    if(_rootScrollView.contentOffset.x <= 0) {
//        if (self.slideSwitchViewDelegate
//            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)]) {
//            [self.slideSwitchViewDelegate slideSwitchView:self panLeftEdge:panParam];
//        }
//    } else if(_rootScrollView.contentOffset.x >= _rootScrollView.contentSize.width - _rootScrollView.bounds.size.width) {
//        if (self.slideSwitchViewDelegate
//            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)]) {
//            [self.slideSwitchViewDelegate slideSwitchView:self panRightEdge:panParam];
//        }
//    }
//}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
