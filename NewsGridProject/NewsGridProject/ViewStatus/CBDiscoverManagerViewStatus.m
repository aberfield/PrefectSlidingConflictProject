//
//  NewsManagerViewStatus.m
//  NewsGridProject
//
//  Created by aberfield on 2020/6/9.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import "CBDiscoverManagerViewStatus.h"
#import "CBHeadlineManagerViewController.h"
#import "CBLearnBarManagerViewController.h"

@interface CBDiscoverManagerViewStatus()

@end

@implementation CBDiscoverManagerViewStatus

- (instancetype)initWithViewController:(UIViewController *)vc {
    self = [super initWithViewController:vc];
    if (self) {
        [self initChildrenViewController];
    }
    return  self;
}

- (void)initChildrenViewController {
    self.childVcs = [[NSMutableArray alloc] init];
    CBHeadlineManagerViewController *newsVc = [[CBHeadlineManagerViewController alloc] init];
    CBLearnBarManagerViewController *headlinesVc = [[CBLearnBarManagerViewController alloc] init];
    [self.childVcs addObject: (UIViewController<DiscoverManagerProtocal>*)newsVc];
    [self.childVcs addObject: (UIViewController<DiscoverManagerProtocal>*)headlinesVc];
}



@end
