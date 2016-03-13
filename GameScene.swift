//
//  GameScene.swift
//  Platformer_Final
//
//  Created by Daphnis Labs on 13/03/15.
//  Copyright (c) 2015 Daphnis. All rights reserved.
//

import Foundation
import SpriteKit
import SceneKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate, AVAudioPlayerDelegate
{
    var numberOfBlocksCrosssed = 0
    
    // ADDING LEVELS
    let levelLabel = SKLabelNode(fontNamed: "Chalkduster")
    var level = 1
    
    var highScorerListInstance : ScoreList?
    var highestScore:Int = Int()
    var highestScorer:String = String()
    var savedScore: Int = Int()
    
    // ADDING SOUND EFFECT
    var avPlayer:AVAudioPlayer!
    let backgroundSound = "game_music"
    let gameOutSound = "Strong_Punch-Mike_Koenig-574430706"
    
    // ADDING A PAUSE BUTTON
    var pauseBtn:SKSpriteNode = SKSpriteNode(imageNamed: "PLAY-PAUSE")
    
    // ADD SCORE
    let scoreText = SKLabelNode(fontNamed: "Chalkduster")
    var score = 0
    
    var menuSceneInstance : MenuScene?
    let backgroundNode = SKSpriteNode(imageNamed: "BG")
    var spriteWithoutTexture : SKSpriteNode?
    let myAtlas = SKTextureAtlas(named: "idle.atlas")
    
    // IMAGE ATLAS FOR PLAYER RUNNING ACTION #8
    let atlasForPlayerRun = SKTextureAtlas(named:"bro5_run.atlas")
    var player:SKSpriteNode = SKSpriteNode()
    var currentno = 0
    
    // CREATING JUMP ACTION WITH BUTTON Chapter 6
    var btnJump:SKSpriteNode = SKSpriteNode(imageNamed: "jump")
    
    // PARTICLE EFFECT WHEN PLAYER DIES CHAPTER 7
    var particlePlayerNode = SKEmitterNode(fileNamed: "ParticleEffectPlayerCollide.sks")
  
    
    // SETTING UP "RUNNING BAR", "BLOCK 1", "Block 2" in CHAPTER 5
    let runningBar = SKSpriteNode(imageNamed:"bar")
    let block1 = SKSpriteNode(imageNamed:"block1")
    let block2 = SKSpriteNode(imageNamed:"block2")
    var origRunningBarPositionX = CGFloat(0)
    var maxBarX = CGFloat(0)
    var groundSpeed = 5
    var playerBaseline = CGFloat(0)
    var onGround = true
    
    // INITIALIZING PHYSICAL PROPERTIES VALUES
    var velocityY = CGFloat(0)
    let gravity = CGFloat(0.6)
    var blockMaxX = CGFloat(0)
    var origBlockPositionX = CGFloat(0)
    var blockStatuses:Dictionary<String,BlockStatus> = [:]
    
    
    //COLLISION TYPE BETWEEN "BLOCKS" AND "PLAYER"
    enum ColliderType:UInt32
    {
        case player = 1
        case Block = 2
    }
    
//====================================================================================================================//
    
    //#1
    override func didMoveToView(view: SKView)
    {
        if(NSUserDefaults.standardUserDefaults().objectForKey("HighestScore")) == (nil)
        {
            self.highestScore = 0
        }
        else
        {
            self.highestScore = NSUserDefaults.standardUserDefaults().objectForKey("HighestScore") as! Int
            
        }
        print(savedScore)
       
        readFileIntoAVPlayer(backgroundSound, ext: "mp3")
        
        player = SKSpriteNode(texture:atlasForPlayerRun.textureNamed("bro5_run0001.png"))
        runForwardTexture()
        
        //#2
        self.physicsWorld.contactDelegate = self
        
        // JUMP BUTTON POSITION SETTING AND ADDING ONTO THE SCREEN
        self.btnJump.position = CGPointMake(-(self.size.width/2.3), -(self.size.height/4))
        self.btnJump.zPosition = 1
        self.addChild(btnJump)

       //PROPERTIES FOR PARTICLE NODE      CHAPTER 7
        self.particlePlayerNode.zPosition = 1
        self.particlePlayerNode.hidden = true
        self.player.addChild(self.particlePlayerNode)
        
        //#3
        addBackGround()
        addRunningBar()
        addPlayer()
        addScoreLabel()
        addLevelLabel()
        addBlocks()
        //addSpriteWithoutTexture()
        
        addPlayPauseButton()
    }
//====================================================================================================================//
    func readFileIntoAVPlayer(soundName:String, ext:String)
    {
        var error: NSError?
//        if self.soundName != nil
//        {
            let fileURL:NSURL = NSBundle.mainBundle().URLForResource(soundName, withExtension: ext)!
            
        do {
            self.avPlayer = try AVAudioPlayer(contentsOfURL: fileURL)
        } catch let error1 as NSError {
            error = error1
            self.avPlayer = nil
        }
            if avPlayer == nil
            {
                if let e = error
                {
                    print(e.localizedDescription)
                }
            }
            
            if avPlayer.playing
            {
                avPlayer.stop()
            }
            
            print("playing \(fileURL)")
            avPlayer.delegate = self
            avPlayer.prepareToPlay()
            avPlayer.volume = 1.0
            avPlayer.play()
//        }
    }

//====================================================================================================================//

    func addLevelLabel()
    {
        self.levelLabel.text = "Level: 1"
        self.levelLabel.fontSize = 30
        self.levelLabel.zPosition = 3
        self.levelLabel.position = CGPointMake(CGRectGetMidX(self.frame) + scoreText.frame.width , CGRectGetMidY(self.frame) + levelLabel.frame.height * 4.2)
        self.addChild(self.levelLabel)
    }

//====================================================================================================================//
    
    func addScoreLabel()
    {
        self.scoreText.text = "Score: 0"
        self.scoreText.fontSize = 30
        self.scoreText.zPosition = 3
        self.scoreText.position = CGPointMake(CGRectGetMinX(self.frame) + scoreText.frame.width / 1.8  , CGRectGetMidY(self.frame) + scoreText.frame.height * 4.2)
        self.addChild(self.scoreText)
    }
    
//====================================================================================================================//
 
    func addPlayPauseButton()
    {
        //self.runAction(sound)
        self.pauseBtn.name = "PAUSE"
        self.pauseBtn.zPosition = 3
        self.pauseBtn.position = CGPointMake(CGRectGetMaxX(self.frame) - pauseBtn.frame.width/2 , CGRectGetMaxY(self.frame) - pauseBtn.frame.height/2)
        self.addChild(pauseBtn)
        
    }
//====================================================================================================================//
    
    // ATLAS IMAGES METHOD FOR PLAYER RUNNING ACTION #8
    func runForwardTexture()
    {
        let hero_run_anim = SKAction.animateWithTextures([
           
            atlasForPlayerRun.textureNamed("bro5_run0002.png"),
            atlasForPlayerRun.textureNamed("bro5_run0002.png"),
            atlasForPlayerRun.textureNamed("bro5_run0003.png"),
            atlasForPlayerRun.textureNamed("bro5_run0004.png"),
            atlasForPlayerRun.textureNamed("bro5_run0005.png"),
            atlasForPlayerRun.textureNamed("bro5_run0006.png"),
            atlasForPlayerRun.textureNamed("bro5_run0007.png")
            ], timePerFrame: 0.06)
        
        let run = SKAction.repeatActionForever(hero_run_anim)
        
        player.runAction(run, withKey: "running")
    }
    
   //====================================================================================================================//
    
    // #4
    // GENERATING NODES RANDOMLY (TAKING NUMBERS BETWEEN 50_200 RANDOMLY)
    func random() -> UInt32
    {
        let range = UInt32(50)..<UInt32(200)
        return range.startIndex + arc4random_uniform(range.endIndex - range.startIndex + 1)    //CREATING BLOCKS FROM A LIBRARY METHODS OF IOS
    }
    
//====================================================================================================================//
    
    func addSpriteWithoutTexture()
    {
        spriteWithoutTexture = SKSpriteNode(texture: nil, color:UIColor.redColor(), size: CGSizeMake(100, 100))
        addChild(spriteWithoutTexture!)
    }
    
//====================================================================================================================//
    
    // ADDING BACKGROUND SCENE
    func addBackGround()
    {
        backgroundNode.zPosition = 0
        let scaleX =  self.size.width/backgroundNode.size.width
        let scaleY =  self.size.height/backgroundNode.size.height
        backgroundNode.xScale = scaleX
        backgroundNode.yScale = scaleY
        addChild(backgroundNode)
    }
    
//====================================================================================================================//

    // USED IN NEXT CHAPTERS RELATED TO "LIGHT SCENE, CROP SCENE, PARTICLE SCENE, SHAPE SCENE"
    
    func changeColor()
    {
        switch(currentno%3){
        case 0:
            spriteWithoutTexture!.color = UIColor.redColor()
        case 1:
            spriteWithoutTexture!.color = UIColor.greenColor()
        case 2:
            spriteWithoutTexture!.color = UIColor.blueColor()
        default :
            spriteWithoutTexture!.color = UIColor.blackColor()
            
        }
    }
    
//====================================================================================================================//
    
    // USED IN NEXT CHAPTERS RELATED TO "LIGHT SCENE, CROP SCENE, PARTICLE SCENE, SHAPE SCENE"
    
    func changePosition()
    {
        switch(currentno%3){
        case 0:
            spriteWithoutTexture!.position = CGPointZero
            
        case 1:
            spriteWithoutTexture!.position = CGPointMake(self.size.width/2-spriteWithoutTexture!.size.width/2, 0)
        case 2:
            spriteWithoutTexture!.position = CGPointMake(-self.size.width/2+spriteWithoutTexture!.size.width/2, 0)
        default :
            spriteWithoutTexture!.position = CGPointMake(0, 0)
            
        }
    }
    
//====================================================================================================================//
    
    //SETTING UP and ADDING PLAYER  (in CHAPTER 5 )
    
    func addPlayer()
    {
        self.player.name = "Player"
        
        // PHYSICS PROPERTIES FOR player
        self.playerBaseline = self.runningBar.position.y + (self.runningBar.size.height / 2) + (self.player.size.height / 2)
        self.player.position = CGPointMake(CGRectGetMinX(self.frame) + self.player.size.width + (self.player.size.width / 4), self.playerBaseline)
        self.player.zPosition = 1
        self.player.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(self.player.size.width / 3))
        self.player.physicsBody?.affectedByGravity = false
        self.player.physicsBody?.categoryBitMask = ColliderType.player.rawValue    // Will become '1' because its defined in "ColliderType" enum
        self.player.physicsBody?.contactTestBitMask = ColliderType.Block.rawValue
        self.player.physicsBody?.collisionBitMask = ColliderType.Block.rawValue
        
        self.addChild(player)
    }
    
