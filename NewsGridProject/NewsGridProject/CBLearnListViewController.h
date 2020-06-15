//
//  CBLearnListViewController.h
//  NewsGridProject
//
//  Created by aberfield on 2020/6/15.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GesturePassTableView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^LearnListScrollCallback)(UIScrollView* scrollView);


@interface CBLearnListViewController : UIViewController
//UI
@property (nonatomic, strong) GesturePassTableView* tableView;
@property (nonatomic, copy) LearnListScrollCallback scrollViewDidScrollCallback;

@end

NS_ASSUME_NONNULL_END
