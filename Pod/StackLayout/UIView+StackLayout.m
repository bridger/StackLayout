//  Copyright © 2015 Bridger Maxwell. All rights reserved.

#import <objc/runtime.h>

#import "UIView+StackLayout.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIView (SLStackLayout)

- (SLHorizontalStackLayout *)addSubviewsWithHorizontalLayout:(NSArray<UIView *> *)subviews
{
    for (UIView *subview in subviews) {
        subview.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:subview];
    }
    SLHorizontalStackLayout *layout = [[SLHorizontalStackLayout alloc] initWithViews:subviews inSuperview:self];
    [self installStackLayout:layout];
    return layout;
}

- (SLVerticalStackLayout *)addSubviewsWithVerticalLayout:(NSArray<UIView *> *)subviews
{
    for (UIView *subview in subviews) {
        subview.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:subview];
    }
    SLVerticalStackLayout *layout = [[SLVerticalStackLayout alloc] initWithViews:subviews inSuperview:self];
    [self installStackLayout:layout];
    return layout;
}

- (void)removeSubviewsInLayout:(SLStackLayoutBase *)layout
{
    if (!layout) {
        return;
    }
    NSArray *layouts = [self sl_installedLayouts];
    if ([layouts containsObject:layout]) {
        for (UIView *subview in layout.views) {
            [subview removeFromSuperview];
        }
        
        NSMutableArray *mutableLayouts = [layouts mutableCopy];
        [mutableLayouts removeObject:layout];
        
        [self sl_setInstalledLayouts:mutableLayouts];
    }
}

- (NSArray * _Nullable)sl_installedLayouts
{
    return objc_getAssociatedObject(self, @selector((sl_installedLayouts)));
}

- (void)sl_setInstalledLayouts:(NSArray *)layouts
{
    objc_setAssociatedObject(self, @selector(sl_installedLayouts), layouts, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)installStackLayout:(SLStackLayoutBase *)stackLayout
{
    NSArray *layouts = [self sl_installedLayouts];
    
    if (!layouts) {
        // This is the first stack layout that has been installed. We are going to swizzle out the layoutSubviews
        // method to give the layouts a hook.
        Class class = [self class];
        
        SEL originalSelector = @selector(layoutSubviews);
        SEL swizzledSelector = @selector(sl_layoutSubviews);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        layouts = [NSArray array];
    }
    layouts = [layouts arrayByAddingObject:stackLayout];
    
    [self sl_setInstalledLayouts:layouts];
}

// This is a swizzled version of layoutSubviews that allows the layout objects to get a chance to do adjustments
// in layoutSubviews
- (void)sl_layoutSubviews
{
    // In this context [self sl_layoutSubviews] is like calling the original layoutSubviews method on self
    [self sl_layoutSubviews];
    
    for (SLStackLayoutBase *layoutBase in [self sl_installedLayouts]) {
        [layoutBase subviewsLaidOut];
    }
}

@end

NS_ASSUME_NONNULL_END