//====================================================================================================================//
  
    //SETTING UP and ADDING RUNNING BAR  (in CHAPTER 5 )
    func addRunningBar()
   {
        self.runningBar.anchorPoint = CGPointMake(0, 0.5)
        self.runningBar.zPosition = 3
        self.runningBar.position = CGPointMake(CGRectGetMinX(self.frame),CGRectGetMinY(self.frame) + (self.runningBar.size.height / 2))
        self.origRunningBarPositionX = self.runningBar.position.x
        self.maxBarX = self.runningBar.size.width - self.frame.size.width
        self.maxBarX *= -1
        self.addChild(self.runningBar)
    }
    
//====================================================================================================================//

    //SETTING UP and ADDING BLOCKS  (in CHAPTER 5 )
    func addBlocks()
    {
        // PHYSICS PROPERTIES FOR BLOCK 1
        self.block1.position = CGPointMake(CGRectGetMaxX(self.frame) + self.block1.size.width, self.playerBaseline)
        self.block1.physicsBody = SKPhysicsBody(rectangleOfSize: self.block1.size)
        self.block1.physicsBody?.dynamic = false
        self.block1.physicsBody?.categoryBitMask = ColliderType.Block.rawValue
        self.block1.physicsBody?.contactTestBitMask = ColliderType.player.rawValue
        self.block1.physicsBody?.collisionBitMask = ColliderType.player.rawValue
        
        // PHYSICS PROPERTIES FOR BLOCK 2
        self.block2.position = CGPointMake(CGRectGetMaxX(self.frame) + self.block2.size.width, self.playerBaseline) //+ (self.block1.size.height / 2))
        self.block2.physicsBody = SKPhysicsBody(rectangleOfSize: self.block2.size)
        self.block2.physicsBody?.dynamic = false
        self.block2.physicsBody?.categoryBitMask = ColliderType.Block.rawValue
        self.block2.physicsBody?.contactTestBitMask = ColliderType.player.rawValue
        self.block2.physicsBody?.collisionBitMask = ColliderType.player.rawValue
        
        self.origBlockPositionX = self.block1.position.x   //ORIGINAL BLOCK POSITION (0,0)
        self.block1.name = "block1"   // SETTING BLOCK NAMES
        self.block2.name = "block2"
        
        // ADDING BLOCK 1 and BLOCK 2 to DICTIONARY BLOCKSTATUS 
        blockStatuses["block1"] = BlockStatus(isRunning: false, timeGapForNextRun: random(), currentInterval: UInt32(0))
        blockStatuses["block2"] = BlockStatus(isRunning: false, timeGapForNextRun: random(), currentInterval: UInt32(0))
        
        self.blockMaxX = 0 - self.runningBar.size.width / 2.5 //0 - self.block1.size.width / 0.2
        print(self.blockMaxX)
        
        self.addChild(self.block1)
        self.addChild(self.block2)
    }

