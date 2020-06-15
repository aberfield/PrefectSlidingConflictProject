
//
//  BaseViewStatus.m
//  NewsGridProject
//
//  Created by aberfield on 2020/6/11.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import "CBBaseViewStatus.h"

@interface CBBaseViewStatus ()

@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation CBBaseViewStatus


- (instancetype)initWithViewController:(UIViewController*)vc {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
