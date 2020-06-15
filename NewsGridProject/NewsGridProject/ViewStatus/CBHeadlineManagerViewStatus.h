//
//  HeadlineManagerViewStatus.h
//  NewsGridProject
//
//  Created by aberfield on 2020/6/11.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBBaseViewStatus.h"
#import "CBHeadlinePageListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBHeadlineManagerViewStatus : CBBaseViewStatus


@property (nonatomic, strong) CBHeadlinePageListViewController *headlinePageVc;

@end

NS_ASSUME_NONNULL_END
