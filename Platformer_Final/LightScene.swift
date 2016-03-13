//
//  LightScene.swift
//  Platformertest
//
//  Created by Daphnis Labs on 13/03/15.
//  Copyright (c) 2015 Daphnis. All rights reserved.
//

import Foundation
import SpriteKit
class LightScene : SKScene
{
    var lightNode : SKLightNode?
    var once:Bool = true
    
//====================================================================================================================//

    override func didMoveToView(view: SKView)
    {
        let background = SKSpriteNode(imageNamed: "BG")
        background.zPosition = 0.5
        let scaleX =  self.size.width/background.size.width
        let scaleY =  self.size.height/background.size.height
        background.xScale = scaleX
        background.yScale = scaleY
        addChild(background)
        print(background.size)
        
        let playbutton = SKSpriteNode(imageNamed: "Play")
        playbutton.zPosition = 1
        playbutton.size = CGSizeMake(100, 100)
        playbutton.position = CGPointMake(-200, 0)
        addChild(playbutton)
        
        let playbutton2 = SKSpriteNode(imageNamed: "Play")
        playbutton2.zPosition = 1
        playbutton2.size = CGSizeMake(100, 100)
        playbutton2.position = CGPointMake(0, 100)
        addChild(playbutton2)
        
        let playbutton3 = SKSpriteNode(imageNamed: "Play")
        playbutton3.zPosition = 1
        playbutton3.size = CGSizeMake(100, 100)
        playbutton3.position = CGPointMake(200, 0)
        addChild(playbutton3)
        
        lightNode = SKLightNode()
        lightNode!.categoryBitMask = 1
        lightNode!.falloff = 1
        lightNode!.ambientColor = UIColor.greenColor()
        lightNode!.lightColor = UIColor.redColor()
        lightNode!.shadowColor = UIColor.blueColor()
        lightNode!.zPosition = 1
        addChild(lightNode!)
        
        playbutton.shadowCastBitMask = 1
        playbutton2.shadowCastBitMask = 1
        playbutton3.shadowCastBitMask = 1
        background.lightingBitMask = 1;
        addBackLabel()
    }
    
//====================================================================================================================//

    func addBackLabel()
    {
        let backbutton = SKLabelNode(fontNamed: "Chalkduster")
        backbutton.fontColor = UIColor.blueColor()
        backbutton.name = "BACK"
        backbutton.text = "BACK"
        backbutton.position = CGPointMake(CGRectGetMinX(self.frame) + backbutton.frame.width/2 , CGRectGetMinY(self.frame))
        backbutton.zPosition = 3
        self.addChild(backbutton)
    }
    
//====================================================================================================================//

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch : AnyObject in touches {
            let location = touch.locationInNode(self)
            lightNode!.position = location
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
