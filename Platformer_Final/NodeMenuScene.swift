//
//  NodeMenuScene.swift
//  Platformertest
//
//  Created by Daphnis Labs on 13/03/15.
//  Copyright (c) 2015 Daphnis. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

let BackgroundImage = "BG"
let FontFile = "Mackinaw1"

let sKCropNode = "SKCropNode"

let sKEmitterNode = "SKEmitterNode"

let sKLightNode = "SKLightNode"
let sKShapeNode = "SKShapeNode"
let sKVideoNode = "SKVideoNode"



class NodeMenuScene: SKScene
{
    
    let transitionEffect = SKTransition.flipHorizontalWithDuration(1.0)
    var labelNode : SKNode?
    var backgroundNode : SKNode?
    
    var backbutton = SKLabelNode(fontNamed: FontFile)
    var menuSceneInstance : MenuScene?
    
//====================================================================================================================//
    
    override func didMoveToView(view: SKView)
    {
        backgroundNode = getBackgroundNode()
        backgroundNode!.zPosition = 0
        self.addChild(backgroundNode!)
        labelNode = getLabelNode()
        labelNode?.zPosition = 1
        self.addChild(labelNode!)
       addBackBtn()

        
    }

//====================================================================================================================//

    func getBackgroundNode() -> SKNode
    {
        var bgnode = SKNode()
        var bgSprite = SKSpriteNode(imageNamed: "BG")
        bgSprite.xScale = self.size.width/bgSprite.size.width
        bgSprite.yScale = self.size.height/bgSprite.size.height
        bgnode.addChild(bgSprite)
        return bgnode
    }
    
//====================================================================================================================//
   
    
    func getLabelNode() -> SKNode
    {
        var labelNode = SKNode()
        var cropnode = SKLabelNode(fontNamed: FontFile)
        cropnode.fontColor = UIColor.whiteColor()
        cropnode.name = sKCropNode
        cropnode.text = sKCropNode
        cropnode.position = CGPointMake(CGRectGetMinX(self.frame)+cropnode.frame.width/2, CGRectGetMaxY(self.frame)-cropnode.frame.height)
        labelNode.addChild(cropnode)
        
        
        
        var emitternode = SKLabelNode(fontNamed: FontFile)
        emitternode.fontColor = UIColor.blueColor()
        emitternode.name = sKEmitterNode
        emitternode.text = sKEmitterNode
        emitternode.position = CGPointMake(CGRectGetMinX(self.frame) + emitternode.frame.width/2 , CGRectGetMidY(self.frame) - emitternode.frame.height/2)
        labelNode.addChild(emitternode)
        
        var lightnode = SKLabelNode(fontNamed: FontFile)
        lightnode.fontColor = UIColor.whiteColor()
        lightnode.name = sKLightNode
        lightnode.text = sKLightNode
        lightnode.position = CGPointMake(CGRectGetMaxX(self.frame) - lightnode.frame.width/2 , CGRectGetMaxY(self.frame) - lightnode.frame.height)
        labelNode.addChild(lightnode)
        
        var shapetnode = SKLabelNode(fontNamed: FontFile)
        shapetnode.fontColor = UIColor.greenColor()
        shapetnode.name = sKShapeNode
        shapetnode.text = sKShapeNode
        shapetnode.position = CGPointMake(CGRectGetMaxX(self.frame) - shapetnode.frame.width/2 , CGRectGetMidY(self.frame) - shapetnode.frame.height/2)
        labelNode.addChild(shapetnode)
        
        var videonode = SKLabelNode(fontNamed: FontFile)
        videonode.fontColor = UIColor.blueColor()
        videonode.name = sKVideoNode
        videonode.text = sKVideoNode
        videonode.position = CGPointMake(CGRectGetMaxX(self.frame) - videonode.frame.width/2 , CGRectGetMinY(self.frame) )
        labelNode.addChild(videonode)
        
        return labelNode
    }
    
//====================================================================================================================//

    var once:Bool = true
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        if !once {
            return
        }
        for touch: AnyObject in touches
        {
                let location = touch.locationInNode(self)
                let node = self.nodeAtPoint(location)
                if node.name == sKCropNode {
                    once = false
                    var scene = CropScene()
                    scene.anchorPoint = CGPointMake(0.5, 0.5)
                    scene.scaleMode = .ResizeFill
                    scene.size = self.size
                    self.view?.presentScene(scene, transition:transitionEffect)
                }
                    
                else if node.name == sKEmitterNode {
                    once = false
                    var scene = ParticleScene()
                    scene.anchorPoint = CGPointMake(0.5, 0.5)
                    scene.scaleMode = .ResizeFill
                    scene.size = self.size
                    self.view?.presentScene(scene, transition:transitionEffect)
                }
                else if node.name == sKLightNode {
                    once = false
                    var scene = LightScene()
                    scene.scaleMode = .ResizeFill
                    scene.size = self.size
                    scene.anchorPoint = CGPointMake(0.5, 0.5)
                    self.view?.presentScene(scene , transition:transitionEffect)
                }
                else if node.name == sKShapeNode {
                    once = false
                    var scene = ShapeScene()
                    scene.scaleMode = .ResizeFill
                    scene.size = self.size
                    
                    scene.anchorPoint = CGPointMake(0.5, 0.5)
                    self.view?.presentScene(scene, transition:transitionEffect)
                }
                else if node.name == sKVideoNode {
                    once = false
                    var scene = VideoNodeScene()
                    scene.scaleMode = .ResizeFill
                    scene.size = self.size
                    scene.anchorPoint = CGPointMake(0.5, 0.5)
                    self.view?.presentScene(scene , transition:transitionEffect)
                }
                else if node.name == "BACK"
                {
                    println("You Pressed BACK Button")
                    goToMenuScene()
            }
    
                
            
        }
    }
    
    func goToMenuScene()
    {
        let transitionEffect = SKTransition.flipHorizontalWithDuration(1.0)
        menuSceneInstance = MenuScene(size: self.size , playbutton: "Play", background: "BG")
        menuSceneInstance!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(menuSceneInstance , transition:transitionEffect)
    }
    
    func addBackBtn()
    {
        var backbutton = SKLabelNode(fontNamed: FontFile)
        backbutton.fontColor = UIColor.blueColor()
        backbutton.name = "BACK"
        backbutton.text = "BACK"
        backbutton.position = CGPointMake(CGRectGetMinX(self.frame) + backbutton.frame.width/2 , CGRectGetMinY(self.frame))
        backbutton.zPosition = 3
        self.addChild(backbutton)
    }
    
//====================================================================================================================//

}
