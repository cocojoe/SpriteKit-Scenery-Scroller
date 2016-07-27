//
//  GameScene.swift
//  SceneryScrollerFX
//
//  Created by Martin Walsh on 27/07/2016.
//  Copyright (c) 2016 Frosty Cube. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    /* Scene connections */
    var scrollLayer: SKNode!
    
    /* Game constants */
    let fixedDelta: CFTimeInterval = 1.0/60.0 /* 60 FPS */
    let scrollSpeed: CGFloat = 120
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set reference to scroll layer node */
        scrollLayer = self.childNodeWithName("scrollLayer")

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            print(location)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        scrollWorld()
    }
    
    func scrollWorld() {
        /* Scroll World */
        
        scrollLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        /* Loop through scroll layer nodes */
        for ground in scrollLayer.children as! [SKSpriteNode] {
            
            /* Get ground node position, convert node position to scene space */
            let groundPosition = scrollLayer.convertPoint(ground.position, toNode: self)
            
            /* Check if ground sprite has left the scene */
            if groundPosition.x <= -ground.size.width / 2 {
                
                /* Reposition ground sprite to the second starting position */
                let newPosition = CGPointMake( (self.size.width / 2) + ground.size.width, groundPosition.y)
                
                /* Convert new node position back to scroll layer space */
                ground.position = self.convertPoint(newPosition, toNode: scrollLayer)
            }
        }
    }
}
