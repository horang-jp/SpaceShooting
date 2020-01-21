//
//  MenuScene.swift
//  SpaceShooting
//
//  Created by 김호중 on 2019/12/03.
//  Copyright © 2019 hojung. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    override func didMove(to view: SKView) {
        
        // BGM
        let bgmPlayer = SKAudioNode(fileNamed: BGM.title)
        bgmPlayer.autoplayLooped = true
        self.addChild(bgmPlayer)
        
        guard let starfield = SKEmitterNode(fileNamed: Particle.starfield) else { return }
        starfield.position = CGPoint(x: size.width / 2, y: size.height)
        starfield.zPosition = Layer.starfield
        starfield.advanceSimulationTime(30)
        self.addChild(starfield)
        
        let titleLabel = SKLabelNode(text: "Space Shooting")
        titleLabel.fontName = "Minercraftory"
        titleLabel.fontSize = 30
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height / 1.3)
        titleLabel.zPosition = Layer.hud
        self.addChild(titleLabel)
        
        let playBtn = SKSpriteNode(imageNamed: "playBtn")
        playBtn.name = "playBtn"
        playBtn.position = CGPoint(x: size.width / 2, y: size.height / 4)
        playBtn.zPosition = Layer.hud
        self.addChild(playBtn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let nodeArray = self.nodes(at: location)
            if nodeArray.first?.name == "playBtn" {
                // doorsOpenHorizontal은 수평으로 문이 열리는 동작처럼 화면이 넘어간다.
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                let gameScene = GameScene(size: self.size)
                gameScene.scaleMode = .aspectFit
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}
