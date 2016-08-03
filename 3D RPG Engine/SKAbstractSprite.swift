//
//  SKAbstractSprite.swift
//  3D RPG Engine
//
//  Created by Mateusz Andrzejczuk on 7/6/16.
//  Copyright © 2016 Core Prime Inc. All rights reserved.
//

import Foundation
import SpriteKit



class SKAbstractSprite: SKMapSprite, AbstractSpriteProtocol {
    
    var UnitReference: AbstractUnit?
    
    let AnimationDuration_WALK = 0.05
    let AnimationDuration_ATTACK = 0.05
    
    // ATTACK
    var attackUp_Frames: [SKTexture] = [];
    var attackDown_Frames: [SKTexture] = [];
    var attackLeft_Frames: [SKTexture] = [];
    var attackRight_Frames: [SKTexture] = [];
    
    var attackUpRight_Frames: [SKTexture] = [];
    var attackUpLeft_Frames: [SKTexture] = [];
    
    var attackDownLeft_Frames: [SKTexture] = [];
    var attackDownRight_Frames: [SKTexture] = [];
    
    var walkUp_Frames: [SKTexture] = [];
    var walkDown_Frames: [SKTexture] = [];
    var walkLeft_Frames: [SKTexture] = [];
    var walkRight_Frames: [SKTexture] = [];
    
    var deathUp_Frames: [SKTexture] = [];
    var deathDown_Frames: [SKTexture] = [];
    
    // TODO:
    
    // do something like:
    
    //
    // if self is SKFootmanSprite
    //
    // var castedUnit = (self as! SKFootmanSprite)
    // castedUnit.playWalkUPAnimation()
    //
    func playFaceUpAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                [walkUp_Frames[0]], timePerFrame: AnimationDuration_WALK))
    }
    func playFaceDownAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                [walkDown_Frames[0]], timePerFrame: AnimationDuration_WALK))
    }
    func playFaceLeftAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                [walkLeft_Frames[0]], timePerFrame: AnimationDuration_WALK))
    }
    func playFaceRightAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                [walkRight_Frames[0]], timePerFrame: AnimationDuration_WALK))
    }
    
    func playWalkDOWNAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                walkDown_Frames, timePerFrame: AnimationDuration_WALK))
    }
    func playWalkUPAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                walkUp_Frames, timePerFrame: AnimationDuration_WALK))
    }
    func playWalkLEFTAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                walkLeft_Frames, timePerFrame: AnimationDuration_WALK))
    }
    func playWalkRIGHTAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                walkRight_Frames, timePerFrame: AnimationDuration_WALK))
    }
    
    func playAttackUPAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                attackUp_Frames, timePerFrame: AnimationDuration_ATTACK))
    }
    func playAttackUPLEFTAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                attackUpLeft_Frames, timePerFrame: AnimationDuration_ATTACK))
    }
    func playAttackUPRIGHTAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                attackUpRight_Frames, timePerFrame: AnimationDuration_ATTACK))
    }
    
    func playAttackDOWNLEFTAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                attackDownLeft_Frames, timePerFrame: AnimationDuration_ATTACK))
    }
    func playAttackDOWNAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                attackDown_Frames, timePerFrame: AnimationDuration_ATTACK))
    }
    func playAttackDOWNRIGHTAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                attackDownRight_Frames, timePerFrame: AnimationDuration_ATTACK))
    }
    
    func playAttackRIGHTAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                attackRight_Frames, timePerFrame: AnimationDuration_ATTACK))
    }
    
    func playAttackLEFTAnimation() {
        self.runAction(
            SKAction.animateWithTextures(
                attackLeft_Frames, timePerFrame: AnimationDuration_ATTACK))
    }
    
    func playDeathAnimation() {
        let timerToHackDeathAnimation = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("FixDeathAnimationHack"), userInfo: nil, repeats: false)
        
        if self is SKFootmanSprite {
            (self as! SKFootmanSprite).playDeathAnimation()
            runAction(SKAction.fadeOutWithDuration(UnitData.DecayLength()))
            
            UnitReference!.ReferenceOfGameScene.runAction(
                SKAction.playSoundFileNamed(
                    "Hdead.wav",
                    waitForCompletion: true
                )
            )
        } else if self is SKGruntSprite {
            (self as! SKGruntSprite).playDeathAnimation()
            runAction(SKAction.fadeOutWithDuration(UnitData.DecayLength()))
            
            UnitReference!.ReferenceOfGameScene.runAction(
                SKAction.playSoundFileNamed(
                    "Odead.wav",
                    waitForCompletion: true
                )
            )
        } else if self is SKSpearThrowerSprite {
            (self as! SKSpearThrowerSprite).playDeathAnimation()
            runAction(SKAction.fadeOutWithDuration(UnitData.DecayLength()))
            
            UnitReference!.ReferenceOfGameScene.runAction(
                SKAction.playSoundFileNamed(
                    "Odead.wav",
                    waitForCompletion: true
                )
            )
        }
    }
    
    func FixDeathAnimationHack() {
        // Something after a delay
        if self is SKFootmanSprite {
            (self as! SKFootmanSprite).playDeathHackAnimation()
            
            runAction(SKAction.fadeOutWithDuration(UnitData.DecayLength()))
        }
        
    }
    
    func walkUpSequence() {}
    func walkDownSequence() {}
    func walkLeftSequence() {}
    func walkRightSequence() {}
}