//
//  AppDelegate.m
//  SpriteKitAutoLayoutOSX
//
//  Created by Maksym Grebenets on 17/12/2014.
//  Copyright (c) 2014 maksym.grebenets. All rights reserved.
//

#import "AppDelegate.h"
#import "SPriteKitAutoLayoutOSX-Swift.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    SKView *skView = self.skView;
    SKScene *scene = [[MainScene alloc] initWithSize: skView.bounds.size];
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;

    scene.scaleMode = SKSceneScaleModeResizeFill;

    [skView presentScene:scene];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
