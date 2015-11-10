//
//  GameScene.swift
//  Ninja
//
//  Created by javan.chen on 2015/11/9.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var activeSliceBG: SKShapeNode!
    var activeSliceFG: SKShapeNode!
    var gameScore: SKLabelNode!
    var score: Int = 0 {
        didSet{
            gameScore.text = "Score: \(score)"
        }
    }
    var livesImages = [SKSpriteNode]()
    var lives = 3
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "sliceBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        physicsWorld.speed = 0.85
        
        createScore()
        createLives()
        //        createSlices()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    /**
     creatScore function
     */
    func createScore() {
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.horizontalAlignmentMode = .Left
        gameScore.fontSize = 48
        gameScore.position = CGPoint(x: 8, y: 8)
        addChild(gameScore)
    }
    /**
     creatLives function
     */
    func createLives() {
        for i in 0 ..< 3 {
            let spritNode = SKSpriteNode(imageNamed: "sliceLife")
            spritNode.position = CGPoint(x: CGFloat(834 + (i * 70)), y: 720)
            addChild(spritNode)
            
            livesImages.append(spritNode)
        }
    }
    
    func creatSlices() {
        activeSliceBG = SKShapeNode()
        activeSliceBG.zPosition = 2
        
        activeSliceFG = SKShapeNode()
        activeSliceFG.zPosition = 2
        
        activeSliceBG.strokeColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
        activeSliceBG.lineWidth = 9
        
        activeSliceFG.strokeColor = UIColor.whiteColor()
        activeSliceFG.lineWidth = 5
        
        addChild(activeSliceBG)
        addChild(activeSliceFG)
    }
}
