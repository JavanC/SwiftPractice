//
//  GameScene.swift
//  FireworksNight
//
//  Created by javan.chen on 2015/11/17.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var gameTimer: NSTimer!
    var fireworks = [SKNode]()
    
    let leftEdge = -22
    let bottomEdge = -22
    let rightEdge = 1024 + 22
    
    var score: Int = 0 {
        didSet{
            //your code here
        }
    }
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: "launchFireworks", userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func createFirework(xMovement xMovement: CGFloat, x: Int, y: Int) {
        // 1
        let node = SKNode()
        node.position = CGPoint(x: x, y: y)
        
        // 2
        let firework = SKSpriteNode(imageNamed: "rocket")
        firework.name = "firework"
        node.addChild(firework)
        
        // 3
        switch GKRandomSource.sharedRandom().nextIntWithUpperBound(3) {
        case 0:
            firework.color = UIColor.cyanColor()
            firework.colorBlendFactor = 1
            
        case 1:
            firework.color = UIColor.greenColor()
            firework.colorBlendFactor = 1
            
        case 2:
            firework.color = UIColor.redColor()
            firework.colorBlendFactor = 1
            
        default:
            break
        }
        
        // 4
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: xMovement, y: 1000))
        
        // 5
        let move = SKAction.followPath(path.CGPath, asOffset: true, orientToPath: true, speed: 200)
        node.runAction(move)
        
        // 6
        let emitter = SKEmitterNode(fileNamed: "fuse.sks")!
        emitter.position = CGPoint(x: 0, y: -22)
        node.addChild(emitter)
        
        // 7
        fireworks.append(node)
        addChild(node)
    }
}
