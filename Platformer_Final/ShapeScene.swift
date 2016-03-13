//
//  ShapeScene.swift
//  Platformertest
//
//  Created by Daphnis Labs on 13/03/15.
//  Copyright (c) 2015 Daphnis. All rights reserved.
//

import Foundation
import SpriteKit

class ShapeScene : SKScene
{
    
//====================================================================================================================//

    override func didMoveToView(view: SKView)
    {
        let shape = SKShapeNode()
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 0, 0)
        CGPathAddLineToPoint(path, nil, 10  , 100)
        CGPathAddLineToPoint(path, nil, 20, 0)
        CGPathAddLineToPoint(path, nil, 10, -10)
        CGPathAddLineToPoint(path, nil, 0, 0)
        shape.path = path
        shape.fillColor = UIColor.redColor()
        shape.lineWidth = 4
        addChild(shape)
        addBackLabel()
    }
    
//====================================================================================================================//

    func addBackLabel()
    {
        let backbutton = SKLabelNode(fontNamed: FontFile)
        backbutton.fontColor = UIColor.blueColor()
        backbutton.name = "BACK"
        backbutton.text = "BACK"
        backbutton.position = CGPointMake(CGRectGetMinX(self.frame) + backbutton.frame.width/2 , CGRectGetMinY(self.frame))
        self.addChild(backbutton)
    }
    
//====================================================================================================================//

    var once:Bool = true
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if node.name == "BACK" {
                if once {
                    once = false
                    let transitionEffect = SKTransition.flipHorizontalWithDuration(1.0)
                    let scene = NodeMenuScene()
                    scene.anchorPoint = CGPointMake(0.5, 0.5)
                    scene.scaleMode = .ResizeFill
                    scene.size = self.size
                    self.view?.presentScene(scene, transition:transitionEffect)
                }
            }
        }
    }
    
//====================================================================================================================//

}
