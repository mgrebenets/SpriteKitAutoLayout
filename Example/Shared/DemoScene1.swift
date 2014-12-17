//
//  DemoScene1.swift
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 14/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

import SpriteKit

class DemoScene1: CommonScene {
    override func didMoveToView(view: SKView) {
        // TODO:

        addBackButton()

        let label1 = SKLabelNode(text: "H:|[label1(W)] + V:|[label1(H)]")
        label1.setAutoLayoutEnabled(true)
        label1.name = "label1"
        addChild(label1)
        let label2 = SKLabelNode(text: "H:[label2(W)]| + V:[label2(H)]|")
        label2.setAutoLayoutEnabled(true)
        label2.name = "label2"
        addChild(label2)


        // sized sprite with anchor at (0,0)
        let sizeSpriteAnchorZero = SKSpriteNode(color: SKColor.greenColor(), size: CGSizeZero)
        sizeSpriteAnchorZero.name = "sizeSpriteAnchorZero"
        sizeSpriteAnchorZero.setAutoLayoutEnabled(true)
        sizeSpriteAnchorZero.anchorPoint = CGPointZero
        addChild(sizeSpriteAnchorZero)

        // sized sprite with default anchor (0.5,0.5)
        let sizeSpriteAnchorDefault = SKSpriteNode(color: SKColor.yellowColor(), size: CGSizeZero)
        sizeSpriteAnchorDefault.name = "sizeSpriteAnchorDefault"
        sizeSpriteAnchorDefault.setAutoLayoutEnabled(true)
        //        sizeSpriteAnchorDefault.anchorPoint = CGPointZero // default is 0.5, 0.5
        addChild(sizeSpriteAnchorDefault)


        // sized sprite with anchor at (1,1)
        let sizeSpriteAnchorOneOne = SKSpriteNode(color: SKColor.blueColor(), size: CGSizeZero)
        sizeSpriteAnchorOneOne.name = "sizeSpriteAnchorOneOne"
        sizeSpriteAnchorOneOne.setAutoLayoutEnabled(true)
        sizeSpriteAnchorOneOne.anchorPoint = CGPointMake(1, 1)
        addChild(sizeSpriteAnchorOneOne)

        // sized sprite with anchor at (0,1)
        let sizeSpriteAnchorZeroOne = SKSpriteNode(color: SKColor.redColor(), size: CGSizeZero)
        sizeSpriteAnchorZeroOne.name = "sizeSpriteAnchorZeroOne"
        sizeSpriteAnchorZeroOne.setAutoLayoutEnabled(true)
        sizeSpriteAnchorZeroOne.anchorPoint = CGPointMake(0, 1)
        addChild(sizeSpriteAnchorZeroOne)

        // sized sprite with anchor at (0.5,0)
        let sizeSpriteAnchorHalfZero = SKSpriteNode(color: SKColor.purpleColor(), size: CGSizeZero)
        sizeSpriteAnchorHalfZero.name = "sizeSpriteAnchorHalfZero"
        sizeSpriteAnchorHalfZero.setAutoLayoutEnabled(true)
        sizeSpriteAnchorHalfZero.anchorPoint = CGPointMake(0.5, 0)
        addChild(sizeSpriteAnchorHalfZero)

        // sized sprite with anchor at (0.2,0.65)
        let sizeSpriteAnchorCustom = SKSpriteNode(color: SKColor.cyanColor(), size: CGSizeZero)
        sizeSpriteAnchorCustom.name = "sizeSpriteAnchorCustom"
        sizeSpriteAnchorCustom.setAutoLayoutEnabled(true)
        sizeSpriteAnchorCustom.anchorPoint = CGPointMake(0.2, 0.65)
        addChild(sizeSpriteAnchorCustom)

        // sizeless node that contains buttons
        let buttonsNode = SKNode()
        buttonsNode.name = "buttonsNode"
        buttonsNode.setAutoLayoutEnabled(true)
        addChild(buttonsNode)


        // All the nodes are added, cached child nodes dictionary ro reuse later
        let nodesDic = nodes()

        var format = ""
        var constraints = [AnyObject]()

        // labels layout
        format = "H:|[label1(\(Float(label2.frame.width)))]"
        constraints = SKALLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodesDic)
        self.addConstraints(constraints)
        format = "V:|[label1(\(Float(label2.frame.height)))]"
        constraints = SKALLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodesDic)
        self.addConstraints(constraints)

        format = "H:[label2(\(Float(label2.frame.width)))]|"
        constraints = SKALLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodesDic)
        self.addConstraints(constraints)

        format = "V:[label2(\(Float(label2.frame.height)))]|"
        constraints = SKALLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodesDic)
        self.addConstraints(constraints)

        // put all sized and anchored color sprites in the top right corner
        // give them all different size to see how they align there

        let sizedSpritesLayoutData = [
            (name: "sizeSpriteAnchorZero", size: 120),
            (name: "sizeSpriteAnchorDefault", size: 100),
            (name: "sizeSpriteAnchorOneOne", size: 80),
            (name: "sizeSpriteAnchorZeroOne", size: 60),
            (name: "sizeSpriteAnchorHalfZero", size: 40),
            (name: "sizeSpriteAnchorCustom", size: 20),
        ]

        for data in sizedSpritesLayoutData {
            var format = "H:[\(data.name)(\(Float(data.size)))]|"
            var constraints = SKALLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodesDic)
            self.addConstraints(constraints)

            format = "V:|[\(data.name)(\(Float(data.size)))]"
            constraints = SKALLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodesDic)
            self.addConstraints(constraints)

        }

        // buttons inside buttons node
        var button1 = SKSpriteNode(color: SKColor.redColor(), size: CGSizeZero)
        button1.name = "button1"
        button1.setAutoLayoutEnabled(true)
        var button2 = SKSpriteNode(color: SKColor.brownColor(), size: CGSizeZero)
        button2.name = "button2"
        button2.setAutoLayoutEnabled(true)
        var button3 = SKSpriteNode(color: SKColor.orangeColor(), size: CGSizeZero)
        button3.name = "button3"
        button3.setAutoLayoutEnabled(true)

        let buttons = [button1, button2, button3]
        buttons.map { buttonsNode.addChild($0) }

        let buttonsNodesDic = buttonsNode.nodes()

        // tell buttons node to be in the center
        // by pinning it to superview
        format = "H:|-100-[buttonsNode]-120-|"
        constraints = SKALLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodesDic)
        self.addConstraints(constraints)

        format = "V:|-100-[buttonsNode]-100-|"
        constraints = SKALLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodesDic)
        self.addConstraints(constraints)

        // now tell the buttons to align themselves inside buttons node

        // use width of the parent
        format = "H:|[button1]|"
        constraints = SKALLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: buttonsNodesDic)
        buttonsNode.addConstraints(constraints)
        format = "H:|[button2]|"
        constraints = SKALLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: buttonsNodesDic)
        buttonsNode.addConstraints(constraints)
        format = "H:|[button3]|"
        constraints = SKALLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: buttonsNodesDic)
        buttonsNode.addConstraints(constraints)

        // align vertically using custom padding
        // let the buttons resize their height, make sure height is same for all
        format = "V:|[button1]-40-[button2(button1)]-40-[button3(button1)]|"
        constraints = SKALLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: buttonsNodesDic)
        buttonsNode.addConstraints(constraints)
        
        layoutNodes()
    }

    override func handleTouchBeganAtLocation(location: CGPoint) {
        if touchedBack(location) {
            goBack()
        }
    }
}
