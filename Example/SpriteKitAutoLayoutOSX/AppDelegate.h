//
//  AppDelegate.h
//  SpriteKitAutoLayoutOSX
//

//  Copyright (c) 2014 maksym.grebenets. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SpriteKit/SpriteKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet SKView *skView;

@end
