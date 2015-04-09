//
//  ShaderDemo.swift
//  Platformer_Final
//
//  Created by Daphnis Labs on 25/03/15.
//  Copyright (c) 2015 Daphnis. All rights reserved.
//

import Foundation
import SpriteKit


class ShaderDemo : SKScene
{
    var menuSceneInstance : MenuScene?
    var backbutton = SKLabelNode(fontNamed: FontFile)
 
//====================================================================================================================//

    override func didMoveToView(view: SKView)
    {
        
        let box = SKSpriteNode(imageNamed: "box")
        let pattern = SKShader(fileNamed: "blurShade.fsh")
        let location = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        box.position = location
        
        box.shader = pattern
        self.addChild(box)
        addBackLabel()
        
    }
//====================================================================================================================//
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        for touch: AnyObject in touches
        {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if self.backbutton.containsPoint(location)
            {
                gotoMenuScreen()
            }
        }
    }
//====================================================================================================================//
    
    func gotoMenuScreen()
    {
        let transitionEffect = SKTransition.flipVerticalWithDuration(2)
        menuSceneInstance = MenuScene(size: self.size , playbutton: "Play", background: "BG")
        menuSceneInstance!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(menuSceneInstance , transition:transitionEffect)
        
    }
//====================================================================================================================//
    
    func addBackLabel()
    {
        
        backbutton.fontColor = UIColor.blueColor()
        backbutton.name = "BACK"
        backbutton.text = "BACK"
        backbutton.position = CGPointMake(CGRectGetMinX(self.frame) + backbutton.frame.width/2 , CGRectGetMinY(self.frame))
        backbutton.zPosition = 3
        self.addChild(backbutton)
    }
//====================================================================================================================//
    
}


