//
//  NSLayoutConstraint+NSLayoutConstraint_SKAL.m
//  Pods
//
//  Created by Maksym Grebenets on 18/12/2014.
//
//

#import "NSLayoutConstraint+SKAL.h"
#import "SKNode+SKALInternal.h"
#import "SKALUtils.h"

@import ObjectiveC.runtime;

// Make it loadable
SKAL_MAKE_CATEGORIES_LOADABLE(NSLayoutConstraint_SKAL)

@implementation NSLayoutConstraint (SKAL)

#pragma mark Swizzled Inializers
+ (NSArray *)SKALConstraintsWithVisualFormat:(NSString *)format
                                 options:(NSLayoutFormatOptions)opts
                                 metrics:(NSDictionary *)metrics
                                   views:(NSDictionary *)views
{
    // here use the fact that VFH makes no sence with empty views dictionary
    // it should even assert when it's nil (TODO: check)
    // see the VFH syntax and make sure that at least one <view> in [<viewName>] format must exist
    // https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage/VisualFormatLanguage.html
    NSParameterAssert(views);
    id firstView = views.allValues.firstObject;
    NSAssert(firstView, @"Views dictionary must have at least one view!");
    NSMutableDictionary *unwrappedViews = [NSMutableDictionary dictionaryWithDictionary:views];
    if ([firstView isKindOfClass:[SKNode class]]) {
        // dealing with SpriteKit support, unwrap all the views
        for (NSString *key in views.keyEnumerator) {
            unwrappedViews[key] = ((SKNode *)views[key]).internalLayoutProxyView;
        }
    }

    return [NSLayoutConstraint SKALConstraintsWithVisualFormat:format options:opts metrics:metrics views:unwrappedViews];
}

// Initialize with items, attributes and relationship
+ (instancetype)SKALConstraintWithItem:(id)view1
                         attribute:(NSLayoutAttribute)attr1
                         relatedBy:(NSLayoutRelation)relation
                            toItem:(id)view2
                         attribute:(NSLayoutAttribute)attr2
                        multiplier:(CGFloat)multiplier
                          constant:(CGFloat)c
{
    id unwrappedView1 = view1;
    id unwrappedView2 = view2;
    if ([view1 isKindOfClass:[SKNode class]]) {
        NSAssert(!view2 || [view2 isKindOfClass:[SKNode class]], @"All items must be SKNode subclass!");
        // using for SpriteKit, unwrap views
        unwrappedView1 = ((SKNode *) view1).internalLayoutProxyView;
        unwrappedView2 = view2 ? ((SKNode *) view2).internalLayoutProxyView : nil;
    }
    return [NSLayoutConstraint SKALConstraintWithItem:unwrappedView1 attribute:attr1 relatedBy:relation toItem:unwrappedView2 attribute:attr2 multiplier:multiplier constant:c];
}

#pragma mark Double Swizzle Guard

// Declare double swizzle guard
DECLARE_DOUBLE_SWIZZLE_GUARD()

#pragma mark Loading Category
+ (void)load {
    // Protect from double swizzling
    PROTECT_FROM_DOUBLE_SWIZZLE()

    // Meta class
    Class metaClass = object_getClass((id)self);

    // Constraints with VFL
    SKALSwizzleMethod(metaClass, @selector(constraintsWithVisualFormat:options:metrics:views:), @selector(SKALConstraintsWithVisualFormat:options:metrics:views:));

    // Constraint with items
    SKALSwizzleMethod(metaClass, @selector(constraintWithItem:attribute:relatedBy:toItem:attribute:multiplier:constant:), @selector(SKALConstraintWithItem:attribute:relatedBy:toItem:attribute:multiplier:constant:));

}

@end
