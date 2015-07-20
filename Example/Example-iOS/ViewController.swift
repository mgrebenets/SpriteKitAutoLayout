//
//  ViewController.swift
//  Example-iOS
//
//  Created by Maksym Grebenets on 20/07/2015.
//  Copyright (c) 2015 i4nApps. All rights reserved.
//

import SpriteKit

class ViewController: UIViewController {

    override func loadView() {
        self.view = SKView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true

        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true

        let scene = MainScene(size: skView.bounds.size)
        scene.scaleMode = .ResizeFill

        /* Set the scale mode to scale to fit the window */
        skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .All
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
