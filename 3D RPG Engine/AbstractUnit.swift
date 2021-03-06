//
//  AbstractUnit.swift
//  3D RPG Engine
//
//  Created by Mateusz Andrzejczuk on 8/2/16.
//  Copyright © 2016 Core Prime Inc. All rights reserved.
//

import Foundation
import SpriteKit

class AbstractUnit: UnitFoundation, UnitActions, UnitProperties, UnitDelegate, PathBlocking {
    
    var spriteMovementBlocker = SKBlockMovementSpriteNode(imageNamed: "SearchRadiusDummy")
    var spriteSight = SKSpriteSightNode(imageNamed: "SearchRadiusDummy") //(imageNamed: "RadiusDummyB")
    var meleeSight = SKSpriteMeleeSightNode(imageNamed: "SearchRadiusDummy")
    var debugUnitLabel = SKLabelNode(text: "DEBUG")
    var debugUnitLabel2 = SKLabelNode(text: "DEBUG")
    
    var stoppedForInteruptedMeleeCombat = false
    
    var nameGUI: String
    
    // ACTIONS P
    var HP: Int = 50
    var MANA: Int = 50
    var Armor: Int = 0
    var DMG: Int = 1
    
    var HP_MAX: Int = 0
    var MANA_MAX: Int = 0
    var DMG_MAX: Int = 0
    var Armor_MAX: Int = 0
    
    
    var isFrozen = 0.0
    
    
    var allFocusedTargets = Set<AbstractUnit>()
    
    var oldTarget: (AbstractUnit?)
    
    var previousAttacker: (AbstractUnit?)
//    {
//        didSet {
//            focusedTargetUnit = previousAttacker
//        }
//    }

    
    var focusedTargetUnit: (AbstractUnit?) {
        didSet {
            if focusedTargetUnit?.isDead == true {
                focusedTargetUnit = nil
            }
            else if self.isAutonomous == false {
                print("\(self.sprite.name) is human controlled.")
                focusedTargetUnit = nil
            }
            else if focusedTargetUnit?.sprite.name == self.sprite.name {
                focusedTargetUnit = oldValue
            }
        }
    }
    
    
    var positionLogical: CGPoint = CGPoint(x: 0, y: 0)
    var isDead = false
    
    // DELEGATE P
    weak var delegate: UnitDelegate?
    var currentActionProgress: CGFloat = 1.0
    
    
    override init() {
        self.nameGUI = "no name!"
//        fatalError("Unit created without ReferenceOfGameScene! [UnitFoundation]")
    }
    
    func alertTheReceivingUnitItIsBeingAttacked(_ attacker: AbstractUnit) {
        if attacker != self && attacker.teamNumber != self.teamNumber {
            self.focusedTargetUnit = attacker
            self.previousAttacker = attacker
        }
    }
    
    func initMovementBlocker() {
        //        spriteMovementBlocker = SKBlockMovementSpriteNode(imageNamed: "path-blocker")
//        spriteMovementBlocker = SKBlockMovementSpriteNode(imageNamed: "SearchRadiusDummy")
        spriteMovementBlocker.xScale = 1.0
        spriteMovementBlocker.yScale = 1.0
        spriteMovementBlocker.position = sprite.position
        spriteMovementBlocker.zPosition = 2000
        spriteMovementBlocker.UnitReference = self
        
        if self is FootmanUnit {
            spriteSight.xScale = 23.0
            spriteSight.yScale = 23.0
        } else {
            meleeSight.xScale = 3.0
            meleeSight.yScale = 3.0
            
            spriteSight.xScale = 13.0
            spriteSight.yScale = 13.0
        }
        
        meleeSight.position = sprite.position
        meleeSight.zPosition = 20
        meleeSight.UnitReference = self

        spriteSight.position = sprite.position
        spriteSight.zPosition = 20
        spriteSight.UnitReference = self
        
        debugUnitLabel.fontName = "AvenirNextCondensed-Medium"
        debugUnitLabel.fontColor = UIColor.white
        debugUnitLabel.text = "..."
        debugUnitLabel.zPosition = 100
        debugUnitLabel.fontSize = 18
        debugUnitLabel.position = self.positionLogical
        
        debugUnitLabel2.fontName = "AvenirNextCondensed-Medium"
        debugUnitLabel2.fontColor = UIColor.purple
        debugUnitLabel2.text = "DEBUG..."
        debugUnitLabel2.zPosition = 100
        debugUnitLabel2.fontSize = 18
        debugUnitLabel2.position = self.positionLogical
    }
    func destroyBlockerUponDeath() {
        self.spriteMovementBlocker.removeFromParent()
        self.spriteSight.removeFromParent()
        self.debugUnitLabel.removeFromParent()
        self.debugUnitLabel2.removeFromParent()
        self.meleeSight.removeFromParent()
    }
    

