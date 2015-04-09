//
//  VideoNodeScene.swift
//  Platformertest
//
//  Created by Daphnis Labs on 13/03/15.
//  Copyright (c) 2015 Daphnis. All rights reserved.
//



import Foundation
import SpriteKit
import AVFoundation
class VideoNodeScene : SKScene
{
    var playonce :Bool = false
    var videoNode : SKVideoNode?
    
//====================================================================================================================//

    override func didMoveToView(view: SKView)
    {
        var background = SKSpriteNode(imageNamed: "BG")
        background.zPosition = 0
        var scaleX =  self.size.width/background.size.width
        println(scaleX)
        var scaleY =  self.size.height/background.size.height
        background.xScale = scaleX
        background.yScale = scaleY
        addChild(background)
        var fileurl = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("Movie", ofType: "m4v")!)
        var player = AVPlayer(URL: fileurl)
        videoNode = SKVideoNode(AVPlayer: player)
        videoNode?.size = CGSizeMake(200, 150)
        videoNode?.zPosition = 1
        videoNode?.name = "Video"
        self.addChild(videoNode!)
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

        var once:Bool = true
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if node.name == videoNode?.name {
                if !playonce {
                    videoNode?.play()
                    playonce = true
                }
                
            }
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
