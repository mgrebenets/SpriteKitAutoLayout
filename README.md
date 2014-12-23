# SpriteKitAutoLayout

[![CI Status](http://img.shields.io/travis/maksym.grebenets/SpriteKitAutoLayout.svg?style=flat)](https://travis-ci.org/maksym.grebenets/SpriteKitAutoLayout)
[![Version](https://img.shields.io/cocoapods/v/SpriteKitAutoLayout.svg?style=flat)](http://cocoadocs.org/docsets/SpriteKitAutoLayout)
[![License](https://img.shields.io/cocoapods/l/SpriteKitAutoLayout.svg?style=flat)](http://cocoadocs.org/docsets/SpriteKitAutoLayout)
[![Platform](https://img.shields.io/cocoapods/p/SpriteKitAutoLayout.svg?style=flat)](http://cocoadocs.org/docsets/SpriteKitAutoLayout)

SpriteKitAutoLayout (SKAL) is a framework that brings the power of [Auto Layout](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/Introduction/Introduction.html) into your [SpriteKit](https://developer.apple.com/library/ios/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Introduction/Introduction.html) apps.

[![SpriteKitAutoLayout](http://img.youtube.com/vi/5BaXF5eCJp4/0.jpg)](http://www.youtube.com/watch?v=5BaXF5eCJp4)

## Good / Bad For
SpriteKitAutoLayout is **good** for the same purpose it's good with UIKit or AppKit, that is to layout your app UI elements, such as buttons, labels, etc. Auto Layout will handle your UI layout when your scene size changes (on rotation for iOS or window resize on OSX).

It is **not good** for things that don't need any layout as such. For example a sprite that represents one of your (game) characters, which moves around, changes it's scale, rotates and does other crazy things.

## Installation

SpriteKitAutoLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "SpriteKitAutoLayout"

## Usage

Start with including the header file.

    #import <SpriteKitAutoLayout/SpriteKitAutoLayout.h>

Put it in your Bridging Header if your project is Swift project.

That's pretty much it in regards to configuration, now you can use Auto Layout for SpriteKit nodes the same way you do that for UIKit/AppKit views.

The major difference is that you have to set `autoLayoutEnabled` to `true`, this is similar to setting `translatesAutoresizingMaskIntoConstraints` to `NO` in UIKit/AppKit.

    import SpriteKit

    class DemoScene: SKScene {
        override func didMoveToView(view: SKView) {
            self.scaleMode = .ResizeFill
            self.name = "DemoScene"

            // Add label to put it left bottom corner
            let leftBottomLabel = SKLabelNode()
            leftBottomLabel.text = "Left Bottom"
            leftBottomLabel.name = "leftBottomLabel"    // a C language identifier
            leftBottomLabel.autoLayoutEnabled = true    // enable autolayout for this node
            addChild(leftBottomLabel)

            // Add color sprite with non-default anchor point to put in the center
            let centerSprite = SKSpriteNode(color: SKColor.greenColor(), size: CGSizeZero)
            centerSprite.name = "centerSprite"
            centerSprite.anchorPoint = CGPoint(x: 1, y: 1)  // non-default anchor point
            centerSprite.autoLayoutEnabled = true
            addChild(centerSprite)

            // Get dictionary of all nodes in this scene
            let nodesDic = nodes()  // self. is implied

            // Configure Auto Layout constraints

            // Pin label to left bottom corner, use label's intrinsic size
            let width = Float(leftBottomLabel.frame.width)
            var format = "H:|[leftBottomLabel(\(width)]"
            var constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodesDic)
            addConstraints(constraints) // add constraints

            let height = Float(leftBottomLabel.frame.height)
            format = "V:|[leftBottomLabel(\(height)]"
            constraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: .DirectionLeadingToTrailing, metrics: nil, views: nodesDic)
            addConstraints(constraints) // add constraints

            // Put color sprite in the center
            // Make it's size related to parent (aka "superview")

            // Constraint center (x, y) to parent's (x, y)
            // it's save to do it here because parent is skene filling whole SKView
            var constraint = NSLayoutConstraint(item: centerSprite, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
            addConstraint(constraint)
            constraint = NSLayoutConstraint(item: centerSprite, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
            addConstraint(constraint)

            // Make the the centerSprite's width to be 20% of the parent's width
            constraint = NSLayoutConstraint(item: centerSprite, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.2, constant: 0)
            addConstraint(constraint)

            // Make the centerSprite's height to be equal to centerSprite's width
            constraint = NSLayoutConstraint(item: centerSprite, attribute: .Height, relatedBy: .Equal, toItem: centerSprite, attribute: .Height, multiplier: 1, constant: 0)
            centerSprite.addConstraint(constraint)  // centerSprite's constraint on itself
        }

        override func didChangeSize(oldSize: CGSize) {
            layoutNodes()
        }
    }

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Just like SpriteKit itself SpriteKitAutoLayout is available both for iOS and OSX platforms.

- Min iOS version is 7.0
- Min OSX version is 10.9

## Author

Maksym Grebenets, mgrebenets@gmail.com

## License

SpriteKitAutoLayout is available under the MIT license. See the LICENSE file for more info.

