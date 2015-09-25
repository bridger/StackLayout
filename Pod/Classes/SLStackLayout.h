//  Copyright © 2015 Bridger Maxwell. All rights reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ALAlignment) {
    ALAlignmentNone,
    
    ALAlignmentLeading,
    ALAlignmentTop = ALAlignmentLeading,
    
    ALAlignmentTrailing,
    ALAlignmentBottom = ALAlignmentTrailing,
    
    ALAlignmentFill,
    
    ALAlignmentCenter
};



@interface SLStackLayout : NSObject

@property (readonly) NSArray<UIView *> *views;
@property (readonly, weak, nullable) UIView * superview;

// ...[firstSubview]-spacing-[secondSubview]-spacing-[thirdSubview]...
- (instancetype)setSpacing:(CGFloat)spacing;
@property (nonatomic, readonly) CGFloat spacing;

/* This is the priority that all alignment constraints use. It defaults to UILayoutPriorityDefaultHigh. This
 is so views will pull in the aligned direction, but will not override margin constraints (which are required).
 */
- (instancetype)setAlignmentPriority:(UILayoutPriority)priority;
@property (nonatomic, readonly) UILayoutPriority alignmentPriority;

/* Uses margin layout attributes from the superview for edge constraints where applicable. This is similar
 to UIStackView.
 Defaults to NO.
 */
- (instancetype)setLayoutMarginsRelativeArrangement:(BOOL)layoutMarginsRelativeArrangement;
@property(nonatomic, getter=isLayoutMarginsRelativeArrangement, readonly) BOOL layoutMarginsRelativeArrangement;

// Instead of using this directly, use UIView's -addSubviewsWithVerticalLayout: or -addSubviewsWithHorizontalLayout:
// If you do call this directly then all subviews should already be added to the superview. The subviews should all have
// translatesAutoresizingMaskIntoConstraints set to false. It must be called on a subclass.
- (instancetype)initWithViews:(NSArray<UIView *> *)subviews inSuperview:(UIView *)superview;

@end





@interface SLHorizontalStackLayout : SLStackLayout

// Defaults to ALAlignmentNone, which creates no constraints
- (instancetype)setHorizontalAlignment:(ALAlignment)alignment;
@property (nonatomic, readonly) ALAlignment horizontalAlignment;

// Defaults to ALAlignmentNone, which creates no constraints
- (instancetype)setVerticalAlignment:(ALAlignment)alignment;
@property (nonatomic, readonly) ALAlignment verticalAlignment;

// H:|-margin-[firstSubview]-....
- (instancetype)setLeadingMargin:(CGFloat)margin;
@property (nonatomic, readonly) CGFloat leadingMargin;

// H:...[lastSubview]-margin-|
- (instancetype)setTrailingMargin:(CGFloat)margin;
@property (nonatomic, readonly) CGFloat trailingMargin;

// V:|-margin-[firstSubview]
// V:|-margin-[secondSubview]
// ...
- (instancetype)setTopMargin:(CGFloat)margin;
@property (nonatomic, readonly) CGFloat topMargin;

// V:[firstSubview]-margin-|
// V:[secondSubview]-margin-|
// ...
- (instancetype)setBottomMargin:(CGFloat)margin;
@property (nonatomic, readonly) CGFloat bottomMargin;

@end






@interface SLVerticalStackLayout : SLStackLayout

// Defaults to ALAlignmentNone, which creates no constraints
- (instancetype)setVerticalAlignment:(ALAlignment)alignment;
@property (nonatomic, readonly) ALAlignment verticalAlignment;

// Defaults to ALAlignmentNone, which creates no constraints
- (instancetype)setHorizontalAlignment:(ALAlignment)alignment;
@property (nonatomic, readonly) ALAlignment horizontalAlignment;

// V:|-margin-[firstSubview]-....
- (instancetype)setTopMargin:(CGFloat)margin;
@property (nonatomic, readonly) CGFloat topMargin;

// V:...[lastSubview]-margin-|
- (instancetype)setBottomMargin:(CGFloat)margin;
@property (nonatomic, readonly) CGFloat bottomMargin;

// H:|-margin-[firstSubview]
// H:|-margin-[secondSubview]
// ...
- (instancetype)setLeadingMargin:(CGFloat)margin;
@property (nonatomic, readonly) CGFloat leadingMargin;

// H:[firstSubview]-margin-|
// H:[secondSubview]-margin-|
// ...
- (instancetype)setTrailingMargin:(CGFloat)margin;
@property (nonatomic, readonly) CGFloat trailingMargin;

@end


NS_ASSUME_NONNULL_END
