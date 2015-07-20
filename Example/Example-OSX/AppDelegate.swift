//
//  AppDelegate.swift
//  Example-OSX
//
//  Created by Maksym Grebenets on 20/07/2015.
//  Copyright (c) 2015 i4nApps. All rights reserved.
//


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {

        skView.showsFPS = true
        skView.showsNodeCount = true

        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true

        let scene = MainScene(size: skView.bounds.size)
        scene.scaleMode = .ResizeFill

        /* Set the scale mode to scale to fit the window */
        skView.presentScene(scene)

    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
