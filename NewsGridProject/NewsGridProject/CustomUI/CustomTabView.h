//
//  CustomTabView.h
//  NewsGridProject
//
//  Created by aberfield on 2020/6/10.
//  Copyright © 2020 aberfield. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomeSelectCallback)(NSInteger index, NSString*  title);

@interface CustomTabView : UIView

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, copy) CustomeSelectCallback selectCallback;


/// Update Data
- (void)bindData:(NSArray<NSString*>*)titles;
- (void)updateIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
