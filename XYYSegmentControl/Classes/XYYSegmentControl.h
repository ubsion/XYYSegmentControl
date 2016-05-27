//
//  SZSlideSwitchManager.h
//  xuyong
//
//  Created by xuyong on 15/5/14.
//  Copyright (c) 2015年 TIXA. All rights reserved.
//  @author XuYong, 15-05-14 09:05:01
//  分布式控制器,主要用来多tab显示用，在HMSegmentedControl基础上再封装。欢迎使用，如果你喜欢请关注下，次项目会持续跟新。

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XYYSegmentedControlSelectionStyleTextWidthStripe, // Indicator width will only be as big as the text width
    XYYSegmentedControlSelectionStyleFullWidthStripe, // Indicator width will fill the whole segment
    XYYSegmentedControlSelectionStyleBox,             // A rectangle that covers the whole segment
    XYYSegmentedControlSelectionStyleArrow            // An arrow in the middle of the segment pointing up or down depending on `HMSegmentedControlSelectionIndicatorLocation`
} XYYSegmentedControlSelectionStyle;

typedef enum {
    XYYSegmentedControlSelectionIndicatorLocationUp,
    XYYSegmentedControlSelectionIndicatorLocationDown,
    XYYSegmentedControlSelectionIndicatorLocationNone // No selection indicator
} XYYSegmentedControlSelectionIndicatorLocation;

@protocol XYYSegmentControlDelegate;
@interface XYYSegmentControl : UIView<UIScrollViewDelegate>
{
    UIScrollView                                        *_rootScrollView;                      //主视图
    UIScrollView                                        *_topScrollView;                       //顶部页签视图
    
    CGFloat                                             _userContentOffsetX;
    BOOL                                                _isLeftScroll;                         //是否左滑动
    BOOL                                                _isBuildUI;                            //是否建立了ui
    NSInteger                                           _userSelectedChannelID;                //点击按钮选择名字ID
    
    UIColor                                             *_tabItemNormalColor;                   //正常时tab文字颜色
    UIColor                                             *_tabItemSelectedColor;                 //选中时tab文字颜色
    UIColor                                             *_tabItemNormalBackgroundColor;         //tab背景颜色
    UIColor                                             *_tabItemSelectionIndicatorColor;       //tab被选中横线\box 颜色
    
    CGFloat                                             _tabItemNormalFont;                     //tab字体大小
    CGFloat                                             _tabItemSelectedFont;                   //被选中字体大小
    
    BOOL                                                _verticalDividerEnabled;                //是否有垂直分界线
    UIColor                                             *_verticalDividerColor;                  //垂直分界线颜色
    CGFloat                                             _verticalDividerWidth;                  //垂直分界线宽度

    XYYSegmentedControlSelectionStyle                   _tabSelectionStyle;                      //tab被选中 box 风格
    XYYSegmentedControlSelectionIndicatorLocation       _tabSelectionIndicatorLocation;          //tab被选中 box 风格位置
    
    NSMutableArray                                      *_viewArray;                            //主视图的子视图数组
    
//    UIViewController                                     *_segmentController;
    
}
@property (nonatomic, weak)   id<XYYSegmentControlDelegate>                     segmentControlDelegate;

@property (nonatomic, strong)  UIScrollView                                     *topScrollView;
@property (nonatomic, strong)  UIScrollView                                     *rootScrollView;
@property (nonatomic, assign)  CGFloat                                          userContentOffsetX;
@property (nonatomic, assign)  NSInteger                                        userSelectedChannelID;

@property (nonatomic, strong)  UIColor                                          *tabItemNormalColor;
@property (nonatomic, strong)  UIColor                                          *tabItemSelectedColor;
@property (nonatomic, strong)  UIColor                                          *tabItemNormalBackgroundColor;
@property (nonatomic, strong)  UIColor                                          *tabItemSelectionIndicatorColor;

@property (nonatomic, assign)  CGFloat                                          tabItemNormalFont;
@property (nonatomic, assign)  CGFloat                                          tabItemSelectedFont;

@property (nonatomic, assign)  BOOL                                             verticalDividerEnabled;
@property (nonatomic, strong)  UIColor                                          *verticalDividerColor;
@property (nonatomic, assign)  CGFloat                                          verticalDividerWidth;

@property (nonatomic ,assign)  XYYSegmentedControlSelectionStyle                tabSelectionStyle;
@property (nonatomic ,assign)  XYYSegmentedControlSelectionIndicatorLocation    tabSelectionIndicatorLocation;

@property (nonatomic, strong)  NSMutableArray                                   *viewArray;

@property (nonatomic, strong)  NSMutableArray                                   *channelName; //存放频道名称

@property (nonatomic, weak )   UIViewController                                 *segmentController;


/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI;

/**
 *  @author XuYong, 15-05-15 16:05:14
 *
 *  跳转指定segment
 *
 *  @param index 依次是当前的segmentBar
 */
- (void)changeSlideAtSegmentIndex:(NSInteger)index;

/**
 *  @author XuYong, 15-05-18 14:05:33
 *
 *  初始化
 *
 *  @param frame   框架
 *  @param channel 平台数组
 *
 *  @return 实例化
 */
- (id)initWithFrame:(CGRect)frame channelName:(NSArray *)channel source:(UIViewController *)srcController;

/**
 *  @author XuYong
 *
 *  初始化
 *
 *  @param frame
 *  @param sectionImages         图片
 *  @param sectionSelectedImages 被选中的图片
 *  @return 实例化
 */
- (id)initWithFrame:(CGRect)frame sectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages source:(UIViewController *)srcController;

@end


/**
 *  @author XuYong, 15-05-14 09:05:26
 *
 *  SZSlideSwitchViewDelegate代理方法
 */
@protocol XYYSegmentControlDelegate <NSObject>

@required

/*!
 * @method 顶部tab个数
 * @abstract
 * @discussion
 * @param 本控件
 * @result tab个数
 */
- (NSUInteger)numberOfTab:(XYYSegmentControl *)view;

/*!
 * @method 每个tab所属的viewController
 * @abstract
 * @discussion
 * @param tab索引
 * @result viewController
 */
- (UIViewController *)slideSwitchView:(XYYSegmentControl *)view viewOfTab:(NSUInteger)number;

/*!
 * @method 滑动左边界时传递手势
 * @abstract
 * @discussion
 * @param   手势
 * @result
 */
@optional
- (void)slideSwitchView:(XYYSegmentControl *)view panLeftEdge:(UIPanGestureRecognizer*) panParam;

/*!
 * @method 滑动右边界时传递手势
 * @abstract
 * @discussion
 * @param   手势
 * @result
 */
- (void)slideSwitchView:(XYYSegmentControl *)view panRightEdge:(UIPanGestureRecognizer*) panParam;

/*!
 * @method 点击tab
 * @abstract
 * @discussion
 * @param tab索引
 * @result
 */
- (void)slideSwitchView:(XYYSegmentControl *)view didselectTab:(NSUInteger)number;


@end
