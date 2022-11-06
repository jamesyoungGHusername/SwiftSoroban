//
//  GameScene.swift
//  Soroban
//
//  Created by James Young on 11/2/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var selectedNode:SKShapeNode?
    var history:[TouchInfo]?
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var beads : [Bead] = [];
    private var hasSelected:Bool = false;
    
    override func sceneDidLoad() {
        self.physicsWorld.contactDelegate = self;
        
        beads.append(Bead(position: CGPoint(x:0,y:50), radius: 50 ))
        beads.append(Bead(position: CGPoint(x:0,y:0), radius: 50 ))
        for bead in beads{
            self.addChild(bead);
        }
        beads[0].fillColor=UIColor.blue;
        self.lastUpdateTime = 0
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact")
        print(contact.bodyA);
        print(contact.bodyB);
        //let fixedJoint = SKPhysicsJointFixed.joint(withBodyA: contact.bodyA, bodyB: contact.bodyB, anchor: contact.contactPoint)
        //self.physicsWorld.add(fixedJoint)
    }
    func touchDown(atPoint pos : CGPoint) {
        for bead in beads {
            if bead.contains(pos){
                bead.selected=true;
                let move = SKAction.move(to:CGPoint(x: bead.position.x, y: pos.y), duration: 0.01)
                bead.run(move);
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        for bead in beads {
            if bead.selected{
                let move = SKAction.move(to:CGPoint(x: bead.position.x, y: pos.y), duration: 0.01)
                bead.run(move);
            }
        }
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        for bead in beads{
            bead.setSelected(b: false);
            print(bead.physicsBody?.allContactedBodies())
        }
        hasSelected = false;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touchDown(atPoint: touch.location(in: self))
            let location = touch.location(in:self)
            let node = self.atPoint(location)
           
                // Step 1
            selectedNode = node as? SKShapeNode;
                // Stop the sprite
            selectedNode?.physicsBody?.velocity = CGVectorMake(0,0)
                // Step 2: save information about the touch
            history = [TouchInfo(location:location, time:touch.timestamp)]
            
        }
       
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touchMoved(toPoint: touch.location(in: self))
           
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self))
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
 
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}

struct TouchInfo {
    var location:CGPoint
    var time:TimeInterval
}