//====================================================================================================================//
   
    // #5
    // CALLED WHEN TOUCH HAS BEGAN ON GameScene
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches
        {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if node.name == player.name
            {
                //currentno++
                
                if self.onGround
                {
                       self.velocityY = -18.0
                       self.onGround = false
                 }
            }
            
            // JUMP BUTTON ACTION
            if self.btnJump.containsPoint(location)
            {
                print("Jump Tapped!")
                if self.onGround
                {
                    self.velocityY = -18.0
                    self.onGround = false
                }
            }
            if self.pauseBtn.containsPoint(location)
            {
                if(self.view?.paused == false)
                {
                    print("Game Scene is Paused")
                    self.view?.paused = true
                    
                }
                else
                {
                    print("Game Scene is Resumed")
                    self.view?.paused = false
                }
            }
            
        }
    }
    
//====================================================================================================================//
    
    // #6
    // CALLED WHEN TOUCH IS RELEASED ON GameScene
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches
        {
            if self.velocityY < -9.0    //SETTING VELOCITY FOR JUMP ACTION IS FINISHED
            {
                self.velocityY = -9.0
            }
            
        }
    }
    
//====================================================================================================================//
  
    func gotoMenuScreen()
    {
        self.player.removeFromParent()
        
        let transitionEffect = SKTransition.doorsCloseHorizontalWithDuration(1.5) //flipVerticalWithDuration(2)//.flipHorizontalWithDuration(3)
        menuSceneInstance = MenuScene(size: self.size , playbutton: "Play", background: "BG")
        menuSceneInstance!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(menuSceneInstance , transition:transitionEffect)
    }

