//
//  HeadlineManagerViewStatus.m
//  NewsGridProject
//
//  Created by aberfield on 2020/6/11.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import "CBHeadlineManagerViewStatus.h"

@implementation CBHeadlineManagerViewStatus

/// 返回HeadlineVC
- (CBHeadlinePageListViewController *)headlinePageVc {
    if (_headlinePageVc != nil)  return _headlinePageVc;
    _headlinePageVc = [[CBHeadlinePageListViewController alloc] init];
    return _headlinePageVc;
}

@end
