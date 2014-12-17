//
//  SKALPlatformView+SKALInternal.h
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 17/12/2014.
//
//


@import SpriteKit;
#import "SKALUtils.h"

@interface SKALPlatformView (SKALInternal)
/**
 Platform specific insert subview method
 */
- (void)SKALInsertSubview:(SKALPlatformView *)view atIndex:(NSInteger)index;

/**
 Platform specific subviews layout
 */
- (void)SKALLayoutSubviews;
/**
 Returns view's layout rect (aka frame)
 */
- (CGRect)layoutRect;
@end
