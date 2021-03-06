//  Copyright © 2015 Bridger Maxwell. All rights reserved.

#import "SLStackLayout.h"
#import "UIView+StackLayout.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIView (StackLayoutInternal)

- (NSLayoutConstraint *)sl_constraintAligningAttribute:(NSLayoutAttribute)attribute withView:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute multiplier:1.0 constant:0];
}

- (NSLayoutConstraint *)sl_constraintWithSpace:(CGFloat)space followedByView:(UIView *)view isHorizontal:(BOOL)isHorizontal
{
    NSLayoutAttribute leadingAttribute = isHorizontal ? NSLayoutAttributeLeading : NSLayoutAttributeTop;
    NSLayoutAttribute trailingAttribute = isHorizontal ? NSLayoutAttributeTrailing : NSLayoutAttributeBottom;
    
    // view.leading = self.trailing + space
    return [NSLayoutConstraint constraintWithItem:view attribute:leadingAttribute relatedBy:NSLayoutRelationEqual toItem:self attribute:trailingAttribute multiplier:1.0 constant:space];
}

@end


@interface SLStackLayoutBase ()

@property (readonly) BOOL isHorizontal;
@property (readonly) NSLayoutAttribute majorLeadingAttribute;
@property (readonly) NSLayoutAttribute majorTrailingAttribute;
@property (readonly) NSLayoutAttribute majorLeadingMarginAttribute;
@property (readonly) NSLayoutAttribute majorTrailingMarginAttribute;

@property (readonly) NSLayoutAttribute minorLeadingAttribute;
@property (readonly) NSLayoutAttribute minorTrailingAttribute;
@property (readonly) NSLayoutAttribute minorLeadingMarginAttribute;
@property (readonly) NSLayoutAttribute minorTrailingMarginAttribute;

@property (readonly) NSLayoutAttribute majorSizeAttribute;
@property (readonly) NSLayoutAttribute majorCenterAttribute;

@property (readonly) NSLayoutAttribute minorSizeAttribute;
@property (readonly) NSLayoutAttribute minorCenterAttribute;

@property (readonly) UIView *leadingView;
@property (readonly) UIView *trailingView;

@property (nonatomic) NSArray *spacingConstraints;
@property (nonatomic) NSLayoutConstraint *majorLeadingMarginConstraint;
@property (nonatomic) NSLayoutConstraint *majorTrailingMarginConstraint;
@property (nonatomic) NSArray<NSLayoutConstraint *> *minorLeadingMarginConstraints;
@property (nonatomic) NSArray<NSLayoutConstraint *> *minorTrailingMarginConstraints;

@property (nonatomic, nullable) NSMapTable *minorLeadingMarginOverrides;
@property (nonatomic, nullable) NSMapTable *minorTrailingMarginOverrides;

@property (nonatomic, nullable) NSArray<NSLayoutConstraint *> *majorAlignmentConstraints;
@property (nonatomic, nullable) UIView *majorAlignmentHelperView;
@property (nonatomic, nullable) NSArray<NSLayoutConstraint *> *minorAlignmentConstraints;

@property (nonatomic) CGFloat majorLeadingMargin;
@property (nonatomic) CGFloat majorTrailingMargin;
@property (nonatomic) CGFloat minorLeadingMargin;
@property (nonatomic) CGFloat minorTrailingMargin;

@property (nonatomic) SLAlignment majorAlignment;
@property (nonatomic) SLAlignment minorAlignment;

@property (nonatomic) BOOL suppressInitialConstraints;
@property (nonatomic, nullable) NSMapTable *customSpaces;

// These are all the public properties that have just been marked readwrite
@property (readwrite) NSArray<UIView *> *views;
@property (readwrite, weak, nullable) UIView *superview;

