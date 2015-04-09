//
//  GameViewController.swift
//  Platformer_Final
//
//  Created by Daphnis Labs on 13/03/15.
//  Copyright (c) 2015 Daphnis. All rights reserved.
//

//import UIKit
import SpriteKit

extension SKNode
{
    class func unarchiveFromFile(file : NSString) -> SKNode?
    {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks")
        {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        }
        else
        {
            return nil
        }
    }
}


class GameViewController: UIViewController
{
    
//====================================================================================================================//

    override func viewDidLoad()
    {
        super.viewDidLoad()
        println("You are in a GameViewController")
        
        let menuscene = MenuScene(size: view.bounds.size, playbutton: "Play", background:"BG")
        let skview = view as SKView
        skview.showsFPS = true
        skview.showsNodeCount = true
        skview.ignoresSiblingOrder = true
        menuscene.scaleMode = .ResizeFill
        menuscene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        skview.presentScene(menuscene)
        
    }
//====================================================================================================================//


    override func shouldAutorotate() -> Bool
    {
        return true
    }
//====================================================================================================================//

    override func supportedInterfaceOrientations() -> Int
    {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        }
        else
        {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
//====================================================================================================================//

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
//====================================================================================================================//

    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
//====================================================================================================================//
    
}
