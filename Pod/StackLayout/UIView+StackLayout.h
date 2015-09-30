//  Copyright © 2015 Bridger Maxwell. All rights reserved.

#import <UIKit/UIKit.h>
#import "SLStackLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SLStackLayout)

- (SLHorizontalStackLayout *)addSubviewsWithHorizontalLayout:(NSArray<UIView *> *)subviews;
- (SLVerticalStackLayout *)addSubviewsWithVerticalLayout:(NSArray<UIView *> *)subviews;

- (void)removeSubviewsInLayout:(SLStackLayoutBase *)layout;

@end

NS_ASSUME_NONNULL_END
