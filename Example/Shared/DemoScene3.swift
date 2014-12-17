//
//  DemoScene3.swift
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 17/12/2014.
//  Copyright (c) 2014 maksym.grebenets. All rights reserved.
//

import SpriteKit

class DemoScene3: CommonScene {
    override func didMoveToView(view: SKView) {
        addBackButton()
    }

    override func handleTouchBeganAtLocation(location: CGPoint) {
        if touchedBack(location) {
            goBack()
        }
    }
}

