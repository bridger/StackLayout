//  Copyright © 2015 Bridger Maxwell. All rights reserved.

#import <UIKit/UIKit.h>
#import "SLStackLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SLStackLayout)

- (SLHorizontalStackLayout *)addSubviewsWithHorizontalLayout:(NSArray<UIView *> *)subviews;
- (SLVerticalStackLayout *)addSubviewsWithVerticalLayout:(NSArray<UIView *> *)subviews;

// Same as addSubview:, but it sets translatesAutoresizingMaskIntoConstraints = false on the subview first.
- (void)addAutoLayoutSubview:(UIView *)view;

- (NSLayoutConstraint *)sl_constraintAligningAttribute:(NSLayoutAttribute)attribute withView:(UIView *)view;
- (NSLayoutConstraint *)sl_constraintAligningAttribute:(NSLayoutAttribute)attribute withView:(UIView *)view attribute:(NSLayoutAttribute)otherAttribute;
- (NSLayoutConstraint *)sl_constraintAligningAttribute:(NSLayoutAttribute)attribute withView:(UIView *)view attribute:(NSLayoutAttribute)otherAttribute plus:(CGFloat)constant;

// Returns a constraint [self]-space-[view], using either Leading/Trailing or Top/Bottom
// view.leading = self.trailing + space
- (NSLayoutConstraint *)sl_constraintWithSpace:(CGFloat)space followedByView:(UIView *)view isHorizontal:(BOOL)isHorizontal;

// Returns 4 constraints to align the leading, trailing, top, and bottom to another view. If active is true
// the constraints are set to be active.
- (NSArray<NSLayoutConstraint *> *)sl_constraintsLayoutEqualToView:(UIView *)view active:(BOOL)active;

// Creates constraints that width >= size.width and height >= size.height. If size.width or size.height < 0
// then the corresponding constraint will not be created. If active is true the constraints are set to be active.
- (NSArray<NSLayoutConstraint *> *)sl_constraintsForMinimumSize:(CGSize)size active:(BOOL)active;

@end

NS_ASSUME_NONNULL_END
