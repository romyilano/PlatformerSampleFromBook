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
        let crop = SKCropNode()
        crop.maskNode = play
        crop.addChild(SKSpriteNode(imageNamed: "BG"))
        addChild(crop)
        addBackLabel()
    }
  
//====================================================================================================================//

    func addBackLabel()
    {
        let backbutton = SKLabelNode(fontNamed: "Chalkduster")
        backbutton.fontColor = UIColor.redColor()
        backbutton.name = "BACK"
        backbutton.text = "BACK"
        backbutton.position = CGPointMake(CGRectGetMinX(self.frame) + backbutton.frame.width/2 , CGRectGetMinY(self.frame))
        backbutton.zPosition = 3
        self.addChild(backbutton)
    
    }
    
//====================================================================================================================//
   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if node.name == "BACK"
            {
                if once
                {
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
