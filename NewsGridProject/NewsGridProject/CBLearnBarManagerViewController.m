//
//  CBLearnBarManagerViewController.m
//  NewsGridProject
//
//  Created by aberfield on 2020/6/9.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import "CBLearnBarManagerViewController.h"
#import "CBLearnBarManagerViewStatus.h"
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import "CBDiscoverManagerViewStatus.h"

@interface CBLearnBarManagerViewController ()<UITableViewDataSource,UITableViewDelegate,DiscoverManagerProtocal> {
    BOOL canContentScroll;
    /// 子视图可滚动
    BOOL canChildScroll;
    BOOL isRefreshing;
}
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIScrollView* childScrollView;
/// Data
@property (nonatomic, strong) CBLearnBarManagerViewStatus* viewStatus;

@end

@implementation CBLearnBarManagerViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubview];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    NSLog(@"____%@--release____",NSStringFromClass([self class]));
}

/// 自动下发生命周期到子控制器
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return YES;
}

#pragma mark - Init UI/Data
- (void)setupSubview {
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
}

- (void)setupData {
    canChildScroll = YES;
    canContentScroll = YES;
    
    _viewStatus = [[CBLearnBarManagerViewStatus alloc] initWithViewController: self];
    [_viewStatus.learnPageVc willMoveToParentViewController:self];

    [self addChildViewController:_viewStatus.learnPageVc];
    
    __weak typeof(self) weakSelf = self;
    _viewStatus.learnPageVc.scrollViewDidScrollCallback = ^(UIScrollView * _Nonnull scrollView) {
        [weakSelf subChildScrollViewDidScroll:scrollView];
    };
    _viewStatus.learnPageVc.updateControllerCallback = ^(GesturePassTableView *tableView) {
        tableView.allowGestureEventPassViews = @[weakSelf.tableView];
        weakSelf.childScrollView = tableView;
    };
    [_viewStatus.learnPageVc didMoveToParentViewController:self];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            break;
        case 1:
            break;
        case 2:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
            [cell.contentView addSubview:_viewStatus.learnPageVc.view];
            [_viewStatus.learnPageVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
            return cell;
        }
        default:
            break;
    }
    
    return [[UITableViewCell alloc] init];
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView   heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 60;
        case 1:
            return 80;
        case 2:
            return tableView.frame.size.height;
        default:
            return 0.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 40.f;
        case 1:
            return 40.0f;
        case 2:
            return [CBLearnBarPageListViewController heightOfCustomTab];
        default:
            return 0.0f;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    switch (section) {
        case 0:
            headView.backgroundColor = [UIColor lightGrayColor];
            break;
        case 1:
            headView.backgroundColor = [UIColor darkGrayColor];
            break;
        case 2:
            return _viewStatus.learnPageVc.customTabView;
        default:
            break;
    }
    return headView;
}

#pragma mark - UIScrollViewDelegate

/*
 + 父视图控制器进行刷新
 + 状态：
 + superContentOffY == 0:
     + 向上拉动子视图：父视图向上滚动，滚动到OffsetY == headView，子视图滚动
     + 向下拉动子视图：父视图MJ刷新。
 
 + superContentOffY == headView.origin.y
    + 向下拉动子视图，父试图向下滚动，滚动到SuperContentOffY == 0
    + 向上滚动子视图，子视图上拉加载
 */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != _tableView) return;
    
    CGFloat headFrame = [self headYOfTabledView];
    
    
    if (isRefreshing) {
        _childScrollView.contentOffset = CGPointMake(0, 0);
        return;
    }
    
    if (!canChildScroll) {
        scrollView.contentOffset = CGPointMake(0, headFrame);
    } else {
        if (scrollView.contentOffset.y >= headFrame) {
            scrollView.contentOffset = CGPointMake(0, headFrame);
            canChildScroll = NO;
            canContentScroll = YES;
        }
    }
}

///子视图控制ScrollView偏移
- (void)subChildScrollViewDidScroll:(UIScrollView*)scrollView {
    if (!canContentScroll) {
        isRefreshing = _tableView.contentOffset.y < 0 && scrollView.contentOffset.y <= 0;
        scrollView.contentOffset = CGPointMake(0, 0);
    } else {
        canContentScroll = scrollView.contentOffset.y > 0;
        canChildScroll = scrollView.contentOffset.y <= 0;
    }
}

#pragma mark - NewsManagerProtocal
- (void)bindData:(NSDictionary *)parameter {
    NSLog(@"%@",parameter);
}

#pragma mark Lazy Init
- (void)createTableView {
    if (_tableView != nil) {
        return;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    
    [_tableView.mj_header beginRefreshing];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (CGFloat)headYOfTabledView {
    return [_tableView rectForHeaderInSection:2].origin.y;
}


@end
