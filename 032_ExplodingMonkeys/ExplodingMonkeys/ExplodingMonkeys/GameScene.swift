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
    
    var buildings = [BuildingNode]()
    var player1: SKSpriteNode!
    var player2: SKSpriteNode!
    var banana: SKSpriteNode!
    var currentPlayer = 1
    weak var viewController: GameViewController!
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor(hue: 0.669, saturation: 0.99, brightness: 0.67, alpha: 1)
        
        createBuildings()
        createPlayers()
    }
    
    func createBuildings() {
        var currentX: CGFloat = -15
        
        while currentX < 1024 {
            let size = CGSize(width: RandomInt(min: 2, max: 4) * 40, height: RandomInt(min: 300, max: 600))
            currentX += size.width + 2
            
            let building = BuildingNode(color: UIColor.redColor(), size: size)
            building.position = CGPoint(x: currentX - (size.width / 2), y: size.height / 2)
            building.setup()
            addChild(building)
            
            buildings.append(building)
        }
    }
    
    func createPlayers() {
        player1 = SKSpriteNode(imageNamed: "player")
        player1.name = "player1"
        player1.physicsBody = SKPhysicsBody(circleOfRadius: player1.size.width / 2)
        player1.physicsBody!.categoryBitMask = CollisionTypes.Player.rawValue
        player1.physicsBody!.collisionBitMask = CollisionTypes.Player.rawValue
        player1.physicsBody!.contactTestBitMask = CollisionTypes.Banana.rawValue
        player1.physicsBody!.dynamic = false
        
        let player1Building = buildings[1]
        player1.position = CGPoint(x: player1Building.position.x, y: player1Building.position.y + ((player1Building.size.height + player1.size.height) / 2))
        addChild(player1)
        
        player2 = SKSpriteNode(imageNamed: "player")
        player2.name = "player2"
        player2.physicsBody = SKPhysicsBody(circleOfRadius: player2.size.width / 2)
        player2.physicsBody!.categoryBitMask = CollisionTypes.Player.rawValue
        player2.physicsBody!.collisionBitMask = CollisionTypes.Player.rawValue
        player2.physicsBody!.contactTestBitMask = CollisionTypes.Banana.rawValue
        player2.physicsBody!.dynamic = false
        
        let player2Building = buildings[buildings.count - 2]
        player2.position = CGPoint(x: player2Building.position.x, y: player2Building.position.y + ((player2Building.size.height + player2.size.height) / 2))
        addChild(player2)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func deg2rad(degrees: Int) -> Double {
        return Double(degrees) * M_PI / 180.0
    }
    
    func launch(angle angle: Int, velocity: Int) {
        // 1. Figure out how hard to throw the banana. We accept a velocity parameter, but I'll be dividing that by 10. You can adjust this based on your own playtesting.
        let speed = Double(velocity) / 10.0
        
        // 2. Convert the input angle to radians. Most people don't think in radians, so the input will come in as degrees that we will convert to radians.
        let radians = deg2rad(angle)
        
        // 3. If somehow there's a banana already, we'll remove it then create a new one using circle physics.
        if banana != nil {
            banana.removeFromParent()
            banana = nil
        }
        banana = SKSpriteNode(imageNamed: "banana")
        banana.name = "banana"
        banana.physicsBody = SKPhysicsBody(circleOfRadius: banana.size.width / 2)
        banana.physicsBody!.categoryBitMask = CollisionTypes.Banana.rawValue
        banana.physicsBody!.collisionBitMask = CollisionTypes.Building.rawValue | CollisionTypes.Player.rawValue
        banana.physicsBody!.contactTestBitMask = CollisionTypes.Building.rawValue | CollisionTypes.Player.rawValue
        banana.physicsBody!.usesPreciseCollisionDetection = true
        addChild(banana)
        
        if currentPlayer == 1 {
            // 4. If player 1 was throwing the banana, we position it up and to the left of the player and give it some spin.
            banana.position = CGPoint(x: player1.position.x - 30, y: player1.position.y + 40)
            banana.physicsBody!.angularVelocity = -20
            
            // 5. Animate player 1 throwing their arm up then putting it down again.
            let raiseArm = SKAction.setTexture(SKTexture(imageNamed: "player1Throw"))
            let lowerArm = SKAction.setTexture(SKTexture(imageNamed: "player"))
            let pause = SKAction.waitForDuration(0.15)
            let sequence = SKAction.sequence([raiseArm, pause, lowerArm])
            player1.runAction(sequence)
            
            // 6. Make the banana move in the correct direction.
            let impluse = CGVector(dx: cos(radians) * speed, dy: sin(radians) * speed)
            banana.physicsBody?.applyImpulse(impluse)
        } else {
            // 7. If player 2 was throwing the banana, we position it up and to the right, apply the opposite spin, then make it move in the correct direction.
            banana.position = CGPoint(x: player2.position.x + 30, y: player2.position.y + 40)
            banana.physicsBody!.angularVelocity = 20
            
            let raiseArm = SKAction.setTexture(SKTexture(imageNamed: "player2Throw"))
            let lowerArm = SKAction.setTexture(SKTexture(imageNamed: "player"))
            let pause = SKAction.waitForDuration(0.15)
            let sequence = SKAction.sequence([raiseArm, pause, lowerArm])
            player2.runAction(sequence)
            
            let impluse = CGVector(dx: cos(radians) * -speed, dy: sin(radians) * speed)
            banana.physicsBody?.applyImpulse(impluse)
        }
    }
}
