//
//  CBHeadlineListViewController.h
//  NewsGridProject
//
//  Created by aberfield on 2020/6/10.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GesturePassTableView.h"
NS_ASSUME_NONNULL_BEGIN

/// 滚动回调Block
typedef void(^HeadlineListScrollCallback)(UIScrollView* scrollView);

@interface CBHeadlineListViewController : UIViewController
//UI
@property (nonatomic, strong) GesturePassTableView* tableView;
@property (nonatomic, copy) HeadlineListScrollCallback scrollViewDidScrollCallback;

@end

NS_ASSUME_NONNULL_END
