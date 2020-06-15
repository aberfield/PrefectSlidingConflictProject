//
//  NewsViewStatus.h
//  NewsGridProject
//
//  Created by aberfield on 2020/6/10.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBBaseViewStatus.h"
#import "CBHeadlineListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBHeadlinePageViewStatus : CBBaseViewStatus

/// 子视图控制器字典，Key值对应的是CollectionIndex，Value对应NewsContentViewController示例
@property (nonatomic, strong) NSMutableDictionary<NSNumber*,CBHeadlineListViewController*> *childVcs;

/// CustomeTab标题数组
@property (nonatomic, strong) NSMutableArray<NSString*> *tabTitleList;


@end


NS_ASSUME_NONNULL_END
