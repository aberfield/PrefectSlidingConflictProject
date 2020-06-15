//
//  ViewController.m
//  NewsGridProject
//
//  Created by 刘芳友 on 2020/6/8.
//  Copyright © 2020 刘芳友. All rights reserved.
//

#import "HeadlinePageListViewController.h"
#import <Masonry/Masonry.h>
#import "NewsManagerViewStatus.h"
#import "NewsViewStatus.h"
#import "CustomTabView.h"

@interface HeadlinePageListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,DiscoverManagerProtocal>

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) CustomTabView* customTabView;

@property (nonatomic, strong) NewsViewStatus *viewStatus;

@end

@implementation HeadlinePageListViewController

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

#pragma mark - Init
- (void)setupSubview {
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCustomTabView];
    [self createCollectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier: NSStringFromClass([UICollectionViewCell class])];
}

- (void)setupData {
    _viewStatus = [[NewsViewStatus alloc] initWithViewController:self];
    [_customTabView bindData:_viewStatus.tabTitleList];
    
    __weak typeof(self) weakSelf = self;
    [_customTabView setSelectCallback:^(NSInteger index, NSString * _Nonnull title) {
        [weakSelf.collectionView setContentOffset:CGPointMake(weakSelf.collectionView.frame.size.width * index, 0) animated:NO];
    }];
}

#pragma mark - NewsManagerProtocal
- (void)bindData:(NSDictionary *)parameter {
    NSLog(@"%@",parameter);
}


#pragma mark - CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewStatus.tabTitleList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

#pragma mark - CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NewsContentViewController *vc = _viewStatus.childVcs[@(indexPath.row)];
    if (vc == nil) {
        vc = [[NewsContentViewController alloc] init];
        [_viewStatus.childVcs setObject:vc forKey:@(indexPath.row)];
    }
    [vc willMoveToParentViewController:self];
    [cell.contentView addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NewsContentViewController *vc = _viewStatus.childVcs[@(indexPath.row)];
    if (vc == nil) { return; }
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
    [_customTabView updateIndex:index];
}


#pragma mark - Lazy View
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
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_customTabView.mas_bottom);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}


- (void)createCustomTabView {
    if (_customTabView != nil)  {
        return;
    }
    _customTabView = [[CustomTabView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:_customTabView];
    [_customTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

@end
