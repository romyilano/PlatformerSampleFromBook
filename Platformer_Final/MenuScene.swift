//
//  MenuScene.swift
//  Platformer_Final
//
//  Created by Daphnis Labs on 13/03/15.
//  Copyright (c) 2015 Daphnis. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MenuScene: SKScene
{
    // SCORE MENU
    var scoreScene : AddScoreScene?
    var gameScene : GameScene?
    
    var shaderSceneInstance : ShaderDemo?
    var nodeMenuSceneInstance : NodeMenuScene?
    var tintChanger : Float?
    
    let testingTexture : SKTexture
    
    //#1
    let PlayButton: SKSpriteNode
    let Background: SKSpriteNode
    
    //#2
    
    init(size:CGSize, playbutton:String, background:String)
    {
        PlayButton = SKSpriteNode(imageNamed: playbutton)
        Background = SKSpriteNode(imageNamed: background)
        PlayButton = SKSpriteNode(imageNamed: playbutton)
        testingTexture = SKTexture(imageNamed: playbutton)
        super.init(size:size)
    }

    
//    init(size:CGSize, playbutton:String, background:String) {
//        PlayButton = SKSpriteNode(imageNamed: playbutton)
//        Background = SKSpriteNode(imageNamed: background)
//        
//        super.init(size:size)
//    }
    
    //#3
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

//====================================================================================================================//
    
    
    //#4
    override func didMoveToView(view: SKView)
    {
        println("You are in a MenuScene")
        addChildToScene();
        
        PlayButton.name = "PLAY"
        //generateTestTexture()
        addShaderSceneBtn()
        addNodeMenuSceneBtn()
        addScoreSceneBtn()
    }
//====================================================================================================================//
    
    func generateTestTexture()
    {
       for var i = 0 ; i < 10; i++
       {
            var temp = SKSpriteNode(texture: testingTexture)
            temp.xScale = 100/temp.size.width
            temp.yScale = 50/temp.size.height
            temp.zPosition = 2
           // println(self.size)
            temp.position = CGPointMake(-self.size.width + CGFloat (100 * i), -self.size.height/2)
            addChild(temp)
        }
    }

//====================================================================================================================//
    
    //#5
    func addChildToScene()
    {
        PlayButton.zPosition = 1
        Background.zPosition = 0
        PlayButton.color = UIColor.redColor()

        Background.size = CGSize(width:self.size.width, height:self.size.height)
        
//        Background.position = CGPointMake(-self.size.width/2, -self.size.height/2)
//        PlayButton.position = CGPointMake(-self.size.width/2, -self.size.height/2)

        addChild(PlayButton)
        addChild(Background)
    }
//====================================================================================================================//

    
    //#6
    override func update(currentTime: NSTimeInterval)
    {
        tintPlayButton()

    }
//====================================================================================================================//
    var once:Bool = true
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        for touch: AnyObject in touches
        {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
//            if node.name == "BACK"
//            {
//                if once
//                {
//                    once = false
//                    let transitionEffect = SKTransition.flipHorizontalWithDuration(1.0)
//                    var scene = MenuScene()
//                    scene.anchorPoint = CGPointMake(0.5, 0.5)
//                    scene.scaleMode = .ResizeFill
//                    scene.size = self.size
//                    self.view?.presentScene(scene, transition:transitionEffect)
//                }
//            }
            
            
            if node.name == PlayButton.name
            {
                goToGameScene()
                //goToShaderScene()
                
            }
            else if node.name == "SHADOWS"
            {
              goToShaderScene()
            }
            else if node.name == "NODEMENU"
            {
                goToNodeMenuScene()
                
            }
            else if node.name == "SCOREMENU"
            {
                goToScoreScene()
                
            }
            
            
        }
    }
    
    func goToScoreScene()
    {
        let transitionEffect = SKTransition.flipHorizontalWithDuration(1.0)
        scoreScene = AddScoreScene(size: self.size) // , playbutton: "Play", background: "BG")
        scoreScene!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(scoreScene , transition:transitionEffect)
        
    }
    //====================================================================================================================//
 
//====================================================================================================================//
    
    func goToGameScene()
    {
        let transitionEffect = SKTransition.flipHorizontalWithDuration(1.0)
        gameScene = GameScene(size: self.size)
        gameScene!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(gameScene , transition:transitionEffect)
        
    }
//====================================================================================================================//
    
    func goToShaderScene()
    {
        let transitionEffect = SKTransition.flipHorizontalWithDuration(1.0)
        shaderSceneInstance = ShaderDemo(size: self.size)
        shaderSceneInstance!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(shaderSceneInstance , transition:transitionEffect)
        
    }
//====================================================================================================================//
    
    func goToNodeMenuScene()
    {
        let transitionEffect = SKTransition.flipHorizontalWithDuration(1.0)
        nodeMenuSceneInstance = NodeMenuScene(size: self.size)
        nodeMenuSceneInstance!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(nodeMenuSceneInstance , transition:transitionEffect)
    }
//====================================================================================================================//
    
    func tintPlayButton()
    {
        if PlayButton.colorBlendFactor >= 1
        {
            tintChanger = -0.02
        }
        else if PlayButton.colorBlendFactor <= 0
        {
            tintChanger = 0.02
        }
        PlayButton.colorBlendFactor += CGFloat(tintChanger!)
    }
//====================================================================================================================//
    
    func addShaderSceneBtn()
    {
        var backbutton = SKLabelNode(fontNamed: FontFile)
        backbutton.fontColor = UIColor.blueColor()
        backbutton.name = "SHADOWS"
        backbutton.text = "SHADOW EFFECT"
        backbutton.position = CGPointMake(CGRectGetMinX(self.frame) + backbutton.frame.width/2 , CGRectGetMinY(self.frame) )
        backbutton.zPosition = 3
        self.addChild(backbutton)
    }
//====================================================================================================================//
    
    func addNodeMenuSceneBtn()
    {
        var backbutton = SKLabelNode(fontNamed: FontFile)
        backbutton.fontColor = UIColor.blueColor()
        backbutton.name = "NODEMENU"
        backbutton.text = "NODE MENU SCENE"
        backbutton.position = CGPointMake(CGRectGetMinX(self.frame) + backbutton.frame.width*2 , CGRectGetMaxY(self.frame) - backbutton.frame.width/8)
        backbutton.zPosition = 3
        self.addChild(backbutton)
    }

    
    //====================================================================================================================//
    func addScoreSceneBtn()
    {
        var scoreButton = SKLabelNode(fontNamed: FontFile)
        scoreButton.fontColor = UIColor.blueColor()
        scoreButton.name = "SCOREMENU"
        scoreButton.text = "SCORE MENU"
        scoreButton.position = CGPointMake(CGRectGetMinX(self.frame)+scoreButton.frame.width/2, CGRectGetMaxY(self.frame) - scoreButton.frame.height)
        scoreButton.zPosition = 3
        self.addChild(scoreButton)
    }
    
    
    //====================================================================================================================//

    
}