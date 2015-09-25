//  Copyright © 2015 Bridger Maxwell. All rights reserved.

#import "UIView+StackLayout.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIView (SLStackLayout)

- (SLHorizontalStackLayout *)addSubviewsWithHorizontalLayout:(NSArray<UIView *> *)subviews
{
    for (UIView *subview in subviews) {
        subview.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:subview];
    }
    return [[SLHorizontalStackLayout alloc] initWithViews:subviews inSuperview:self];
}

- (SLVerticalStackLayout *)addSubviewsWithVerticalLayout:(NSArray<UIView *> *)subviews
{
    for (UIView *subview in subviews) {
        subview.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:subview];
    }
    return [[SLVerticalStackLayout alloc] initWithViews:subviews inSuperview:self];
}

@end

NS_ASSUME_NONNULL_END
