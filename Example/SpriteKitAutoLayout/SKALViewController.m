//
//  SKALViewController.m
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 12/17/2014.
//  Copyright (c) 2014 Maksym Grebenets. All rights reserved.
//

@import SpriteKit;
#import "SKALViewController.h"
#import "SPriteKitAutoLayout-Swift.h"

@interface SKALViewController ()

@end

@implementation SKALViewController

- (void)loadView {
    self.view = [[SKView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    SKView *skView = (SKView *)self.view;
    SKScene *scene = [[MainScene alloc] initWithSize: skView.bounds.size];
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;

    scene.scaleMode = SKSceneScaleModeResizeFill;

    [skView presentScene:scene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