// These are implemented by this base class but are only exposed in the two subclasses
@property (nonatomic) CGFloat spacing;
- (void)setCustomSpacing:(CGFloat)spacing betweenView:(UIView *)firstView andView:(UIView *)secondView;
- (void)setCustomSpacing:(CGFloat)spacing beforeView:(UIView *)subview;
- (void)setCustomSpacing:(CGFloat)spacing afterView:(UIView *)subview;
@property (nonatomic) UILayoutPriority spacingPriority;
@property (nonatomic) UILayoutPriority centeringAlignmentPriority;
@property(nonatomic, getter=isLayoutMarginsRelativeArrangement) BOOL layoutMarginsRelativeArrangement;
@property (nonatomic) BOOL adjustsPreferredMaxLayoutWidthOnSubviews;
@property (nonatomic) UILayoutPriority marginsPriority;

@end

@implementation SLStackLayoutBase

- (BOOL)isHorizontal
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSLayoutAttribute)majorLeadingAttribute
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSLayoutAttribute)majorTrailingAttribute
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSLayoutAttribute)majorLeadingMarginAttribute
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSLayoutAttribute)majorTrailingMarginAttribute
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSLayoutAttribute)minorLeadingAttribute
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSLayoutAttribute)minorTrailingAttribute
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSLayoutAttribute)minorLeadingMarginAttribute
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSLayoutAttribute)minorTrailingMarginAttribute
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSLayoutAttribute)majorSizeAttribute
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSLayoutAttribute)majorCenterAttribute
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSLayoutAttribute)minorSizeAttribute
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSLayoutAttribute)minorCenterAttribute
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (instancetype)initWithViews:(NSArray<UIView *> *)subviews inSuperview:(UIView *)superview
{
    if (subviews.count == 0) {
        [NSException raise:NSInvalidArgumentException format:@"there must be at least one view in a layout"];
    }
    
    if (self = [super init]) {
        self.views = subviews;
        self.superview = superview;
        
        // The alignment priority is high, but not required. This is so it very strongly tries to align,
        // but won't override the margin constraints (which are required)
        _centeringAlignmentPriority = UILayoutPriorityDefaultHigh + 10;
        _spacingPriority = UILayoutPriorityRequired;
        _marginsPriority = UILayoutPriorityRequired;
        _adjustsPreferredMaxLayoutWidthOnSubviews = NO;
        
        self.suppressInitialConstraints = YES;
    }
    return self;
}

- (void)buildInitialConstraints
{
    self.suppressInitialConstraints = NO;
    
    [self rebuildSpacingConstraints];
    self.majorAlignment = self.majorAlignment;
    self.minorAlignment = self.minorAlignment;
    
    [self rebuildMajorLeadingConstraint];
    [self rebuildMajorTrailingConstraint];
    [self rebuildMinorLeadingConstraints];
    [self rebuildMinorTrailingConstraints];
}

- (void)rebuildSpacingConstraints
{
    if (self.suppressInitialConstraints) return;
    
    for (NSLayoutConstraint *constraint in self.spacingConstraints) {
        constraint.active = false;
    }
    
    NSMutableArray *spacingConstraints = [NSMutableArray new];
    UIView *previousSubview = nil;
    for (UIView *subview in self.views) {
        if (previousSubview) {
            if (self.spacingPriority > 0) {
                NSNumber *initialSpace = [self.customSpaces objectForKey:previousSubview];
                CGFloat spacing = initialSpace ? [initialSpace doubleValue] : self.spacing;

                // subview.leading = previousSubview.trailing + spacing
                NSLayoutConstraint *spaceConstraint = [previousSubview sl_constraintWithSpace:spacing followedByView:subview isHorizontal:self.isHorizontal];
                spaceConstraint.priority = self.spacingPriority;
                [spacingConstraints addObject:spaceConstraint];
                spaceConstraint.active = true;
            }
        }
        previousSubview = subview;
    }
    self.spacingConstraints = spacingConstraints;
}

- (void)setSpacingPriority:(UILayoutPriority)priority
{
    if (_spacingPriority != priority) {
        _spacingPriority = priority;
        [self rebuildSpacingConstraints];
    }
}

