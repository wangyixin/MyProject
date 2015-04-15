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
#import "AFNetworking.h"
#import "UserPerfenceUtil.h"
#import "Account.h"
#import "Status.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "User.h"
#import "StatusViewCell.h"
#import "StatusFrame.h"
#import "MJRefresh.h"
#import "UserPerfenceUtil.h"
#import "HttpUtil.h"
#import "HomeStatusService.h"


@interface HomeViewController()<MJRefreshBaseViewDelegate>
@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setNavigation];
    
    //集成刷新控件
    [self initRefreshView];
 }

/**
 *  集成刷新控件
 */
-(void)initRefreshView{
    //下拉刷新
    MJRefreshHeaderView *header=[MJRefreshHeaderView header];
    header.scrollView=self.tableView;
    header.delegate=self;
    self.header=header;
    //自动进入刷新状态
    [header beginRefreshing];
    
    //上拉加载更多
    MJRefreshFooterView *footer=[MJRefreshFooterView footer];
    footer.scrollView=self.tableView;
    footer.delegate=self;
    self.footer=footer;
}

/**
 *  刷新控件进入开始刷新状态的时候调用
 */
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        [self getNewData];
    }else{
        [self getMoreData];
    }
}

/**
 *  获取更多数据
 */

-(void)getMoreData{
    // 1.封装请求参数
    HomeRequest *request=[HomeRequest request];
    if (self.statusFrames.count) {
        StatusFrame *stautsFrame=[self.statusFrames lastObject];
        long long maxId=[stautsFrame.status.idstr longLongValue]-1;
        request.max_id=@(maxId);
    }
    
    [HomeStatusService getHomeStatusDataWith:request success:^(HomeResponse *response) {
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (Status *status in response.statuses) {
            StatusFrame *statusFrame = [[StatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }

        // 添加新数据到旧数据的后面
        [self.statusFrames addObjectsFromArray:statusFrameArray];

        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];

    } failure:^(NSError *error) {
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
    }];
}

/**
 *  // 刷新数据(向新浪获取更新的微博数据)
 */

-(void)getNewData{
    HomeRequest *request=[HomeRequest request];
    request.count=@(5);
    if (self.statusFrames.count) {
        StatusFrame *statusFrame = self.statusFrames[0];
        // 加载ID比since_id大的微博
        request.since_id=@([statusFrame.status.idstr longLongValue]);
    }
    
    [HomeStatusService getHomeStatusDataWith:request success:^(HomeResponse *response) {
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (Status *status in response.statuses) {
            StatusFrame *statusFrame = [[StatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 将最新的数据追加到旧数据的最前面
        // 旧数据: self.statusFrames
        // 新数据: statusFrameArray
        NSMutableArray *tempArray = [NSMutableArray array];
        // 添加statusFrameArray的所有元素 添加到 tempArray中
        [tempArray addObjectsFromArray:statusFrameArray];
        // 添加self.statusFrames的所有元素 添加到 tempArray中
        [tempArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
        
        // 显示最新微博的数量(给用户一些友善的提示)
        [self showNewStatusCount:(int)statusFrameArray.count];
    } failure:^(NSError *error) {
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    }];
}

-(void)showNewStatusCount:(int)count{
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    // below : 下面  btn会显示在self.navigationController.navigationBar的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.设置图片和文字
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条新的微博", count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    
    // 3.设置按钮的初始frame
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnX = 2;
    CGFloat btnW = self.view.frame.size.width - 2 * btnX;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    // 4.通过动画移动按钮(按钮向下移动 btnH + 1)
    [UIView animateWithDuration:0.7 animations:^{
        
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
        
    } completion:^(BOOL finished) { // 向下移动的动画执行完毕后
        
        // 建议:尽量使用animateWithDuration, 不要使用animateKeyframesWithDuration
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 将btn从内存中移除
            [btn removeFromSuperview];
        }];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StatusViewCell *cell=[StatusViewCell cellWithTableView:tableView];
    
    cell.statusFrame=self.statusFrames[indexPath.row];
    
    return cell;
}


#pragma 设置导航栏
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
    
    //设置TableView的背景颜色
    self.tableView.backgroundColor=MyColor(226, 226, 226);
    //增加TableView底部可滚动的范围
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, kCellMargin, 0);
    //去除cell的分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

#pragma 中间按钮的点击事件
-(void)titleClick:(TitleButton *)titleButton{
    if (titleButton.tag==-1) {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag=0;
    } else {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag=-1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusFrame *statuFrame=self.statusFrames[indexPath.row];
    return statuFrame.cellHeight;
}

-(NSMutableArray *)statusFrames{
    if (_statusFrames==nil) {
        _statusFrames=[NSMutableArray array];
    }
    return _statusFrames;
}

-(void)dealloc{
    [self.header free];
    [self.footer free];
}
@end
