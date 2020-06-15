//
//  NewsContentViewController.m
//  NewsGridProject
//
//  Created by 刘芳友 on 2020/6/10.
//  Copyright © 2020 刘芳友. All rights reserved.
//

#import "HeadlineListViewController.h"
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>

@interface HeadlineListViewController ()<UITableViewDataSource,UITableViewDelegate>

//UI
@property (nonatomic, strong) UITableView* tableView;

@end

@implementation HeadlineListViewController

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
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark Lazy Init
- (void)createTableView {
    if (_tableView != nil) {
        return;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
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


@end
