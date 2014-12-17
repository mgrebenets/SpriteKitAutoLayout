//
//  SKNode+SKALInternal.m
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 16/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

@import ObjectiveC.runtime;
#import "SKNode+SKALInternal.h"

@implementation SKNode (SKALInternal)

#pragma mark Layout Proxy View Property
@dynamic layoutProxyView;

- (void)setLayoutProxyView:(SKView *)layoutProxyView {
    objc_setAssociatedObject(self, @selector(layoutProxyView), layoutProxyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SKView *)layoutProxyView {
    SKView *internalLayoutProxyView = objc_getAssociatedObject(self, @selector(layoutProxyView));

    if (!internalLayoutProxyView) {
        internalLayoutProxyView = [[SKView alloc] initWithFrame:self.frame];
        self.layoutProxyView = internalLayoutProxyView;
        self.layoutProxyView.hidden = YES;  // want them hidden for less CPU load
    }

    return internalLayoutProxyView;
}

#pragma mark Flipped Geometry
+ (BOOL)isFlipped {
    // Return YES for UIKit/AppKit compatibility so that "V:|" alignemtns means "top"
    // this is needed since SpriteKit has it's coordinate system origin at bottom left corner by default
    return YES;
}

+ (CGFloat)flipMultiplier {
    return self.isFlipped ? 1.0f : 0.0f;
}

@end
