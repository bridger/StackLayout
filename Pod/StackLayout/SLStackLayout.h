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

#pragma mark Alignment
/*
 The alignment pulls subviews to be flush with the margin constraints. Use the fill alignment
 to duplicate behavior of UIStackView.
 When centering is used it respects the centeringAlignmentPriority.
 When you use the center alignment for the major axis of alignment, a hidden subview is added to
 help with the centering.
 */

// Defaults to SLAlignmentNone, which creates no constraints
- (instancetype)setVerticalAlignment:(SLAlignment)alignment;
@property (nonatomic, readonly) SLAlignment verticalAlignment;

// Defaults to SLAlignmentNone, which creates no constraints
- (instancetype)setHorizontalAlignment:(SLAlignment)alignment;
@property (nonatomic, readonly) SLAlignment horizontalAlignment;

/* 
 This is the priority for constraints used for centering views with SLAlignmentCenter. It defaults to
 UILayoutPriorityDefaultHigh + 10.
 */
- (instancetype)setCenteringAlignmentPriority:(UILayoutPriority)priority;
@property (nonatomic, readonly) UILayoutPriority centeringAlignmentPriority;

#pragma mark Spacing
/*
 All subviews will have a required space between them.
 */

/*
 ...[firstSubview]-spacing-[secondSubview]-spacing-[thirdSubview]...
 Set the spacing between all pairs of adjacent subviews. This will override any previous calls to
 setSpacing:between:and:
 */
- (instancetype)setSpacing:(CGFloat)spacing;
@property (nonatomic, readonly) CGFloat spacing;

/* This is the priority that all spacing constraints use. It defaults to required. You can make it non-required
 and add additional constraints to create spacing adjustments.
 Another strategy to create variable spacings is to insert invisible spacer views.
 */
- (instancetype)setSpacingPriority:(UILayoutPriority)priority;
@property (nonatomic, readonly) UILayoutPriority spacingPriority;

/*
 Set the space constraint between two adjacent views. [firstView]-spacing-[secondView]
 If firstView and secondView are not adjacent then this will raise an exception.
 When setSpacing: is called, any view spacings that were set by this method will be overriden by the
 space constant.
 */
- (instancetype)setSpacing:(CGFloat)spacing between:(UIView *)firstView and:(UIView *)secondView;

#pragma mark Margins
/*
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

/* This is the priority that all margin constraints use. It defaults to required.
 */
- (instancetype)setMarginsPriority:(UILayoutPriority)priority;
@property (nonatomic, readonly) UILayoutPriority marginsPriority;

#pragma mark Other

/* If this is true then any subview which implements setPreferredMaxLayoutWidth: will have that property set
 to the actual layout width when layoutSubviews is called on the superview.
 It is illegal for this to cause a change of height in the containing view, so this property should be turned
 off and managed from a higher view level if that is true. It may trigger an assert in layoutSubviews.
 Defaults to YES.
 */
- (instancetype)setAdjustsPreferredMaxLayoutWidthOnSubviews:(BOOL)adjustValues;
@property (nonatomic, readonly) BOOL adjustsPreferredMaxLayoutWidthOnSubviews;

@end




@interface SLStackLayoutBase : NSObject

@property (readonly) NSArray<UIView *> *views;
@property (readonly, weak, nullable) UIView * superview;

/* Instead of using this directly, use UIView's -addSubviewsWithVerticalLayout: or -addSubviewsWithHorizontalLayout:
 If you do call this directly then all subviews should already be added to the superview. The subviews should all have
 translatesAutoresizingMaskIntoConstraints set to false. It must be called on a subclass.
 */
- (instancetype)initWithViews:(NSArray<UIView *> *)subviews inSuperview:(UIView *)superview;

/* This is called when the superview's layoutSubviews is invoked (which depends on method swizzling). This
 is when setPreferredMaxLayoutWidth: will be called on subviews if adjustsPreferredMaxLayoutWidthOnSubviews is
 true.
 */
- (void)subviewsLaidOut;

@end



@interface SLHorizontalStackLayout : SLStackLayoutBase <SLStackLayout>

@end



@interface SLVerticalStackLayout : SLStackLayoutBase <SLStackLayout>

@end


NS_ASSUME_NONNULL_END