- (void)rebuildMajorLeadingConstraint
{
    if (self.suppressInitialConstraints) return;
    
    self.majorLeadingMarginConstraint.active = false;

    NSLayoutAttribute marginAttribute = (self.isLayoutMarginsRelativeArrangement
                                              ? self.majorLeadingMarginAttribute
                                              : self.majorLeadingAttribute);
    NSLayoutRelation relation = ((self.majorAlignment == SLAlignmentLeading || self.majorAlignment == SLAlignmentFill)
                                 ? NSLayoutRelationEqual
                                 : NSLayoutRelationGreaterThanOrEqual);
    
    // leadingView.leading >= superview.leadingMargin + margin
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.leadingView attribute:self.majorLeadingAttribute relatedBy:relation toItem:self.superview attribute:marginAttribute multiplier:1.0 constant:self.majorLeadingMargin];
    constraint.priority = self.marginsPriority;
    constraint.active = true;
    
    self.majorLeadingMarginConstraint = constraint;
}

- (void)rebuildMajorTrailingConstraint
{
    if (self.suppressInitialConstraints) return;
    
    self.majorTrailingMarginConstraint.active = false;
    
    NSLayoutAttribute marginAttribute = (self.isLayoutMarginsRelativeArrangement
                                              ? self.majorTrailingMarginAttribute
                                              : self.majorTrailingAttribute);
    NSLayoutRelation relation = ((self.majorAlignment == SLAlignmentTrailing || self.majorAlignment == SLAlignmentFill)
                                 ? NSLayoutRelationEqual
                                 : NSLayoutRelationGreaterThanOrEqual);
    
    // superview.trailingMargin >= trailingView.trailing + margin
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.superview attribute:marginAttribute relatedBy:relation toItem:self.trailingView attribute:self.majorTrailingAttribute multiplier:1.0 constant:self.majorTrailingMargin];
    constraint.priority = self.marginsPriority;
    constraint.active = true;
    
    self.majorTrailingMarginConstraint = constraint;
}

- (void)rebuildMinorLeadingConstraints
{
    if (self.suppressInitialConstraints) return;
    
    for (NSLayoutConstraint *constraint in self.minorLeadingMarginConstraints) {
        constraint.active = false;
    }
    
    NSLayoutAttribute marginAttribute = (self.isLayoutMarginsRelativeArrangement
                                         ? self.minorLeadingMarginAttribute
                                         : self.minorLeadingAttribute);
    NSLayoutRelation relation = ((self.minorAlignment == SLAlignmentLeading || self.minorAlignment == SLAlignmentFill)
                                 ? NSLayoutRelationEqual
                                 : NSLayoutRelationGreaterThanOrEqual);
    
    NSMutableArray<NSLayoutConstraint *> *constraints = [NSMutableArray array];
    for (UIView *subview in self.views) {
        NSNumber *override = [self.minorLeadingMarginOverrides objectForKey:subview];
        CGFloat margin = override ? [override doubleValue] : self.minorLeadingMargin;

        //subview.leading >= superview.leadingMargin + margin
        [constraints addObject:[NSLayoutConstraint
                                constraintWithItem:subview attribute:self.minorLeadingAttribute
                                relatedBy:relation
                                toItem:self.superview attribute:marginAttribute
                                multiplier:1.0 constant:margin]];
        constraints.lastObject.priority = self.marginsPriority;
        constraints.lastObject.active = true;
    }
    
    self.minorLeadingMarginConstraints = constraints;
}


- (void)rebuildMinorTrailingConstraints
{
    if (self.suppressInitialConstraints) return;
    
    for (NSLayoutConstraint *constraint in self.minorTrailingMarginConstraints) {
        constraint.active = false;
    }
    
    NSLayoutAttribute marginAttribute = (self.isLayoutMarginsRelativeArrangement
                                         ? self.minorTrailingMarginAttribute
                                         : self.minorTrailingAttribute);
    NSLayoutRelation relation = ((self.minorAlignment == SLAlignmentTrailing || self.minorAlignment == SLAlignmentFill)
                                 ? NSLayoutRelationEqual
                                 : NSLayoutRelationGreaterThanOrEqual);
    
    NSMutableArray<NSLayoutConstraint *> *constraints = [NSMutableArray array];
    for (UIView *subview in self.views) {
        NSNumber *override = [self.minorTrailingMarginOverrides objectForKey:subview];
        CGFloat margin = override ? [override doubleValue] : self.minorTrailingMargin;

        //superview.trailingMargin >= subview.trailing + margin
        [constraints addObject:[NSLayoutConstraint
                                constraintWithItem:self.superview attribute:marginAttribute
                                relatedBy:relation
                                toItem:subview attribute:self.minorTrailingAttribute
                                multiplier:1.0 constant:margin]];
        constraints.lastObject.priority = self.marginsPriority;
        constraints.lastObject.active = true;
    }
    
    self.minorTrailingMarginConstraints = constraints;
}

