//  Copyright © 2015 Bridger Maxwell. All rights reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SLAlignment) {
    SLAlignmentNone,
    
    SLAlignmentLeading,
    SLAlignmentTop = SLAlignmentLeading,
    
    SLAlignmentTrailing,
    SLAlignmentBottom = SLAlignmentTrailing,
    
    SLAlignmentFill,
    
    SLAlignmentCenter
};


@protocol SLStackLayout <NSObject>

/*
 ************************************ Alignment ************************************
 The alignment pulls subviews to the edges of the superview with a certain priority. Use the fill alignment
 to duplicate behavior of UIStackView.
 When you use the center alignment for the major axis of alignment, two hidden subviews are added to either
 side of the subviews to enforce the centering.
 */

// Defaults to SLAlignmentNone, which creates no constraints
- (instancetype)setVerticalAlignment:(SLAlignment)alignment;
@property (nonatomic, readonly) SLAlignment verticalAlignment;

// Defaults to SLAlignmentNone, which creates no constraints
- (instancetype)setHorizontalAlignment:(SLAlignment)alignment;
@property (nonatomic, readonly) SLAlignment horizontalAlignment;

/* This is the priority that all alignment constraints use. It defaults to UILayoutPriorityDefaultHigh. This
 is so views will pull in the aligned direction, but will not override margin constraints (which are required).
 */
- (instancetype)setAlignmentPriority:(UILayoutPriority)priority;
@property (nonatomic, readonly) UILayoutPriority alignmentPriority;


/*
 ************************************ Spacing ************************************
 All subviews will have a required space between them.
 */

// ...[firstSubview]-spacing-[secondSubview]-spacing-[thirdSubview]...
- (instancetype)setSpacing:(CGFloat)spacing;
@property (nonatomic, readonly) CGFloat spacing;

/* This is the priority that all spacing constraints use. It defaults to required. You can make it non-required
 and add additional constraints to create spacing adjustments.
 Another strategy to create variable spacings is to insert invisible spacer views.
 */
- (instancetype)setSpacingPriority:(UILayoutPriority)priority;
@property (nonatomic, readonly) UILayoutPriority spacingPriority;

/*
 ************************************ Margins ************************************
 The margins define a region on the edges of the superview where the subviews will not enter. The subviews
 might not necessarily go up to the margins, depending on the alignment. To guarantee that subviews go all
 the way to the margins use the fill alignment.
 */

// V:|-(>=margin)-[subview]-....
- (instancetype)setTopMargin:(CGFloat)margin;
@property (nonatomic, readonly) CGFloat topMargin;

// V:...[subview]-(>=margin)-|
- (instancetype)setBottomMargin:(CGFloat)margin;
@property (nonatomic, readonly) CGFloat bottomMargin;

// A convenience to set both top and bottom margins.
- (instancetype)setVerticalMargins:(CGFloat)margin;

// H:|-(>=margin)-[subview]
- (instancetype)setLeadingMargin:(CGFloat)margin;
@property (nonatomic, readonly) CGFloat leadingMargin;

// H:[subview]-(>=margin)-|
- (instancetype)setTrailingMargin:(CGFloat)margin;
@property (nonatomic, readonly) CGFloat trailingMargin;

// A convenience to set both leading and trailing margins.
- (instancetype)setHorizontalMargins:(CGFloat)margin;

/* Uses margin layout attributes from the superview for edge constraints where applicable. This is similar
 to UIStackView's property of the same name.
 Defaults to NO.
 */
- (instancetype)setLayoutMarginsRelativeArrangement:(BOOL)layoutMarginsRelativeArrangement;
@property(nonatomic, getter=isLayoutMarginsRelativeArrangement, readonly) BOOL layoutMarginsRelativeArrangement;


@end




@interface SLStackLayoutBase : NSObject

@property (readonly) NSArray<UIView *> *views;
@property (readonly, weak, nullable) UIView * superview;

// Instead of using this directly, use UIView's -addSubviewsWithVerticalLayout: or -addSubviewsWithHorizontalLayout:
// If you do call this directly then all subviews should already be added to the superview. The subviews should all have
// translatesAutoresizingMaskIntoConstraints set to false. It must be called on a subclass.
- (instancetype)initWithViews:(NSArray<UIView *> *)subviews inSuperview:(UIView *)superview;

@end



@interface SLHorizontalStackLayout : SLStackLayoutBase <SLStackLayout>

@end



@interface SLVerticalStackLayout : SLStackLayoutBase <SLStackLayout>

@end


NS_ASSUME_NONNULL_END
