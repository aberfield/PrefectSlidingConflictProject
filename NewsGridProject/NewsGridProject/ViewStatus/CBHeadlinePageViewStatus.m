
//
//  NewsViewStatus.m
//  NewsGridProject
//
//  Created by aberfield on 2020/6/10.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import "CBHeadlinePageViewStatus.h"

@interface CBHeadlinePageViewStatus()

@end

@implementation CBHeadlinePageViewStatus

- (NSMutableArray<NSString*>*)tabTitleList {
    return [[NSMutableArray alloc] initWithArray:@[@"推荐",@"产品",@"用车",@"试点",@"宝典",@"新类"]];
}

- (NSMutableDictionary*)childVcs {
    if (_childVcs == nil) {
        _childVcs = [[NSMutableDictionary alloc] init];
    }
    return _childVcs;
}

@end
