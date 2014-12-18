//
//  CommonScene.swift
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 17/12/2014.
//  Copyright (c) 2014 maksym.grebenets. All rights reserved.
//


class CommonScene: SKScene {

    let BackButtonName = "backButton"

    func addBackButton() {
        let backButton = SKSpriteNode(imageNamed: "back")
        backButton.name = BackButtonName
        backButton.autoLayoutEnabled = true
        addChild(backButton)

        // back button
        let nodesDic = nodes()

        var format = "H:|[\(BackButtonName)(80)]"
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodesDic)
        self.addConstraints(constraints)
        format = "V:[\(BackButtonName)(80)]|"
        constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodesDic)
        self.addConstraints(constraints)
    }

    override func didChangeSize(oldSize: CGSize) {
        layoutNodes()
    }

    #if os(iOS)
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.allObjects.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        handleTouchBeganAtLocation(touchLocation)
    }
    #else
    override func mouseDown(theEvent: NSEvent) {
        var touchLocation = theEvent.locationInNode(self)
        handleTouchBeganAtLocation(CGPoint(x: touchLocation.x, y: CGRectGetHeight(self.frame) - touchLocation.y))
    }
    #endif

    func handleTouchBeganAtLocation(location: CGPoint) {
        // override in subclasses
    }

    func touchedBack(location: CGPoint) -> Bool {
        return (CGRectContainsPoint(childNodeWithName(BackButtonName)!.frame, location))
    }

    func goBack() {
        let skView = self.view! as SKView
        var scene = MainScene(size: view!.frame.size)
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }
}