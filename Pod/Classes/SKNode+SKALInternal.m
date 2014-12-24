//
//  SKNode+SKALInternal.m
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 16/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

@import ObjectiveC.runtime;
#import "SKNode+SKAL.h"
#import "SKNode+SKALInternal.h"

@implementation SKNode (SKALInternal)

#pragma mark Layout Proxy View Property
@dynamic internalLayoutProxyView;

- (void)setInternalLayoutProxyView:(SKALPlatformView *)internalLayoutProxyView {
    objc_setAssociatedObject(self, @selector(internalLayoutProxyView), internalLayoutProxyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SKALPlatformView *)internalLayoutProxyView {
    SKALPlatformView *localLayoutProxyView = objc_getAssociatedObject(self, @selector(internalLayoutProxyView));

    if (!localLayoutProxyView) {
        // TODO: consider using specific platform subclass for nodes that have
        // intrinsic size, e.g. backup SKLabelNode with UI/NSLabel
        // with same text, font and font size
        // though it adds additional burden of updating backing view
        // when label is updated
        // same goes for SKSpriteNode backup up by UIImageView or alike...

        localLayoutProxyView = [[SKALPlatformView alloc] initWithFrame:self.frame];
        self.internalLayoutProxyView = localLayoutProxyView;
        self.internalLayoutProxyView.hidden = YES;  // want them hidden, those are just proxies
    }

    return localLayoutProxyView;
}

#pragma mark Flipped Geometry
+ (BOOL)isFlipped {
    // Return YES for UIKit/AppKit compatibility so that "V:|" alignemtns means "top"
    // This is needed since SpriteKit has it's coordinate system origin at bottom left corner by default
    return YES;
}

+ (CGFloat)flipMultiplier {
    return self.isFlipped ? 1.0f : 0.0f;
}

@end
