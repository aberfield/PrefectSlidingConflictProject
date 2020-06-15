//
//  NewsManagerViewStatus.h
//  NewsGridProject
//
//  Created by aberfield on 2020/6/9.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBBaseViewStatus.h"

NS_ASSUME_NONNULL_BEGIN

/// 子控制器Data绑定协议
@protocol DiscoverManagerProtocal <NSObject>


@optional
- (void)bindData:(NSDictionary*)parameter;

@end

typedef void(^ViewStatusCallback)(ViewAction);

@interface CBDiscoverManagerViewStatus : CBBaseViewStatus

/// 数据绑定回调
@property (nonatomic, copy) ViewStatusCallback callback;
@property (nonatomic, strong) NSMutableArray <UIViewController<DiscoverManagerProtocal>*> *childVcs;

@end

NS_ASSUME_NONNULL_END
