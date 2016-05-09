//
//  XYYTableViewController.m
//  XYYSegmentControl
//
//  Created by xuyong on 16/5/9.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "XYYTableViewController.h"
#import "XYYDemo1.h"
#import "XYYDemo2.h"
#import "XYYDemo3.h"
#import "XYYDemo4.h"
#import "XYYDemo5.h"
#import "XYYDemo6.h"


@interface XYYTableViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableview;

@end

@implementation XYYTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"XYYTableViewController";
    [self tableViewLayoutViews];
}

-(void)tableViewLayoutViews{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,0,screen_width,screen_height - 64 ) style:UITableViewStylePlain];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.view addSubview:self.tableview];
}

#pragma mark - 动态cell
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;//默认有3个
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

#pragma mark - tableView Delegate 默认显示
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    cell.textLabel.text = [self contentModule:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row == 0) {
        XYYDemo1 *demo1 = [[XYYDemo1 alloc] init];
        [self.navigationController pushViewController:demo1 animated:YES];
    }else if (row == 1)
    {
        XYYDemo2 *demo2 = [[XYYDemo2 alloc] init];
        [self.navigationController pushViewController:demo2 animated:YES];
    }else if (row == 2)
    {
        XYYDemo3 *demo3 = [[XYYDemo3 alloc] init];
        [self.navigationController pushViewController:demo3 animated:YES];
    }else if (row == 3)
    {
        XYYDemo4 *demo4 = [[XYYDemo4 alloc] init];
        [self.navigationController pushViewController:demo4 animated:YES];
    }else if (row == 4)
    {
        XYYDemo5 *demo5 = [[XYYDemo5 alloc] init];
        [self.navigationController pushViewController:demo5 animated:YES];
    }else if (row == 5)
    {
        XYYDemo6 *demo6 = [[XYYDemo6 alloc] init];
        [self.navigationController pushViewController:demo6 animated:YES];
    }
}

#pragma mark - 内容模块
-(NSString *)contentModule:(NSInteger)row
{
    NSString *content;
    if (row == 0) {
        content = @"XYYDemo1--最常用的样式";
    }else if (row == 1)
    {
        content = @"XYYDemo2--带有字体放大样式（仿网易）";
    }else if (row == 2)
    {
        content = @"XYYDemo3--带有盒子效果的样式";
    }else if (row == 3)
    {
        content = @"XYYDemo4--带有箭头选中效果的样式";
    }else if (row == 4)
    {
        content = @"XYYDemo5--带有分界线的样式";
    }else if (row == 5)
    {
        content = @"XYYDemo6--带有显示图片的样式";
    }
    return content;
}


@end