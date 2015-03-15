//
//  HomeViewController.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/7.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIImage+Extension.h"
#import "TitleButton.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setNavigation];
 }

-(void)setNavigation{
    // 左边按钮
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch_os7" highIcon:@"navigationbar_friendsearch_highlighted_os7" target:self action:nil];
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop_os7" highIcon:@"navigationbar_pop_highlighted_os7" target:self action:nil];
    
    //设置中间按钮
    TitleButton *titleBtn=[TitleButton titleButton];
    //设置按钮的大小
    titleBtn.frame=CGRectMake(0, 0, 80, 40);
    //设置标题
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    //设置标题颜色
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.titleView=titleBtn;
    
    //设置右边按钮的图片
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)titleClick:(TitleButton *)titleButton{
    if (titleButton.tag==-1) {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag=0;
    } else {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag=-1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text=@"亦心";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *contro=[[UIViewController alloc]init];
    [self.navigationController pushViewController:contro animated:YES];
}
@end
