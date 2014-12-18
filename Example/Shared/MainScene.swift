//
//  MainScene.swift
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 17/12/2014.
//  Copyright (c) 2014 maksym.grebenets. All rights reserved.
//

import SpriteKit

class MainScene: CommonScene {
    override func didMoveToView(view: SKView) {

        self.name = "MainScene"

        for i in 1...3 {
            var label = SKLabelNode()
            label.text = "Demo \(i)"
            label.name = "label\(i)"
            label.horizontalAlignmentMode = .Right
            label.verticalAlignmentMode = .Baseline
            label.autoLayoutEnabled = true
            addChild(label)

            var c = NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 1)
            addConstraint(c)
        }

        var format = "V:|-20-[label1]-20-[label2(label1)]-20-[label3(label1)]-40-|"
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodes())
        addConstraints(constraints)

//        layoutNodes()
    }

    override func handleTouchBeganAtLocation(location: CGPoint) {

        var scene: SKScene!

        if (CGRectContainsPoint(childNodeWithName("label1")!.frame, location)) {
            scene = DemoScene1(size: view!.frame.size)
        } else if (CGRectContainsPoint(childNodeWithName("label2")!.frame, location)) {
            scene = DemoScene2(size: view!.frame.size)
        } else if (CGRectContainsPoint(childNodeWithName("label3")!.frame, location)) {
            scene = DemoScene3(size: view!.frame.size)
        }

        if let scene = scene {
            let skView = self.view! as SKView
            scene.scaleMode = .ResizeFill
            println("===Subviews count before: \(skView.subviews.count)")
//            println("===Constraints count before: \(skView.constraints().count)")
            skView.presentScene(scene)
            println("===Subviews count after: \(skView.subviews.count)")
//            println("===Constraints count after: \(skView.constraints().count)")            
        }
    }
}
