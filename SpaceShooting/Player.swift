//
//  Player.swift
//  SpaceShooting
//
//  Created by 김호중 on 2019/10/05.
//  Copyright © 2019 hojung. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    var screenSize: CGSize!
    
    init(screenSize: CGSize) {
        self.screenSize = screenSize
        let playerTexture = Atlas.gameobject.textureNamed("player")
        super.init(texture: playerTexture, color: SKColor.clear, size: playerTexture.size())
        self.zPosition = Layer.player
        
        // set physics body
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width / 3, height: self.size.height / 3), center: CGPoint(x: 0, y: 0))
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemy | PhysicsCategory.meteor
        self.physicsBody?.collisionBitMask = 0
        
        // Thruster 붙이기
        guard let thruster = SKEmitterNode(fileNamed: Particle.playerThruster) else { return }
        thruster.position.y -= self.size.height / 2
        thruster.zPosition = Layer.sub
        
        // 알파블랜딩 문제해결
        let thrusterEffectNode = SKEffectNode()
        thrusterEffectNode.addChild(thruster)
        self.addChild(thrusterEffectNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implementied")
    }
    
    // 쉴드 작성
    func createShield() -> SKSpriteNode {
        let texture = Atlas.gameobject.textureNamed("playerShield")
        let shield = SKSpriteNode(texture: texture)
        shield.position = CGPoint(x: 0, y: 0)
        shield.zPosition = Layer.upper
        shield.physicsBody = SKPhysicsBody(circleOfRadius: shield.size.height / 2)
        shield.physicsBody?.categoryBitMask = PhysicsCategory.shield
        shield.physicsBody?.contactTestBitMask = PhysicsCategory.enemy | PhysicsCategory.meteor | PhysicsCategory.bossMissile
        shield.physicsBody?.collisionBitMask = 0
        
        // 깜박임 효과
        let fadeOutAndIn = SKAction.sequence([
            SKAction.fadeAlpha(by: 0.2, duration: 1.0),
            SKAction.fadeAlpha(by: 1.0, duration: 1.0)
            ])
        shield.run(SKAction.repeatForever(fadeOutAndIn))
        
        return shield
    }
    
    // 미사일 작성
    func createMisile() -> SKSpriteNode {
        let texture = Atlas.gameobject.textureNamed("playerMissile")
        let misile = SKSpriteNode(texture: texture)
        misile.position = self.position
        misile.position.y += self.size.height
        misile.zPosition = Layer.playermissile
        
        // set Physics Body
        misile.physicsBody = SKPhysicsBody(rectangleOf: misile.size)
        misile.physicsBody?.categoryBitMask = PhysicsCategory.missile
        misile.physicsBody?.contactTestBitMask = PhysicsCategory.enemy | PhysicsCategory.meteor | PhysicsCategory.boss | PhysicsCategory.bossMissile | PhysicsCategory.item
        misile.physicsBody?.collisionBitMask = 0
        misile.physicsBody?.usesPreciseCollisionDetection = true
        
        return misile
    }
    
    // 미사일 발사
    func fireMisile(misile: SKSpriteNode) {
        var actionArray = [SKAction]()
        actionArray.append(SKAction.moveTo(y: self.screenSize.height + misile.size.height, duration: 0.4))
        actionArray.append(SKAction.removeFromParent())
        
        misile.run(SKAction.sequence(actionArray))
    }
}
