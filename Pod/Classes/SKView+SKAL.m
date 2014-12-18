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

#pragma mark New Scene Management Selectors
- (void)prepareForPresentingScene:(SKScene *)scene {
    // if don't copy will crash on OSX because mutating array while enumerating
    NSArray *subviews = [self.subviews copy];
    for (SKALPlatformView *subview in subviews) {
        [subview removeFromSuperview];
    }
    [scene.layoutProxyView removeConstraints:scene.layoutProxyView.constraints];
    scene.layoutProxyView = self;
}

- (void)SKALPresentScene:(SKScene *)scene {
    [self prepareForPresentingScene:scene];
    [self SKALPresentScene:scene];
}

- (void)SKALPresentScene:(SKScene *)scene transition:(SKTransition *)transition {
    [self prepareForPresentingScene:scene];
    [self SKALPresentScene:scene transition:transition];
}

#pragma mark Loading Category
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Swizzle time!
        Class viewClass = [self class];

        // Present scene
        SKALSwizzleMethod(viewClass, @selector(presentScene:), @selector(SKALPresentScene:));

        // Present scene with transition
        SKALSwizzleMethod(viewClass, @selector(presentScene:transition:), @selector(SKALPresentScene:transition:));
    });
}

@end