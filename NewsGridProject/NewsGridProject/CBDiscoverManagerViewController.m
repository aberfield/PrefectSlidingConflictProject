
//
//  CBDiscoverManagerViewController.m
//  NewsGridProject
//
//  Created by aberfield on 2020/6/9.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import "CBDiscoverManagerViewController.h"
#import <Masonry/Masonry.h>
#import "CBDiscoverManagerViewStatus.h"

@interface CBDiscoverManagerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

//UI
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *headlineButton;
@property (nonatomic, strong) UIButton *learnBarButton;

//Data
@property (nonatomic, strong) CBDiscoverManagerViewStatus *viewStatus;

@end

@implementation CBDiscoverManagerViewController

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
    [self createCollectionView];
    self.navigationItem.titleView = [self titleView];
    self.view.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier: NSStringFromClass([UICollectionViewCell class])];
}

- (void)setupData {
    _viewStatus = [[CBDiscoverManagerViewStatus alloc] initWithViewController:self];
    __weak typeof(self) weakSelf = self;
    _viewStatus.callback = ^(ViewAction action) {
        switch (action) {
            case refresh:
                [weakSelf bindData];
                break;
            case bindData:
                break;
        }
    };
}

#pragma mark - Action
- (void)bindData {
    if ([_viewStatus.childVcs.firstObject respondsToSelector:@selector(bindData:)]) {
        [_viewStatus.childVcs.firstObject bindData:@{@"test":@"数据下发"}];
    }
}


/// 顶部Button状态变更
/// @param button 选中Button
- (void)titleButtonAction:(UIButton*)button {
    if (button.isSelected) return;
    [self updateButtonStatus:button];
    [self updateCollectionViewOffset:button == _headlineButton ? 0 : 1];
}

- (void)updateButtonStatus:(UIButton*)button {
    [_learnBarButton setSelected:NO];
    [_headlineButton setSelected:NO];
    [button setSelected:YES];
}

- (void)updateCollectionViewOffset:(NSInteger)index {
    [_collectionView setContentOffset:CGPointMake(_collectionView.frame.size.width * index, 0) animated:NO];
}

#pragma mark - CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewStatus.childVcs.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = _viewStatus.childVcs[indexPath.row];
    [vc willMoveToParentViewController:self];
    [cell.contentView addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = _viewStatus.childVcs[indexPath.row];
    [vc.view mas_remakeConstraints:^(MASConstraintMaker *make) {}];
    [vc removeFromParentViewController];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_collectionView.frame.size.width, _collectionView.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView != _collectionView || _collectionView.frame.size.width == 0) {
        return;
    }
    
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger index =  offset / _collectionView.frame.size.width ;
    UIButton *button = index == 0 ? _headlineButton : _learnBarButton;
    [self updateButtonStatus:button];
}



#pragma mark - Lazy Init
- (void)createCollectionView {
    if (_collectionView != nil) {
        return;
    }
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.pagingEnabled  = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.left.right.equalTo(self.view);
    }];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}

- (UIView*)titleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 6, 140, 32)];
    
    UIButton *newsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newsBtn.frame = CGRectMake(0, 0, 70, 32);
    [newsBtn setTitle:@"头条" forState:UIControlStateNormal];
    [newsBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [newsBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [newsBtn addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _headlineButton = newsBtn;
    [_headlineButton setSelected:YES];
    [titleView addSubview:newsBtn];

    
    UIButton *headlineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headlineBtn.frame = CGRectMake(70, 0, 70, 32);
    [headlineBtn setTitle:@"学吧" forState:UIControlStateNormal];
    [headlineBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [headlineBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [headlineBtn addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _learnBarButton = headlineBtn;
    [titleView addSubview:headlineBtn];

    return titleView;
}


@end
