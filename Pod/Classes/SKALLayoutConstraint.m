//
//  SKALLayoutConstraint.m
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 16/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

#import "SKALLayoutConstraint.h"
#import "SKNode+SKALInternal.h"

@implementation SKALLayoutConstraint

// Initialize with visual format
+ (NSArray *)constraintsWithVisualFormat:(NSString *)format
                                 options:(NSLayoutFormatOptions)opts
                                 metrics:(NSDictionary *)metrics
                                   views:(NSDictionary *)views
{

    NSMutableDictionary *unwrappedViews = [NSMutableDictionary dictionaryWithDictionary:views];
    for (NSString *key in views.keyEnumerator) {
        unwrappedViews[key] = ((SKNode *)views[key]).layoutProxyView;
    }

    return [NSLayoutConstraint constraintsWithVisualFormat:format options:opts metrics:metrics views:unwrappedViews];
}

// Initialize with items, attributes and relationship
+ (instancetype)constraintWithItem:(id)view1
                         attribute:(NSLayoutAttribute)attr1
                         relatedBy:(NSLayoutRelation)relation
                            toItem:(id)view2
                         attribute:(NSLayoutAttribute)attr2
                        multiplier:(CGFloat)multiplier
                          constant:(CGFloat)c
{
    return (SKALLayoutConstraint *)[NSLayoutConstraint constraintWithItem:((SKNode *)view1).layoutProxyView attribute:attr1 relatedBy:relation toItem:((SKNode *)view2).layoutProxyView attribute:attr2 multiplier:multiplier constant:c];
}

@end
