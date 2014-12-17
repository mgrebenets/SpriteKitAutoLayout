//
//  SKView+SKAL.m
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 16/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

#import "SKView+SKAL.h"
#import "SKNode+SKALInternal.h"
#import "SKALUtils.h"

// Make it loadable
SKAL_MAKE_CATEGORIES_LOADABLE(SKView_SKAL)

// SKView AutoLayout category implementation
@implementation SKView (SKAL)

#pragma mark - Presenting Scene

#pragma mark Original Selectors
- (void)originalPresentScene:(SKScene *)scene { /* Stub */ }
- (void)originalPresentScene:(SKScene *)scene transition:(SKTransition *)transition { /* Stub */ }

#pragma mark New Scene Management Selectors
- (void)autoLayoutPresentScene:(SKScene *)scene {
    scene.layoutProxyView = self;
    [self originalPresentScene:scene];
}

- (void)autoLayoutPresentScene:(SKScene *)scene transition:(SKTransition *)transition {
    scene.layoutProxyView = self;
    [self originalPresentScene:scene transition:transition];
}

#pragma mark Loading Category
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Swizzle time!
        Class viewClass = [SKView class];

        // Present scene
        SKALInjectMethod(viewClass, @selector(presentScene:), @selector(autoLayoutPresentScene:), @selector(originalPresentScene:));

        // Present scene with transition
        SKALInjectMethod(viewClass, @selector(presentScene:transition:), @selector(autoLayoutPresentScene:transition:), @selector(originalPresentScene:transition:));
    });
}

@end