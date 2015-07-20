//
//  SKALPlatformView+SKALInternal.h
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 17/12/2014.
//
//


@import SpriteKit;
#import "SKALUtils.h"

/**
 `SKALPlatformView` an adaptor category extending native platform view class (`UIView` or `NSView`).
 */
@interface SKALPlatformView (SKALInternal)

/**
 Platform specific insert subview method.
 @param view The view to insert.
 @param index Index to insert the view at.
 */
- (void)SKALInsertSubview:(SKALPlatformView *)view atIndex:(NSInteger)index;

/**
 Platform specific subviews layout.
 */
- (void)SKALLayoutSubviews;

/**
 Returns view's layout rect (aka frame).
 @return Layout frame.
 */
- (CGRect)layoutRect;

@end