- (UIView *)leadingView
{
    return self.views.firstObject;
}

- (UIView *)trailingView
{
    return self.views.lastObject;
}

- (void)setSpacing:(CGFloat)spacing
{
    _spacing = spacing;
    for (NSLayoutConstraint *spacingConstraint in self.spacingConstraints) {
        spacingConstraint.constant = spacing;
    }
}

- (void)setCustomSpacing:(CGFloat)spacing betweenView:(UIView *)firstView andView:(UIView *)secondView
{
    // We store these in a map table. We find the first view and store the space that should be after that view.
    UIView *previousView;
    BOOL foundMatch = NO;
    for (UIView *nextView in self.views) {
        if ((firstView == previousView && secondView == nextView) ||
            (firstView == nextView && secondView == previousView)) {

            // Found it!
            if (!self.customSpaces) {
                self.customSpaces = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:self.views.count - 1];
            }
            [self.customSpaces setObject:@(spacing) forKey:previousView];
            foundMatch = YES;
        }
        previousView = nextView;
    }
    if (!foundMatch) {
        // If we reach this point then the correct spacing constraint wasn't found. This means firstView and
        // secondView weren't adjacent siblings
        [NSException raise:NSInvalidArgumentException format:@"Can't set space between two views which aren't adjacent siblings."];
    }

    // Adjust any existing constraint
    for (NSLayoutConstraint *spacingConstraint in self.spacingConstraints) {
        if ((spacingConstraint.firstItem == firstView && spacingConstraint.secondItem == secondView) ||
            (spacingConstraint.firstItem == secondView && spacingConstraint.secondItem == firstView)) {

            // Found the correct space constraint!
            spacingConstraint.constant = spacing;
            return;
        }
    }
}

- (void)setCustomSpacing:(CGFloat)spacing beforeView:(UIView *)subview
{
    UIView *previousView = nil;
    BOOL foundMatch = NO;
    for (UIView *view in self.views) {
        if (view == subview) {
            foundMatch = YES;
            break;
        }
        previousView = view;
    }
    if (foundMatch) {
        if (previousView) {
            [self setCustomSpacing:spacing betweenView:previousView andView:subview];
        } else {
            [NSException raise:NSInvalidArgumentException format:@"Can't set a custom space before the view because there is no preceeding view."];
        }
    } else {
        [NSException raise:NSInvalidArgumentException format:@"Can't set a custom space because the view isn't part of this layout."];
    }
}

- (void)setCustomSpacing:(CGFloat)spacing afterView:(UIView *)subview
{
    BOOL foundMatch = NO;
    UIView *nextView = nil;
    for (UIView *view in self.views) {
        if (view == subview) {
            foundMatch = YES;
            // Loop one more time
            continue;
        } else if (foundMatch) {
            nextView = view;
            break;
        }
    }
    if (foundMatch) {
        if (nextView) {
            [self setCustomSpacing:spacing betweenView:subview andView:nextView];
        } else {
            [NSException raise:NSInvalidArgumentException format:@"Can't set a custom space after the view because it is the last view."];
        }
    } else {
        [NSException raise:NSInvalidArgumentException format:@"Can't set a custom space because the view isn't part of this layout."];
    }
}

- (void)setMajorLeadingMargin:(CGFloat)majorLeadingMargin
{
    _majorLeadingMargin = majorLeadingMargin;
    self.majorLeadingMarginConstraint.constant = majorLeadingMargin;
}

- (void)setMajorTrailingMargin:(CGFloat)majorTrailingMargin
{
    _majorTrailingMargin = majorTrailingMargin;
    self.majorTrailingMarginConstraint.constant = majorTrailingMargin;
}

