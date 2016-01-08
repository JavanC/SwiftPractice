//
//  GameScene.swift
//  ExplodingMonkeys
//
//  Created by javan.chen on 2016/1/8.
//  Copyright (c) 2016年 Javan chen. All rights reserved.
//

import SpriteKit

enum CollisionTypes: UInt32 {
    case Banana = 1
    case Building = 2
    case Player = 4
}

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