//====================================================================================================================//
   
    func gotoSavePlayerScreen()
    {
        self.player.removeFromParent()
        
        print("The Saved Score Is:  \(savedScore)")
        print("The Highest Score Is:  \(highestScore)")
        
        if self.highestScore > savedScore
        {
            let transitionEffect = SKTransition.doorsCloseHorizontalWithDuration(1.5)
            highScorerListInstance = ScoreList(size: self.size) // , playbutton: "Play", background: "BG")
            highScorerListInstance!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.view?.presentScene(highScorerListInstance , transition:transitionEffect)
        }
        
        else if self.highestScore <= savedScore
        {
           gotoMenuScreen()
        }
        
    }
    
//====================================================================================================================//
    
    // WHEN BLOCKS COLLIDES WITH PLAYER (CHAPTER 6)
    func didBeginContact(contact: SKPhysicsContact)
    {
        avPlayer.stop()
        readFileIntoAVPlayer(gameOutSound, ext: "mp3")
        
        // SHOWING PARTICLE EFFECT WHEN COLLISION HAPPENS
        self.particlePlayerNode.hidden = false
        
        var inOutActionWhenPlayerDied = SKAction.scaleBy(0.5, duration: 0.5)
        var upActionWhenPlayerDied = SKAction.moveToY(self.player.size.height * 4, duration: 2)
        var removeFromParent = SKAction.self.removeFromParent()
        
        
        self.player.runAction(SKAction.sequence([inOutActionWhenPlayerDied,inOutActionWhenPlayerDied.reversedAction(),upActionWhenPlayerDied,removeFromParent]),completion: gotoSavePlayerScreen)
//      self.player.runAction(SKAction.sequence([inOutActionWhenPlayerDied,inOutActionWhenPlayerDied.reversedAction(),upActionWhenPlayerDied,removeFromParent]),gotoMenuScreen)
        
    }
    
