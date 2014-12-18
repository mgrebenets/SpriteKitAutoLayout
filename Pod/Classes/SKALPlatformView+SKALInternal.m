//
//  SKALPlatformView+SKALInternal.m
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 17/12/2014.
//
//

#import "SKALPlatformView+SKALInternal.h"

@implementation SKALPlatformView (SKALInternal)

#pragma mark - Managing Subviews
- (void)SKALInsertSubview:(SKALPlatformView *)view atIndex:(NSInteger)index {
#if TARGET_OS_IPHONE
    [self insertSubview:view atIndex:index];
#else
    // For now just add subview
    [self addSubview:view];
#endif
}

- (void)SKALLayoutSubviews {
#if TARGET_OS_IPHONE
    [self layoutSubviews];
#else
    // For now just add subview
    [self layout];
#endif
}

#pragma mark - Layout Rect
- (CGRect)layoutRect {
    // the root SKView's frame doesn't reflect rotation for iOS 7, fix it here
    // works for iOS8 and OSX since SKView is always root and it's origin is zero
    // yet returning frame for all other views is correct, since bounds doesn't have origin set
    return [self isKindOfClass:[SKView class]] ? self.bounds : self.frame;
}

@end
