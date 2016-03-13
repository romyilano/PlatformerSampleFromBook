//
//  ScoreList.swift
//  Platformer_Final
//
//  Created by Daphnis Labs on 08/04/15.
//  Copyright (c) 2015 Daphnis. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ScoreList: SKScene,UITextFieldDelegate
{
    var highestScorerName:String = String()
    
    let addPlayerButton = SKSpriteNode(imageNamed:"add-player")
    var menuSceneInstance : MenuScene?
    
    let playerNameTextField = UITextField(frame: CGRectMake(50, 150, 250, 50))
    var scoreScene : AddScoreScene?

//====================================================================================================================//
    
    override func didMoveToView(view: SKView)
    {
        self.playerNameTextField.delegate = self
        addScoresSceneBtn()
        addPlayerNameTextBox()
        addCancelBtn()
        congratsUserAndSaveScorerName()
        
        self.backgroundColor = UIColor.blackColor()
    }
    
//====================================================================================================================//
    
    func textFieldShouldReturn(playerNameTextField: UITextField) -> Bool
    {
        print("Text Field Return Key")
        playerNameTextField.resignFirstResponder()
        return true
    }
    
//====================================================================================================================//
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if node.name == "SCORES"
            {
                if playerNameTextField.text!.isEmpty
                {
                    playerNameTextField.placeholder = "Please Enter the Player Name"
                }
                else
                {
                    self.highestScorerName = self.playerNameTextField.text!
                    NSUserDefaults.standardUserDefaults().setObject(highestScorerName, forKey:"HighestScorerName")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    //goToScoreScene()
                    gotoMenuScreen()
                }
            }
            if node.name == "CANCEL"
            {
               gotoMenuScreen()
            }
        }
    }
    
//====================================================================================================================//
    
    func congratsUserAndSaveScorerName()
    {
        let congratsUserLabel = SKLabelNode(fontNamed: "Chalkduster")
        congratsUserLabel.fontColor = UIColor.redColor()
        congratsUserLabel.name = "CONGRATS"
        congratsUserLabel.color = UIColor.lightGrayColor()
        congratsUserLabel.text = "Congratulations!! "
        congratsUserLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + congratsUserLabel.frame.height * 2)
        congratsUserLabel.zPosition = 3
        self.addChild(congratsUserLabel)
    }
    
//====================================================================================================================//
    
    func goToScoreScene()
    {
        self.playerNameTextField.removeFromSuperview()
        let transitionEffect = SKTransition.flipHorizontalWithDuration(1.0)
        scoreScene = AddScoreScene(size: self.size)
        scoreScene!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(scoreScene! , transition:transitionEffect)
    }
    
//====================================================================================================================//

    func gotoMenuScreen()
    {
        self.playerNameTextField.removeFromSuperview()
        let transitionEffect = SKTransition.flipHorizontalWithDuration(1.0)
        menuSceneInstance = MenuScene(size: self.size , playbutton: "Play", background: "BG")
        menuSceneInstance!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(menuSceneInstance! , transition:transitionEffect)
    }

//====================================================================================================================//

    func addCancelBtn()
    {
        let Cancelbutton = SKLabelNode(fontNamed: FontFile)
        Cancelbutton.fontColor = UIColor.blueColor()
        Cancelbutton.name = "CANCEL"
        Cancelbutton.text = "CANCEL"
        Cancelbutton.position = CGPointMake(CGRectGetMinX(self.frame) + Cancelbutton.frame.width/2 , CGRectGetMinY(self.frame))
        Cancelbutton.zPosition = 3
        self.addChild(Cancelbutton)
    }

//====================================================================================================================//
    
    func addScoresSceneBtn()
    {
        addPlayerButton.name = "SCORES"
        self.addPlayerButton.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMinY(self.frame)/3)
        self.addChild(self.addPlayerButton)
    }
    
//====================================================================================================================//
    
    func addPlayerNameTextBox()
    {
        playerNameTextField.center = CGPointMake(self.size.width / 2, self.size.height / 2)
        playerNameTextField.backgroundColor = UIColor.whiteColor()
        playerNameTextField.placeholder = "Enter Your Name"
        playerNameTextField.borderStyle = UITextBorderStyle.RoundedRect
        self.view?.addSubview(playerNameTextField)
    }

//====================================================================================================================//
    
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
    }
    
//====================================================================================================================//

}


    