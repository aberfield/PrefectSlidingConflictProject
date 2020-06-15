//
//  CBLearnBarPageViewStatus.h
//  NewsGridProject
//
//  Created by aberfield on 2020/6/15.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBBaseViewStatus.h"
#import "CBLearnListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBLearnBarPageViewStatus : CBBaseViewStatus

/// 子视图控制器字典，Key值对应的是CollectionIndex，Value对应NewsContentViewController示例
@property (nonatomic, strong) NSMutableDictionary<NSNumber*,CBLearnListViewController*> *childVcs;

/// CustomeTab标题数组
@property (nonatomic, strong) NSMutableArray<NSString*> *tabTitleList;


@end

NS_ASSUME_NONNULL_END
