//
//  SKNode+SKALInternal.h
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 16/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

@import SpriteKit;
#import "SKALUtils.h"

/**
 Internal `SKNode` Auto Layout category.
 */
@interface SKNode (SKALInternal)
/**
 Internal layout proxy view.
 Loaded laizily when node is added as a child.
 For scenes set with container SKView when scene is presented.
 */
@property (nonatomic, strong) SKALPlatformView *internalLayoutProxyView;

/**
 Customazible Y coordinate flip flag.
 @return `YES` if Y coordinate is flipped.
 */
+ (BOOL)isFlipped;

/** 
 Flip multiplier.
 @return Current flip multiplier.
 */
+ (CGFloat)flipMultiplier;
@end
