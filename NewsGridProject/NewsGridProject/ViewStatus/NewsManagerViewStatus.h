//
//  NewsManagerViewStatus.h
//  NewsGridProject
//
//  Created by 刘芳友 on 2020/6/9.
//  Copyright © 2020 刘芳友. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    refresh,
    bindData,
} ViewAction;

/// 子控制器Data绑定协议
@protocol DiscoverManagerProtocal <NSObject>


@optional
- (void)bindData:(NSDictionary*)parameter;

@end

typedef void(^ViewStatusCallback)(ViewAction);

@interface DiscoverManagerViewStatus : NSObject

/// 数据绑定回调
@property (nonatomic, copy) ViewStatusCallback callback;
@property (nonatomic, strong) NSMutableArray <UIViewController<DiscoverManagerProtocal>*> *childVcs;

- (instancetype)initWithViewController:(UIViewController*)vc;

@end

NS_ASSUME_NONNULL_END
