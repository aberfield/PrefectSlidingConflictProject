//
//  ClickViewController.m
//  NewsGridProject
//
//  Created by aberfield on 2020/6/12.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import "ClickViewController.h"
#import "CBDiscoverManagerViewController.h"

@interface ClickViewController ()

@end

@implementation ClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(200, 200, 100, 40);
    [button setTitle:@"Click Me" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickMe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)clickMe {
    CBDiscoverManagerViewController *vc = [[CBDiscoverManagerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