- (void)setMinorLeadingMargin:(CGFloat)minorLeadingMargin
{
    _minorLeadingMargin = minorLeadingMargin;
    for (NSLayoutConstraint *constraint in self.minorLeadingMarginConstraints) {
        if (![self.minorLeadingMarginOverrides objectForKey:constraint.firstItem]) {
            constraint.constant = minorLeadingMargin;
        }
    }
}

- (void)setCustomMinorLeadingMargin:(CGFloat)minorLeadingMargin forView:(UIView *)view
{
    if (!self.minorLeadingMarginOverrides) {
        self.minorLeadingMarginOverrides = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:self.views.count - 1];
    }
    [self.minorLeadingMarginOverrides setObject:@(minorLeadingMargin) forKey:view];

    for (NSLayoutConstraint *constraint in self.minorLeadingMarginConstraints) {
        if (constraint.firstItem == view) {
            constraint.constant = minorLeadingMargin;
        }
    }
}

- (void)setMinorTrailingMargin:(CGFloat)minorTrailingMargin
{
    _minorTrailingMargin = minorTrailingMargin;
    for (NSLayoutConstraint *constraint in self.minorTrailingMarginConstraints) {
        if (![self.minorTrailingMarginOverrides objectForKey:constraint.secondItem]) {
            constraint.constant = minorTrailingMargin;
        }
    }
}

- (void)setCustomMinorTrailingMargin:(CGFloat)minorTrailingMargin forView:(UIView *)view
{
    if (!self.minorTrailingMarginOverrides) {
        self.minorTrailingMarginOverrides = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:self.views.count - 1];
    }
    [self.minorTrailingMarginOverrides setObject:@(minorTrailingMargin) forKey:view];

    for (NSLayoutConstraint *constraint in self.minorTrailingMarginConstraints) {
        if (constraint.secondItem == view) {
            constraint.constant = minorTrailingMargin;
        }
    }
}

- (void)setLayoutMarginsRelativeArrangement:(BOOL)layoutMarginsRelativeArrangement
{
    if (_layoutMarginsRelativeArrangement != layoutMarginsRelativeArrangement) {
        _layoutMarginsRelativeArrangement = layoutMarginsRelativeArrangement;
        
        [self rebuildMajorLeadingConstraint];
        [self rebuildMajorTrailingConstraint];
        [self rebuildMinorLeadingConstraints];
        [self rebuildMinorTrailingConstraints];
    }
}

- (void)setMarginsPriority:(UILayoutPriority)priority
{
    if (_marginsPriority != priority) {
        _marginsPriority = priority;
        
        [self rebuildMajorLeadingConstraint];
        [self rebuildMajorTrailingConstraint];
        [self rebuildMinorLeadingConstraints];
        [self rebuildMinorTrailingConstraints];
    }
}

