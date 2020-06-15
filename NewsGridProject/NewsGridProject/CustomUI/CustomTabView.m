//
//  CustomTabView.m
//  NewsGridProject
//
//  Created by aberfield on 2020/6/10.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import "CustomTabView.h"
#import <Masonry/Masonry.h>

#define LabelTag 100

@interface CustomTabView()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger selectIndex;
    NSIndexPath *lastIndexPath;
}
/// UI
@property (nonatomic, strong) UICollectionView *collectionView;

/// Data
/// 显示的Title列表
@property (nonatomic, strong) NSMutableArray<NSString *>* titles;

@end

@implementation CustomTabView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubview];
    }
    return self;
}

#pragma mark - Init UI/Data
- (void)setupSubview {
    _padding = 20;
    selectIndex = 0;
    [self createCollectionView];
}


#pragma mark - Update Data
- (void)bindData:(NSArray<NSString*>*)titles {
    self.titles = [[NSMutableArray alloc] initWithArray:titles];
    [_collectionView reloadData];
}

/// 滑动ScrollView更新索引
- (void)updateIndex:(NSInteger)index {
    if (selectIndex == index) return;
    [self setSelectIndexCell:index];
}

#pragma mark - CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = indexPath.row == selectIndex ? [UIColor blueColor] : [UIColor lightGrayColor];
    label.tag = LabelTag;
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(cell.contentView);
    }];
    [label sizeToFit];
    label.text = _titles[indexPath.row];
    
    if (selectIndex == indexPath.row) {
        lastIndexPath = indexPath;
    }
    
    return cell;
}

#pragma mark - CollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *labelTitle = _titles[indexPath.row];
    CGRect rect = [labelTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, _collectionView.frame.size.height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    return CGSizeMake(rect.size.width + 2*_padding , _collectionView.frame.size.height);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.row == selectIndex) return;
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *label = [cell.contentView viewWithTag:LabelTag];
    
    [self setSelectIndexCell:indexPath.row];
    /// 点击回调
    if (_selectCallback != nil) {
        _selectCallback(selectIndex,label.text);
    }
}


- (void)setSelectIndexCell:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    if (lastIndexPath != nil) {
        UICollectionViewCell *lastCell = [_collectionView cellForItemAtIndexPath:lastIndexPath];
        UILabel *lastLabel = [lastCell.contentView viewWithTag:LabelTag];
        lastLabel.textColor = [UIColor lightGrayColor];
    }
    
    UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
    UILabel *label = [cell.contentView viewWithTag:LabelTag];
    label.textColor = [UIColor blueColor];
    
    lastIndexPath = indexPath;
    selectIndex = indexPath.row;
    
    /// 计算_collectionView的偏移量
    CGFloat offsetx = cell.frame.origin.x - _collectionView.frame.size.width / 2;
    CGFloat maxOffsetx = _collectionView.contentSize.width - _collectionView.frame.size.width;
    if (offsetx > maxOffsetx) {
        offsetx = maxOffsetx;
    }
    if (offsetx < 0) {
        offsetx = 0;
    }
    [_collectionView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
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
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
}

- (NSMutableArray<NSString *> *)titles {
    if (_titles == nil) {
        return [[NSMutableArray alloc] init];
    }
    return _titles;
}


@end
