//
//  UIPlayerAttackButton.swift
//  3D RPG Engine
//
//  Created by Mateusz Andrzejczuk on 8/4/16.
//  Copyright © 2016 Core Prime Inc. All rights reserved.
//

import Foundation
import SpriteKit


class AttackButton: SKSpriteNode {
    
    var superClass: UIPlayerControlPanel?
    var nameCustom = ""
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if nameCustom == "attack" {
            self.superClass!.orderPlayerToAttack()
            
            let nonPressedButton = SKTexture(imageNamed: "btn-attack-idle")
            let pressedButton = SKTexture(imageNamed: "btn-attack-pressed")
            
            self.runAction(SKAction.animateWithTextures([pressedButton], timePerFrame: 0.2), completion: {
                self.runAction(SKAction.animateWithTextures([nonPressedButton], timePerFrame: 0.2))
            })
        } else if nameCustom == "lvlUp" {
            
            let nonPressedButton = SKTexture(imageNamed: "btn-levelUp-idle")
            let pressedButton = SKTexture(imageNamed: "btn-levelUp-pressed")
            
            
            self.runAction(SKAction.animateWithTextures([pressedButton], timePerFrame: 0.2), completion: {
                self.runAction(SKAction.animateWithTextures([nonPressedButton], timePerFrame: 0.2))
                self.superClass!.showStatsWindow()
            })
        } else if nameCustom == "exitstats" {
            let nonPressedButton = SKTexture(imageNamed: "btn-stone-idle")
            let pressedButton = SKTexture(imageNamed: "btn-stone-pressed")
            
            
            self.runAction(SKAction.animateWithTextures([pressedButton], timePerFrame: 0.2), completion: {
                self.runAction(SKAction.animateWithTextures([nonPressedButton], timePerFrame: 0.2))
                self.superClass!.hideStatsWindow()
            })
        }
        else if nameCustom == "spell1" {
            let nonPressedButton = SKTexture(imageNamed: "btn-ralley-idle")
            let pressedButton = SKTexture(imageNamed: "btn-ralley-pressed")
            
            self.runAction(SKAction.animateWithTextures([pressedButton], timePerFrame: 0.2), completion: {
                self.runAction(SKAction.animateWithTextures([nonPressedButton], timePerFrame: 0.2))
                self.superClass!.castSpell1()
            })
        }
        else if nameCustom == "spell2" {
            let nonPressedButton = SKTexture(imageNamed: "btn-frozenOrb-idle")
            let pressedButton = SKTexture(imageNamed: "btn-frozenOrb-pressed")
            
            self.runAction(SKAction.animateWithTextures([pressedButton], timePerFrame: 0.2), completion: {
                self.runAction(SKAction.animateWithTextures([nonPressedButton], timePerFrame: 0.2))
                self.superClass!.castSpell2()
            })
        }
        else if nameCustom == "spell3" {
            let nonPressedButton = SKTexture(imageNamed: "btn-explosion-idle")
            let pressedButton = SKTexture(imageNamed: "btn-explosion-pressed")
            
            self.runAction(SKAction.animateWithTextures([pressedButton], timePerFrame: 0.2), completion: {
                self.runAction(SKAction.animateWithTextures([nonPressedButton], timePerFrame: 0.2))
                self.superClass!.castSpell3()
            })
        }
        else if nameCustom == "spell4" {
            let nonPressedButton = SKTexture(imageNamed: "btn-blizzard-idle")
            let pressedButton = SKTexture(imageNamed: "btn-blizzard-pressed")
            
            self.runAction(SKAction.animateWithTextures([pressedButton], timePerFrame: 0.2), completion: {
                self.runAction(SKAction.animateWithTextures([nonPressedButton], timePerFrame: 0.2))
                self.superClass!.castSpell4()
            })
        }
            
        else if nameCustom == "strength" && self.superClass!.heroStat!.SpendPoints > 0 {
            let nonPressedButton = SKTexture(imageNamed: "btn-levelUp-idle")
            let pressedButton = SKTexture(imageNamed: "btn-levelUp-pressed")
            self.superClass!.heroStat!.addStrength()
            self.runAction(SKAction.animateWithTextures([pressedButton], timePerFrame: 0.2), completion: {
                self.runAction(SKAction.animateWithTextures([nonPressedButton], timePerFrame: 0.2))
                
                self.superClass!.updateLevelValues()
            })
        }
        else if nameCustom == "dexterity" && self.superClass!.heroStat!.SpendPoints > 0 {
            let nonPressedButton = SKTexture(imageNamed: "btn-levelUp-idle")
            let pressedButton = SKTexture(imageNamed: "btn-levelUp-pressed")
            self.superClass!.heroStat!.addDexterity()
            self.runAction(SKAction.animateWithTextures([pressedButton], timePerFrame: 0.2), completion: {
                self.runAction(SKAction.animateWithTextures([nonPressedButton], timePerFrame: 0.2))
                
                self.superClass!.updateLevelValues()
            })
        }
        else if nameCustom == "stamina" && self.superClass!.heroStat!.SpendPoints > 0 {
            let nonPressedButton = SKTexture(imageNamed: "btn-levelUp-idle")
            let pressedButton = SKTexture(imageNamed: "btn-levelUp-pressed")
            self.superClass!.heroStat!.addStamina()
            self.runAction(SKAction.animateWithTextures([pressedButton], timePerFrame: 0.2), completion: {
                self.runAction(SKAction.animateWithTextures([nonPressedButton], timePerFrame: 0.2))
                
                self.superClass!.updateLevelValues()
            })
        }
        else if nameCustom == "magic" && self.superClass!.heroStat!.SpendPoints > 0 {
            let nonPressedButton = SKTexture(imageNamed: "btn-levelUp-idle")
            let pressedButton = SKTexture(imageNamed: "btn-levelUp-pressed")
            
            self.superClass!.heroStat!.addMagic()
            self.runAction(SKAction.animateWithTextures([pressedButton], timePerFrame: 0.2), completion: {
                self.runAction(SKAction.animateWithTextures([nonPressedButton], timePerFrame: 0.2))
                self.superClass!.updateLevelValues()
            })
        }
        
//        self.superClass!.orderPlayerToRalleyForces()
    }
    
    func makeInteractable(superClass: UIPlayerControlPanel) {
        self.userInteractionEnabled = true
        self.superClass = superClass
    }
}