- (void)setMajorAlignment:(SLAlignment)majorAlignment
{
    if (_majorAlignment != majorAlignment || !self.minorLeadingMarginConstraints) {
        _majorAlignment = majorAlignment;
        
        if (self.suppressInitialConstraints) return;
        
        // We can't change these on the fly so we need to remove them and rebuild them
        [NSLayoutConstraint deactivateConstraints:self.majorAlignmentConstraints];
        self.majorAlignmentConstraints = nil;

        [self.majorAlignmentHelperView removeFromSuperview];
        self.majorAlignmentHelperView = nil;

        // By rebuilding these constraints we make sure they are either >= or ==, depending on the alignment
        [self rebuildMajorLeadingConstraint];
        [self rebuildMajorTrailingConstraint];
        
        if (self.majorAlignment == SLAlignmentCenter) {
            // This one is tricky. We need a hidden helper view to encompass the content, then we can center that view
            
            UIView *helperView = [[UIView alloc] init];
            helperView.accessibilityIdentifier = @"SLStackLayoutCenteringHelper";
            helperView.translatesAutoresizingMaskIntoConstraints = false;
            helperView.hidden = YES;
            [self.superview addSubview:helperView];
            
            // Tie the helperView's edges to emcompass the whole content, and then center the helperView
            NSMutableArray<NSLayoutConstraint *> *constraints = [NSMutableArray array];
            [constraints addObject:[helperView sl_constraintAligningAttribute:self.majorLeadingAttribute withView:self.leadingView]];
            [constraints addObject:[helperView sl_constraintAligningAttribute:self.majorTrailingAttribute withView:self.trailingView]];
            
            [constraints addObject:[helperView sl_constraintAligningAttribute:self.majorCenterAttribute withView:self.superview]];

            // The  minor axis for this view doesn't matter, but we need to set it so that the layout isn't ambiguous
            [constraints addObject:[helperView sl_constraintAligningAttribute:self.minorLeadingAttribute withView:self.superview]];
            [constraints addObject:[NSLayoutConstraint constraintWithItem:helperView attribute:self.minorSizeAttribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.0]];

            for (NSLayoutConstraint *constraint in constraints) {
                constraint.priority = self.centeringAlignmentPriority;
            }
            [NSLayoutConstraint activateConstraints:constraints];
            self.majorAlignmentConstraints = constraints;
            self.majorAlignmentHelperView = helperView;
        }
    }
}

- (void)setMinorAlignment:(SLAlignment)minorAlignment
{
    if (_minorAlignment != minorAlignment || !self.minorLeadingMarginConstraints) {
        _minorAlignment = minorAlignment;
        
        if (self.suppressInitialConstraints) return;
        
        // We can't change these on the fly so we need to remove them and rebuild them
        [NSLayoutConstraint deactivateConstraints:self.minorAlignmentConstraints];
        self.minorAlignmentConstraints = nil;
        
        // By rebuilding these constraints we make sure they are either >= or ==, depending on the alignment
        [self rebuildMinorLeadingConstraints];
        [self rebuildMinorTrailingConstraints];
        
        if (self.minorAlignment == SLAlignmentCenter) {
            NSMutableArray *constraints = [NSMutableArray array];
            for (UIView *subview in self.views) {
                // superview.center = subview.center
                NSLayoutConstraint *constraint = [self.superview sl_constraintAligningAttribute:self.minorCenterAttribute withView:subview];
                constraint.priority = self.centeringAlignmentPriority;
                [constraints addObject:constraint];
            }
            [NSLayoutConstraint activateConstraints:constraints];
            self.minorAlignmentConstraints = constraints;
        }
    }
}

- (void)setCenteringAlignmentPriority:(UILayoutPriority)alignmentPriority
{
    if (_centeringAlignmentPriority != alignmentPriority) {
        // Trigger a rebuild of these constraints by setting and unsetting them
        if (self.majorAlignment == SLAlignmentCenter) {
            self.majorAlignment = SLAlignmentNone;
            self.majorAlignment = SLAlignmentCenter;
        }
        
        if (self.minorAlignment == SLAlignmentCenter) {
            self.minorAlignment = SLAlignmentNone;
            self.minorAlignment = SLAlignmentCenter;
        }
    }
}

- (void)setAdjustsPreferredMaxLayoutWidthOnSubviews:(BOOL)adjustValues
{
    _adjustsPreferredMaxLayoutWidthOnSubviews = adjustValues;
}

- (void)subviewsLaidOut
{
    if (!self.adjustsPreferredMaxLayoutWidthOnSubviews) {
        return;
    }
    for (UIView *subview in self.views) {
        if ([subview respondsToSelector:@selector(setPreferredMaxLayoutWidth:)]) {
            CGFloat layoutWidth = subview.frame.size.width;
            [(id)subview setPreferredMaxLayoutWidth:layoutWidth];
            
            [subview updateConstraintsIfNeeded];
        }
    }
}

@end


@implementation SLHorizontalStackLayout

- (instancetype)initWithViews:(NSArray<UIView *> *)subviews inSuperview:(UIView *)superview configurationBlock:(void (NS_NOESCAPE ^__nullable)(SLHorizontalStackLayout *))configurationBlock
{
    self = [super initWithViews:subviews inSuperview:superview];
    if (self) {
        if (configurationBlock) {
            configurationBlock(self);
        }
        [self buildInitialConstraints];
    }
    return self;
}

