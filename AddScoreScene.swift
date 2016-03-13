//
//  ScoreScene.swift
//  Platformer_Final
//
//  Created by Daphnis Labs on 08/04/15.
//  Copyright (c) 2015 Daphnis. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class AddScoreScene: SKScene
{
 
    var menuSceneInstance : MenuScene?
    var savedScorerName: String = String()
    var savedScore: Int = Int()
    
//====================================================================================================================//
    override func didMoveToView(view: SKView)
    {
        self.backgroundColor = UIColor.brownColor()
        showHeighestScores()
        showHeighestScorerName()
        addBackBtn()
    }
    
//====================================================================================================================//
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches
        {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if node.name == "MAIN MENU"
            {
                goToMenuScene()
            }
        }
    }

//====================================================================================================================//
    
    func showHeighestScorerName()
    {
        if(NSUserDefaults.standardUserDefaults().objectForKey("HighestScorerName")) == (nil)
        {
            savedScorerName = "Unknown"
        }
        else
        {
            savedScorerName = NSUserDefaults.standardUserDefaults().objectForKey("HighestScorerName") as! String
            print(savedScorerName)
        }
        
        let highScorerNameLabel = SKLabelNode(fontNamed: "Chalkduster")
        highScorerNameLabel.fontColor = UIColor.whiteColor()
        highScorerNameLabel.name = "HIGHESTSCORERNAME"
        highScorerNameLabel.color = UIColor.lightGrayColor()
        highScorerNameLabel.text = "High Scorer:  \(savedScorerName)"
        highScorerNameLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + (highScorerNameLabel.frame.height * 2))
        highScorerNameLabel.zPosition = 3
        self.addChild(highScorerNameLabel)
    }
    
//====================================================================================================================//
    
    func showHeighestScores()
    {
        if(NSUserDefaults.standardUserDefaults().objectForKey("HighestScore")) == (nil)
        {
            savedScore = 0
        }
        else
        {
            savedScore = NSUserDefaults.standardUserDefaults().objectForKey("HighestScore") as! Int
            print(savedScore)
        }
        
        let highScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        highScoreLabel.fontColor = UIColor.whiteColor()
        highScoreLabel.name = "HIGHESTSCORE"
        highScoreLabel.color = UIColor.lightGrayColor()
        highScoreLabel.text = "The Score is: \(savedScore)"
        highScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        highScoreLabel.zPosition = 3
        self.addChild(highScoreLabel)
    }
    
//====================================================================================================================//
    
    func addBackBtn()
    {
        let mainMenubutton = SKLabelNode(fontNamed: "Chalkduster")
        mainMenubutton.fontColor = UIColor.blueColor()
        mainMenubutton.name = "MAIN MENU"
        mainMenubutton.text = "MAIN MENU"
        mainMenubutton.position = CGPointMake(CGRectGetMinX(self.frame) + mainMenubutton.frame.width/2 , CGRectGetMinY(self.frame))
        mainMenubutton.zPosition = 3
        self.addChild(mainMenubutton)
    }

//====================================================================================================================//

    func goToMenuScene()
    {
        let transitionEffect = SKTransition.flipHorizontalWithDuration(1.0)
        menuSceneInstance = MenuScene(size: self.size , playbutton: "Play", background: "BG")
        menuSceneInstance!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(menuSceneInstance , transition:transitionEffect)
    }
    
//====================================================================================================================//

    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
    }
    
//====================================================================================================================//

}