//====================================================================================================================//
   
    func changeSpriteFromTextureAtlas()
    {
        switch(currentno%3)
        {
            case 0:
                player.texture = myAtlas.textureNamed("bro5_run0001")
            case 1:
                player.texture = myAtlas.textureNamed("bro5_run0002")
            case 2:
                player.texture = myAtlas.textureNamed("bro5_run0003")
            case 3:
                player.texture = myAtlas.textureNamed("bro5_run0004")
            case 4:
                player.texture = myAtlas.textureNamed("bro5_run0004")
            case 5:
                player.texture = myAtlas.textureNamed("bro5_run0004")
                default :
                break
        }
        
    }
    
//====================================================================================================================//
   
    // #7
    // UPDATE FUNCTION CHAPTER 5
    override func update(currentTime: NSTimeInterval)
    {
        if self.runningBar.position.x <= maxBarX
            {
                self.runningBar.position.x = self.origRunningBarPositionX
            }
        
            // JUMP ACTION
            self.velocityY += self.gravity
            self.player.position.y -= velocityY
            if self.player.position.y < self.playerBaseline   // STOPPING PLAYER TO FALLDOWN FROM BASELINE
            {
                self.player.position.y = self.playerBaseline
                velocityY = 0.0
                self.onGround = true
            }

            //Move the Ground
            runningBar.position.x -= CGFloat(self.groundSpeed)
            blockRunner()
    }
    
//====================================================================================================================//
   
    // #8
    // FOR MAKING BLOCKS RUUNNING
    func blockRunner()
    {
        // LOOP FOR THE DICTIONARY TO GET BLOCKS
        for(block, blockStatus) in self.blockStatuses
        {
            let thisBlock = self.childNodeWithName(block)!
            if blockStatus.shouldRunBlock()
            {
                blockStatus.timeGapForNextRun = random()
                blockStatus.currentInterval = 0
                blockStatus.isRunning = true
            }

            if blockStatus.isRunning
            {
                if thisBlock.position.x > blockMaxX      // IF IT IS POSITIVE (KEEP MOVING BLOCKS FROM RIGHT TO LEFT)
                {
                    thisBlock.position.x -= CGFloat(self.groundSpeed)
                }
                else                                     // IF ITS TIME TO OFF THE SCREEN ie when BLOCKS should DISAPPEAR
                {
                    thisBlock.position.x = self.origBlockPositionX
                    blockStatus.isRunning = false
                    self.score = score + 10
                    self.numberOfBlocksCrosssed += 1
                    self.scoreText.text = "Score: \(String(self.score))"
                    self.levelLabel.text = "Level: \(String(self.level))"
                    if self.numberOfBlocksCrosssed == 5
                    {
                        self.level = level + 1
                        self.groundSpeed = self.groundSpeed + 7
                    }
                    else if self.numberOfBlocksCrosssed == 10
                    {
                        self.level = level + 1
                        self.groundSpeed = self.groundSpeed + 9
                    }
                    else if self.numberOfBlocksCrosssed == 20
                    {
                        self.level = level + 1
                        self.groundSpeed = self.groundSpeed + 12
                    }
                    else if self.numberOfBlocksCrosssed > 20
                    {
                        print("Final Level")
                    }
                }
                //To save highest score
                self.highestScore = self.score
                NSUserDefaults.standardUserDefaults().setObject(highestScore, forKey:"HighestScore")
                NSUserDefaults.standardUserDefaults().setInteger(highestScore, forKey:"SCORE")
            }
            else
            {
                blockStatus.currentInterval++
            }
        }
    }
    
//====================================================================================================================//

}



