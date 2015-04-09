//
//  CropScene.swift
//  Platformertest
//
//  Created by Daphnis Labs on 13/03/15.
//  Copyright (c) 2015 Daphnis. All rights reserved.
//

import Foundation
import SpriteKit
class CropScene : SKScene
{
    var play : SKSpriteNode?
     var once:Bool = true
    
//====================================================================================================================//
    
    override func didMoveToView(view: SKView)
    {
        play = SKSpriteNode(imageNamed: "Play")
        var crop = SKCropNode()
        crop.maskNode = play
        crop.addChild(SKSpriteNode(imageNamed: "BG"))
        addChild(crop)
        addBackLabel()
    }
  
//====================================================================================================================//

    func addBackLabel()
    {
        var backbutton = SKLabelNode(fontNamed: FontFile)
        backbutton.fontColor = UIColor.blueColor()
        backbutton.name = "BACK"
        backbutton.text = "BACK"
        backbutton.position = CGPointMake(CGRectGetMinX(self.frame) + backbutton.frame.width/2 , CGRectGetMinY(self.frame))
        self.addChild(backbutton)
    }
    
//====================================================================================================================//
   
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if node.name == "BACK" {
                if once {
                    once = false
                    let transitionEffect = SKTransition.flipHorizontalWithDuration(1.0)
                    var scene = NodeMenuScene()
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
