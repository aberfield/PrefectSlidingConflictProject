//
//  CBLearnListViewController.m
//  NewsGridProject
//
//  Created by aberfield on 2020/6/15.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import "CBLearnListViewController.h"
#import <Masonry/Masonry.h>

@interface CBLearnListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CBLearnListViewController

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
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_scrollViewDidScrollCallback == nil) return;
    _scrollViewDidScrollCallback(scrollView);
}

#pragma mark Lazy Init
- (void)createTableView {
    if (_tableView != nil) {
        return;
    }
    _tableView = [[GesturePassTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

@end
