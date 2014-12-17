//
//  SKView+SKAL.h
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 16/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

@import SpriteKit;

/**
 SKView AutoLayout category
 */
@interface SKView (SKAL)
/** 
 Platform specific insert subview method
 */
- (void)SKALInsertSubview:(SKView *)view atIndex:(NSInteger)index;

/** 
 Platform specific subviews layout
 */
- (void)SKALLayoutSubviews;

/** 
 Returns view's layout rect (aka frame)
 */
- (CGRect)layoutRect;

@end
