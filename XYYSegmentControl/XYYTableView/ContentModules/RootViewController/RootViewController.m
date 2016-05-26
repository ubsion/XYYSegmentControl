//
//  RootViewController.m
//  SegmentDemo
//
//  Created by xuyong on 16/4/27.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property (nonatomic,strong) UILabel  *contentLabel;
@property (nonatomic,strong) UIButton *skipButton;

@end

@implementation RootViewController

-(void)dealloc
{
    NSLog(@"RootViewController dealloc--");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.skipButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///加载数据
-(void)rootLoadData:(NSInteger)index
{
    self.contentLabel.text = [NSString stringWithFormat:@"当前页面index是%ld",(long)index];
    self.view.backgroundColor = [self randomColor];
}

//随机颜色
-(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
#pragma mark - setter/getter
-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 400, 100)];
        _contentLabel.textColor = [UIColor redColor];
        _contentLabel.font = [UIFont systemFontOfSize:24];
    }
    return _contentLabel;
}

-(UIButton *)skipButton
{
    if (!_skipButton) {
        _skipButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 400, 100)];
        [_skipButton setTitle:@"点我跳转" forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(skipButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}

-(void)skipButtonClick:(UIButton *)button
{
    RootViewController *nextview = [[RootViewController alloc] init];
    nextview.title = @"nextview";
    [self.navigationController pushViewController:nextview animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
