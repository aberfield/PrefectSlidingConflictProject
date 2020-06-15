//
//  CBLearnBarPageViewStatus.m
//  NewsGridProject
//
//  Created by aberfield on 2020/6/15.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import "CBLearnBarPageViewStatus.h"

@interface CBLearnBarPageViewStatus ()

@end

@implementation CBLearnBarPageViewStatus

- (NSMutableArray<NSString*>*)tabTitleList {
    return [[NSMutableArray alloc] initWithArray:@[@"全部",@"产品介绍",@"客户服务",@"APP功能介绍",@"技能提升"]];
}

#pragma mark - Lazy Init
- (NSMutableDictionary*)childVcs {
    if (_childVcs == nil) {
        _childVcs = [[NSMutableDictionary alloc] init];
    }
    return _childVcs;
}


@end
