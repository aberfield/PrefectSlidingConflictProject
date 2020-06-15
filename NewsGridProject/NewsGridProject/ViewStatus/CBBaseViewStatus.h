//
//  BaseViewStatus.h
//  NewsGridProject
//
//  Created by aberfield on 2020/6/11.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    refresh,
    bindData,
} ViewAction;


@interface CBBaseViewStatus : NSObject

- (instancetype)initWithViewController:(UIViewController*)vc;

@end

NS_ASSUME_NONNULL_END
