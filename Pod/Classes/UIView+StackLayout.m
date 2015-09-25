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

- (void)addAutoLayoutSubview:(UIView *)view
{
    view.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:view];
}

- (NSLayoutConstraint *)sl_constraintAligningAttribute:(NSLayoutAttribute)attribute withView:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute multiplier:1.0 constant:0];
}

- (NSLayoutConstraint *)sl_constraintAligningAttribute:(NSLayoutAttribute)attribute withView:(UIView *)view attribute:(NSLayoutAttribute)otherAttribute
{
    return [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:otherAttribute multiplier:1.0 constant:0];
}

- (NSLayoutConstraint *)sl_constraintAligningAttribute:(NSLayoutAttribute)attribute withView:(UIView *)view attribute:(NSLayoutAttribute)otherAttribute plus:(CGFloat)constant
{
    return [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:otherAttribute multiplier:1.0 constant:constant];
}

- (NSLayoutConstraint *)sl_constraintWithSpace:(CGFloat)space followedByView:(UIView *)view isHorizontal:(BOOL)isHorizontal
{
    NSLayoutAttribute leadingAttribute = isHorizontal ? NSLayoutAttributeLeading : NSLayoutAttributeTop;
    NSLayoutAttribute trailingAttribute = isHorizontal ? NSLayoutAttributeTrailing : NSLayoutAttributeBottom;
    
    // view.leading = self.trailing + space
    return [NSLayoutConstraint constraintWithItem:view attribute:leadingAttribute relatedBy:NSLayoutRelationEqual toItem:self attribute:trailingAttribute multiplier:1.0 constant:space];
}

- (NSArray<NSLayoutConstraint *> *)sl_constraintsLayoutEqualToView:(UIView *)view active:(BOOL)active
{
    NSArray *constraints = @[[self sl_constraintAligningAttribute:NSLayoutAttributeLeading withView:view],
                             [self sl_constraintAligningAttribute:NSLayoutAttributeTrailing withView:view],
                             [self sl_constraintAligningAttribute:NSLayoutAttributeTop withView:view],
                             [self sl_constraintAligningAttribute:NSLayoutAttributeBottom withView:view]];
    if (active) {
        for (NSLayoutConstraint *constraint in constraints) {
            constraint.active = true;
        }
    }
    
    return constraints;
}

- (NSArray<NSLayoutConstraint *> *)sl_constraintsForMinimumSize:(CGSize)size active:(BOOL)active
{
    NSMutableArray *constraints = [NSMutableArray array];
    if (size.width >= 0) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size.width]];
    }
    if (size.height >= 0) {
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size.height]];
    }
    if (active) {
        for (NSLayoutConstraint *constraint in constraints) {
            constraint.active = true;
        }
    }
    return constraints;
}

@end

NS_ASSUME_NONNULL_END
