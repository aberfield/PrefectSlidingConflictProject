//
//  CBLearnBarPageListViewController.h
//  NewsGridProject
//
//  Created by aberfield on 2020/6/15.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabView.h"
#import "CBHeadlinePageViewStatus.h"

/// 切换ViewController时，需传递TableView去绑定父容器
typedef void(^UpdateControllerCallback)(GesturePassTableView * _Nullable tableView);

NS_ASSUME_NONNULL_BEGIN

@interface CBLearnBarPageListViewController : UIViewController
@property (nonatomic, strong) CustomTabView* customTabView;

/// 子视图滚动便宜回调，需要传递到最外层视图处理
@property (nonatomic, copy) HeadlineListScrollCallback scrollViewDidScrollCallback;
/// 切换子视图控制器时，需要传递TableView对象去绑定父容器
@property (nonatomic, copy) UpdateControllerCallback updateControllerCallback;

/// 单一入口
+ (CGFloat)heightOfCustomTab;
@end

NS_ASSUME_NONNULL_END
