//  Copyright © 2015 Bridger Maxwell. All rights reserved.

#import <UIKit/UIKit.h>
#import "SLStackLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SLStackLayout)

/*
 These methods add an array of views as subviews and sets translatesAutoresizingMaskIntoConstraints to false
 on each of them. It returns the resulting layout object.
 You can optionally get a reference to the layout object in the configuration block. This is a chance to
 change the layout parameters before any constraints are created. This is also a conveniently lexically-scoped
 place to modify properties on a layout object you don't need a reference to afterwards.
*/

- (SLHorizontalStackLayout *)addSubviewsWithHorizontalLayout:(NSArray<UIView *> *)subviews;
- (SLHorizontalStackLayout *)addSubviewsWithHorizontalLayout:(NSArray<UIView *> *)subviews configurationBlock:(void (^__nullable __attribute__((noescape)))(SLHorizontalStackLayout *layout))configurationBlock;

- (SLVerticalStackLayout *)addSubviewsWithVerticalLayout:(NSArray<UIView *> *)subviews;
- (SLVerticalStackLayout *)addSubviewsWithVerticalLayout:(NSArray<UIView *> *)subviews configurationBlock:(void (^__nullable __attribute__((noescape)))(SLVerticalStackLayout *layout))configurationBlock;

- (void)removeSubviewsInLayout:(SLStackLayoutBase *)layout;

@end

NS_ASSUME_NONNULL_END
