//
//  Bead.swift
//  Soroban
//
//  Created by James Young on 11/2/22.
//

import Foundation
import SpriteKit

class Bead:SKShapeNode{

    var selected:Bool
    var grouped:Bool
    var group:[Bead]?
    
    init(position:CGPoint, radius: CGFloat){
        self.selected = false;
        self.grouped=false;
        super.init();
        self.path = CGPath(ellipseIn: CGRect(origin: .zero, size: CGSize(width: 100, height: radius)), transform: nil)
        self.position = position;
        super.physicsBody = SKPhysicsBody(circleOfRadius: 25);
        super.physicsBody!.affectedByGravity = false;
        super.physicsBody!.usesPreciseCollisionDetection = true;
        super.physicsBody!.contactTestBitMask=2;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func touchDown(touch:UITouch){
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    func setSelected(b:Bool){
        self.selected=b;
    }
}
