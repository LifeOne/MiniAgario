//
//  GameScene.swift
//  FinalBouncer
//
//  Created by Derek Schubert on 5/4/16.
//  Copyright (c) 2016 Derek Schubert. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let CircleCategory: UInt32 = 0x1 << 0   // 00000000000000000000000000000001
    let BorderCategory: UInt32 = 0x1 << 1  // 00000000000000000000000000000010
    
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)

        let Circle = SKShapeNode(circleOfRadius: 50)
        Circle.position = CGPointMake(frame.midX + 5, frame.midY)
        Circle.fillColor = SKColor.grayColor()
        Circle.lineWidth = 0
        Circle.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        Circle.physicsBody?.friction = 0
        Circle.physicsBody?.linearDamping = 0
        Circle.physicsBody?.angularDamping = 0
        Circle.physicsBody?.restitution = 1
        Circle.physicsBody?.categoryBitMask = CircleCategory
        Circle.physicsBody!.contactTestBitMask = CircleCategory
        
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.friction = 0
        self.addChild(Circle)
        self.physicsBody?.categoryBitMask = BorderCategory
        
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        Circle.physicsBody!.applyImpulse(CGVectorMake(100, 100))
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            
            // WHERE YOU TAP
            let location = touch.locationInNode(self)
            
            // SPAWN CIRCLE
            
            let rSize = CGFloat(arc4random_uniform(10) + 20)
            
            print(rSize)
            
            let Circle = SKShapeNode(circleOfRadius: rSize)
            Circle.position = CGPointMake(location.x, location.y)
            Circle.fillColor = SKColor.redColor()
            Circle.lineWidth = 0
            Circle.physicsBody = SKPhysicsBody(circleOfRadius: rSize)
            Circle.physicsBody?.friction = 0
            Circle.physicsBody?.linearDamping = 0
            Circle.physicsBody?.angularDamping = 0
            Circle.physicsBody?.restitution = 1
            Circle.physicsBody?.categoryBitMask = CircleCategory
            Circle.physicsBody!.contactTestBitMask = CircleCategory
            
            self.addChild(Circle)
            
            let rImpulseX = (arc4random_uniform(100))
            let rImpulseY = (arc4random_uniform(100))
            
            Circle.physicsBody!.applyImpulse(CGVectorMake(CGFloat(rImpulseX) - 50, CGFloat(rImpulseY) - 50))
            

//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
        }
    }

    func didBeginContact(contact: SKPhysicsContact) {
        // 1. Create local variables for two physics bodies
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        // 2. Assign the two physics bodies so that the one with the lower category is always stored in firstBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 3. react to the contact between ball and bottom
        if firstBody.categoryBitMask == CircleCategory && secondBody.categoryBitMask == CircleCategory {
            //TODO: Replace the log statement with display of Game Over Scene
            //            print(firstBody.velocity)
            
//            print(firstBody.area)
//            print(secondBody.node!.frame.width)
            
            
            
            
            if firstBody.mass > secondBody.mass {
                
                if let _ = secondBody.node {
                    
                    var newWidth = firstBody.node!.frame.width + (secondBody.node!.frame.width / 2)
                    
                    if newWidth > 150 {
                        newWidth = 150
                    }
                    
                    let Circle = SKShapeNode(circleOfRadius: newWidth / 2)
                    Circle.position = CGPointMake(firstBody.node!.frame.midX, firstBody.node!.frame.midY)
                    Circle.fillColor = SKColor.redColor()
                    Circle.lineWidth = 0
                    Circle.physicsBody = SKPhysicsBody(circleOfRadius: newWidth / 2)
                    Circle.physicsBody?.friction = 0
                    Circle.physicsBody?.linearDamping = 0
                    Circle.physicsBody?.angularDamping = 0
                    Circle.physicsBody?.restitution = 1
                    Circle.physicsBody?.categoryBitMask = CircleCategory
                    Circle.physicsBody!.contactTestBitMask = CircleCategory
                    
                    self.addChild(Circle)
                    
                    var newDX = firstBody.velocity.dx - secondBody.velocity.dx
                    var newDY = firstBody.velocity.dy - secondBody.velocity.dy
                    if newDX > 0 {
                        if newDX > 100 {
                            newDX = 100
                        }
                    } else if newDX < 0 {
                        if newDX < -100 {
                            newDX = -100
                        }
                    } else {
                        newDX = 50
                    }
                    if newDY > 0 {
                        if newDY > 100 {
                            newDY = 100
                        }
                    } else if newDY < 0 {
                        if newDY < -100 {
                            newDY = -100
                        }
                    } else {
                        newDY = 50
                    }
                    
                    firstBody.node!.removeFromParent()
                    secondBody.node!.removeFromParent()
                    
                    Circle.physicsBody!.applyImpulse(CGVectorMake(newDX, newDY))

                    
                }
                
            } else {
                if let _ = firstBody.node {
                    var newWidth = (firstBody.node!.frame.width / 2) + secondBody.node!.frame.width
            
                    if newWidth > 150 {
                        newWidth = 150
                    }
                    
                    let Circle = SKShapeNode(circleOfRadius: newWidth / 2)
                    Circle.position = CGPointMake(secondBody.node!.frame.midX, secondBody.node!.frame.midY)
                    Circle.fillColor = SKColor.redColor()
                    Circle.lineWidth = 0
                    Circle.physicsBody = SKPhysicsBody(circleOfRadius: newWidth / 2)
                    Circle.physicsBody?.friction = 0
                    Circle.physicsBody?.linearDamping = 0
                    Circle.physicsBody?.angularDamping = 0
                    Circle.physicsBody?.restitution = 1
                    Circle.physicsBody?.categoryBitMask = CircleCategory
                    Circle.physicsBody!.contactTestBitMask = CircleCategory
                    
                    self.addChild(Circle)
                    
                    var newDX = secondBody.velocity.dx
                    var newDY = secondBody.velocity.dy
                    if newDX > 0 {
                        if newDX > 100 {
                            newDX = 100
                        }
                    } else if newDX < 0 {
                        if newDX < -100 {
                            newDX = -100
                        }
                    } else {
                        newDX = 50
                    }
                    if newDY > 0 {
                        if newDY > 100 {
                            newDY = 100
                        }
                    } else if newDY < 0 {
                        if newDY < -100 {
                            newDY = -100
                        }
                    } else {
                        newDY = 50
                    }
                    
                    firstBody.node!.removeFromParent()
                    secondBody.node!.removeFromParent()
                    
                    
                    
                    Circle.physicsBody!.applyImpulse(CGVectorMake(newDX, newDY))
                    
                    
                }
                
            }
            
//            firstBody.mass += 1
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func circleSpawn(radius: Int, location: (Double, Double)) {
        
    }
    
    
    
}







