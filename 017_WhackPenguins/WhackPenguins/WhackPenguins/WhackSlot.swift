//
//  WhackSlot.swift
//  WhackPenguins
//
//  Created by javan.chen on 2015/11/4.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit
import UIKit

class WhackSlot: SKNode {

    func configureAtPosition(pos: CGPoint) {
        position = pos
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
    }
    
}
