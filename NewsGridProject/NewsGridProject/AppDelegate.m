//
//  AppDelegate.m
//  NewsGridProject
//
//  Created by aberfield on 2020/6/8.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import "AppDelegate.h"
#import "CBDiscoverManagerViewController.h"
#import "ClickViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
//    DiscoverManagerViewController *newsManagerVC = [[DiscoverManagerViewController alloc] init];
    ClickViewController *vc = [[ClickViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:navigation];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