- (BOOL)isHorizontal
{
    return YES;
}

- (NSLayoutAttribute)majorLeadingAttribute
{
    return NSLayoutAttributeLeading;
}

- (NSLayoutAttribute)majorTrailingAttribute
{
    return NSLayoutAttributeTrailing;
}

- (NSLayoutAttribute)majorLeadingMarginAttribute
{
    return NSLayoutAttributeLeadingMargin;
}

- (NSLayoutAttribute)majorTrailingMarginAttribute
{
    return NSLayoutAttributeTrailingMargin;
}

- (NSLayoutAttribute)minorLeadingAttribute
{
    return NSLayoutAttributeTop;
}

- (NSLayoutAttribute)minorTrailingAttribute
{
    return NSLayoutAttributeBottom;
}

- (NSLayoutAttribute)minorLeadingMarginAttribute
{
    return NSLayoutAttributeTopMargin;
}

- (NSLayoutAttribute)minorTrailingMarginAttribute
{
    return NSLayoutAttributeBottomMargin;
}

- (NSLayoutAttribute)majorSizeAttribute
{
    return NSLayoutAttributeWidth;
}

- (NSLayoutAttribute)majorCenterAttribute
{
    return NSLayoutAttributeCenterX;
}

- (NSLayoutAttribute)minorSizeAttribute
{
    return NSLayoutAttributeHeight;
}

- (NSLayoutAttribute)minorCenterAttribute
{
    return NSLayoutAttributeCenterY;
}

- (void)setLeadingMargin:(CGFloat)margin
{
    self.majorLeadingMargin = margin;
}
- (CGFloat)leadingMargin
{
    return self.majorLeadingMargin;
}

- (void)setTrailingMargin:(CGFloat)margin
{
    self.majorTrailingMargin = margin;
}
- (CGFloat)trailingMargin
{
    return self.majorTrailingMargin;
}
- (void)setHorizontalMargins:(CGFloat)margin
{
    self.majorTrailingMargin = margin;
    self.majorLeadingMargin = margin;
}
- (CGFloat)horizontalMargins
{
    return self.majorLeadingMargin;
}

- (void)setTopMargin:(CGFloat)margin
{
    self.minorLeadingMargin = margin;
}
- (CGFloat)topMargin
{
    return self.minorLeadingMargin;
}

- (void)setBottomMargin:(CGFloat)margin
{
    self.minorTrailingMargin = margin;
}
- (CGFloat)bottomMargin
{
    return self.minorTrailingMargin;
}
- (void)setVerticalMargins:(CGFloat)margin
{
    self.minorTrailingMargin = margin;
    self.minorLeadingMargin = margin;
}
- (CGFloat)verticalMargins
{
    return self.minorLeadingMargin;
}

- (void)setCustomTopMargin:(CGFloat)topMargin forView:(UIView *)view
{
    [self setCustomMinorLeadingMargin:topMargin forView:view];
}

- (void)setCustomBottomMargin:(CGFloat)bottomMargin forView:(UIView *)view
{
    [self setCustomMinorTrailingMargin:bottomMargin forView:view];
}

- (void)setCustomVerticalMargins:(CGFloat)verticalMargins forView:(UIView *)view
{
    [self setCustomMinorLeadingMargin:verticalMargins forView:view];
    [self setCustomMinorTrailingMargin:verticalMargins forView:view];
}

- (void)setHorizontalAlignment:(SLAlignment)alignment
{
    self.majorAlignment = alignment;
}
- (SLAlignment)horizontalAlignment
{
    return self.majorAlignment;
}

- (void)setVerticalAlignment:(SLAlignment)alignment
{
    self.minorAlignment = alignment;
}
- (SLAlignment)verticalAlignment
{
    return self.minorAlignment;
}


@end


@implementation SLVerticalStackLayout

