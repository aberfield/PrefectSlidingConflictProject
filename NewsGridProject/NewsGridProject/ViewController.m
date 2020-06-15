//
//  ViewController.m
//  NewsGridProject
//
//  Created by 刘芳友 on 2020/6/8.
//  Copyright © 2020 刘芳友. All rights reserved.
//

#import "NewsViewController.h"
#import <Masonry/Masonry.h>

@interface NewsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView* collectionView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}


#pragma mark - Init
- (void)setupSubviews {
    [self createCollectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier: NSStringFromClass([UICollectionViewCell class])];
}


#pragma mark - CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
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
    
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(UIScreen.mainScreen.bounds.size.width, 400);
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
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
}
@end