    // FOR HOST:
    func unitWillTakeDamageReturnIfUnitDies(_ damage: Int, fromUnit: AbstractUnit) -> Bool {

        let randomNumber = arc4random()
        var selectedNumber = 1
        if randomNumber > 3000492058 {
            selectedNumber = 1
        }
        else if randomNumber > 1000492058 {
            selectedNumber = 2
        } else {
            selectedNumber = 3
        }
        ReferenceOfGameScene.run(SKAction.playSoundFileNamed("Sword\(selectedNumber).wav", waitForCompletion: false))
        let damageAfterArmor = damage - self.Armor
        if damageAfterArmor <= 0 { HP -= 1 }
        else { HP -= damageAfterArmor }
        if HP <= 0 && isDead == false {
            didLoseAllHitpoints()
            self.sprite.run(SKAction.fadeOut(withDuration: 60))
//            fromUnit.focusedTargetUnit = nil
        }
        if self.isPlayer == true {
            self.ReferenceOfGameScene.heroDied()
        }
        return isDead
    }


    // FOR GUEST:
    func unitDidTakeDamageEventWebSocket(_ damage: Int, fromUnit: AbstractUnit) {
        let randomNumber = arc4random()
        var selectedNumber = 1
        if randomNumber > 3000492058 {
            selectedNumber = 1
        }
        else if randomNumber > 1000492058 {
            selectedNumber = 2
        } else {
            selectedNumber = 3
        }
        ReferenceOfGameScene.run(SKAction.playSoundFileNamed("Sword\(selectedNumber).wav", waitForCompletion: false))
        let damageAfterArmor = damage - self.Armor
        if damageAfterArmor <= 0 { HP -= 1 }
        else { HP -= damageAfterArmor }
        if HP <= 0 && isDead == false {
            didLoseAllHitpoints()
            self.sprite.run(SKAction.fadeOut(withDuration: 60))
//            fromUnit.focusedTargetUnit = nil
        }
        if self.isPlayer == true {
            self.ReferenceOfGameScene.heroDied()
        }
    }


    
    // ACTIONS M
    func didTakeDamage(_ damage: Int, fromUnit: AbstractUnit) {
        fatalError("not implemented")
    }
    
    
    func removeUnitCompletelyFromGameScene() {
        self.sprite.removeAllActions()
        self.isDead = true

        let point : CGPoint = self.positionLogical

        let x : CGFloat = point.x
        let y : CGFloat = point.y
        let gpmp : GamePathMatrixPoint = GamePathMatrixPoint(
                LandPoint: point,
                IsBlocked: false,
                spaceTime: "VOID",
                _color: DEFAULT_UNBLOCKED)
        let keyStr : String = "{\(x),\(y)}"

        self.ReferenceOfGameScene.PathsBlocked[keyStr] = gpmp
        self.destroyBlockerUponDeath()
        self.terminateTimers()
    }

    func killWithAnimation() {
        didLoseAllHitpointsIgnoreSocket()
    }

    func didLoseAllHitpointsIgnoreSocket() {
        self.sprite.removeAllActions()
        self.isDead = true
        self.sprite.playDeathAnimation({_ in

            let point : CGPoint = self.positionLogical
            let x : CGFloat = point.x
            let y : CGFloat = point.y
            let gpmp : GamePathMatrixPoint = GamePathMatrixPoint(
                    LandPoint: point,
                    IsBlocked: false,
                    spaceTime: "VOID",
                    _color: DEFAULT_UNBLOCKED)
            let keyStr : String = "{\(x),\(y)}"

            self.ReferenceOfGameScene.PathsBlocked[keyStr] = gpmp



            self.destroyBlockerUponDeath()
            self.terminateTimers()
        })
    }

    func didLoseAllHitpoints() {
        guard self.ReferenceOfGameScene.playerSK != nil else {
            return
        }
        if self.ReferenceOfGameScene.playerSK.teamNumber == 1 {
            self.ReferenceOfGameScene.broadcastDeathOf(unit: self)
        }
        self.sprite.removeAllActions()
        self.isDead = true
        self.sprite.playDeathAnimation({_ in


            let point : CGPoint = self.positionLogical

            let x : CGFloat = point.x
            let y : CGFloat = point.y
            let gpmp : GamePathMatrixPoint = GamePathMatrixPoint(
                    LandPoint: point,
                    IsBlocked: false,
                    spaceTime: "VOID",
                    _color: DEFAULT_UNBLOCKED)
            let keyStr : String = "{\(x),\(y)}"

            self.ReferenceOfGameScene.PathsBlocked[keyStr] = gpmp



            self.destroyBlockerUponDeath()
            self.terminateTimers()
        })
    }
    
    func terminateTimers() {
        if self is MeleeUnitNEW {
            (self as! MeleeUnitNEW).sightTimer?.invalidate()
            (self as! MeleeUnitNEW).attackTimer?.invalidate()
        } else if self is RangedUnitNEW {
            (self as! RangedUnitNEW).sightTimer?.invalidate()
            (self as! RangedUnitNEW).attackTimer?.invalidate()
        }
        
    }
    
    // DELEGATE M
    func actionDidBegin() {
        self.currentActionProgress = 0.0
        print("unit is executing a new order...")
        processAction()
    }
    
    func processAction() {
        if self.currentActionProgress < 1.0 {
            print(".", terminator: "")
            self.currentActionProgress += 0.2
            Thread.sleep(forTimeInterval: 0.3)
            processAction()
        } else {
            actionDidFinish()
        }
    }
    
    func actionDidFinish() {
        print("")
        print("Unit finished, awaiting new orders.")
    }
}
