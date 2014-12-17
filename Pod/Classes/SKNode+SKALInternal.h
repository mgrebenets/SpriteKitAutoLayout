//
//  SKNode+SKALInternal.h
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 16/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

@import SpriteKit;

/**
 Internal SKNode Auto Layout category
 */
@interface SKNode (SKALInternal)
/**
 Internal layout proxy view
 */
@property (nonatomic, strong) SKView *layoutProxyView;

// Returns true if Y coordinate is flipped
+ (BOOL)isFlipped;

// Flip multiplier
+ (CGFloat)flipMultiplier;
@end
