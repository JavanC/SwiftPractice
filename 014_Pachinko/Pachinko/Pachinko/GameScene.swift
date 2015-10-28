//
//  GameScene.swift
//  Pachinko
//
//  Created by javan.chen on 2015/10/28.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        let backgroung = SKSpriteNode(imageNamed: "background.jpg")
        backgroung.position = CGPoint(x: 512, y: 384)
        backgroung.blendMode = .Replace
        backgroung.zPosition = -1
        addChild(backgroung)
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = CGPoint(x: 512, y: 0)
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody!.dynamic = false
        addChild(bouncer)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            /// box physics body
            //let box = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 64, height: 64))
            //box.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 64, height: 64))
            //box.position = location
            //addChild(box)
            /// ball physics body
            let ball = SKSpriteNode(imageNamed: "ballRed")
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
            ball.physicsBody!.restitution = 0.4
            ball.position = location
            addChild(ball)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
