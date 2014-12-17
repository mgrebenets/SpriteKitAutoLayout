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
    return self.frame;
}

@end
