//
//  CBLearnBarManagerViewStatus.m
//  NewsGridProject
//
//  Created by aberfield on 2020/6/15.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import "CBLearnBarManagerViewStatus.h"

@implementation CBLearnBarManagerViewStatus

/// 返回学吧List管理页面
- (CBLearnBarPageListViewController *)learnPageVc {
    if (_learnPageVc != nil) return _learnPageVc;
    _learnPageVc = [[CBLearnBarPageListViewController alloc] init];
    return _learnPageVc;
}

@end
