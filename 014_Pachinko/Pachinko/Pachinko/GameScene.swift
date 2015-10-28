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
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