- (instancetype)initWithViews:(NSArray<UIView *> *)subviews inSuperview:(UIView *)superview configurationBlock:(void (NS_NOESCAPE ^__nullable)(SLVerticalStackLayout *))configurationBlock
{
    self = [super initWithViews:subviews inSuperview:superview];
    if (self) {
        if (configurationBlock) {
            configurationBlock(self);
        }
        [self buildInitialConstraints];
    }
    return self;
}

- (BOOL)isHorizontal
{
    return NO;
}

- (NSLayoutAttribute)majorLeadingAttribute
{
    return NSLayoutAttributeTop;
}

- (NSLayoutAttribute)majorTrailingAttribute
{
    return NSLayoutAttributeBottom;
}

- (NSLayoutAttribute)majorLeadingMarginAttribute
{
    return NSLayoutAttributeTopMargin;
}

- (NSLayoutAttribute)majorTrailingMarginAttribute
{
    return NSLayoutAttributeBottomMargin;
}

- (NSLayoutAttribute)minorLeadingAttribute
{
    return NSLayoutAttributeLeading;
}

- (NSLayoutAttribute)minorTrailingAttribute
{
    return NSLayoutAttributeTrailing;
}

- (NSLayoutAttribute)minorLeadingMarginAttribute
{
    return NSLayoutAttributeLeadingMargin;
}

- (NSLayoutAttribute)minorTrailingMarginAttribute
{
    return NSLayoutAttributeTrailingMargin;
}

- (NSLayoutAttribute)majorSizeAttribute
{
    return NSLayoutAttributeHeight;
}

- (NSLayoutAttribute)majorCenterAttribute
{
    return NSLayoutAttributeCenterY;
}

- (NSLayoutAttribute)minorSizeAttribute
{
    return NSLayoutAttributeWidth;
}

- (NSLayoutAttribute)minorCenterAttribute
{
    return NSLayoutAttributeCenterX;
}

- (void)setLeadingMargin:(CGFloat)margin
{
    self.minorLeadingMargin = margin;
}
- (CGFloat)leadingMargin
{
    return self.minorLeadingMargin;
}

- (void)setTrailingMargin:(CGFloat)margin
{
    self.minorTrailingMargin = margin;
}
- (CGFloat)trailingMargin
{
    return self.minorTrailingMargin;
}

- (void)setHorizontalMargins:(CGFloat)margin
{
    self.minorTrailingMargin = margin;
    self.minorLeadingMargin = margin;
}
- (CGFloat)horizontalMargins
{
    return self.minorLeadingMargin;
}

- (void)setTopMargin:(CGFloat)margin
{
    self.majorLeadingMargin = margin;
}
- (CGFloat)topMargin
{
    return self.majorLeadingMargin;
}

- (void)setBottomMargin:(CGFloat)margin
{
    self.majorTrailingMargin = margin;
}
- (CGFloat)bottomMargin
{
    return self.majorTrailingMargin;
}

- (void)setVerticalMargins:(CGFloat)margin
{
    self.majorTrailingMargin = margin;
    self.majorLeadingMargin = margin;
}
- (CGFloat)verticalMargins
{
    return self.majorLeadingMargin;
}

- (void)setCustomLeadingMargin:(CGFloat)leadingMargin forView:(UIView *)view
{
    [self setCustomMinorLeadingMargin:leadingMargin forView:view];
}

- (void)setCustomTrailingMargin:(CGFloat)trailingMargin forView:(UIView *)view
{
    [self setCustomMinorTrailingMargin:trailingMargin forView:view];
}

- (void)setCustomHorizontalMargins:(CGFloat)horizontalMargins forView:(UIView *)view
{
    [self setCustomMinorLeadingMargin:horizontalMargins forView:view];
    [self setCustomMinorTrailingMargin:horizontalMargins forView:view];
}

- (void)setHorizontalAlignment:(SLAlignment)alignment
{
    self.minorAlignment = alignment;
}
- (SLAlignment)horizontalAlignment
{
    return self.minorAlignment;
}

- (void)setVerticalAlignment:(SLAlignment)alignment
{
    self.majorAlignment = alignment;
}
- (SLAlignment)verticalAlignment
{
    return self.majorAlignment;
}

@end


NS_ASSUME_NONNULL_END
