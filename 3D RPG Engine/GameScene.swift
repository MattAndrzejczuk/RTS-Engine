//
//  GameScene.swift
//  3D RPG Engine
//
//  Created by Mateusz Andrzejczuk on 6/29/16.
//  Copyright (c) 2016 Core Prime Inc. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    
    var debugLabel = SKLabelNode(fontNamed:"HoeflierText")
    var debugLabelCamera = SKLabelNode(fontNamed:"HoeflierText")
    
    var ControlPanel: UserInputControlsPanel?
    
    let SightCategory   : UInt32 = 0x1 << 0
    
    let Player_1_Sprite_Category   : UInt32 = 0x1 << 1
    let Player_1_Sight_Category   : UInt32 = 0x1 << 2
    
    let Player_2_Sprite_Category   : UInt32 = 0x1 << 3
    let Player_2_Sight_Category   : UInt32 = 0x1 << 4
    
    var ScenarioListenerTimer: NSTimer?
    
    // HEROES
    var playerSK: BaseUnit!
    let playerSpriteID = "sprite_player"
    
    // NON-HEROES
    var enemies = [BaseUnit]()
    //    var allEnemyIDs: [String:BaseUnit] = [:]
    
    var tilesets = [SKGroundTileGeneric]()
    
    
    var playerTarget: SKPlayerTarget?
    
    
    let map = GameMap()
    var AllUnitsInGameScene = [BaseUnit]()
    var TotalPlayer2UnitsInGameScene = 0
    
    let _ScenarioSceneListener = ScenarioSceneListener(ScenarioKind_: ScenarioKind.Deathmatch)
    
    var temporaryNodes = [SKSpriteNode]()
    
    var hackmapname = ""
    
    let searchArea_s5 =
        [
            //####################################################################################################################################################################################################################
            CGPointMake(-250, 250), CGPointMake(-200, 250), CGPointMake(-150, 250),    CGPointMake(-100, 250),         CGPointMake(-50, 250),      CGPointMake(0, 250),        CGPointMake(50, 250),       CGPointMake(100, 250),      CGPointMake(150, 250), CGPointMake(200, 250), CGPointMake(250, 250),
            //####################################################################################################################################################################################################################
            CGPointMake(-250, 200), CGPointMake(-200, 200), CGPointMake(-150, 200),    CGPointMake(-100, 200),         CGPointMake(-50, 200),      CGPointMake(0, 200),        CGPointMake(50, 200),       CGPointMake(100, 200),      CGPointMake(150, 200), CGPointMake(200, 200), CGPointMake(250, 200),
            //####################################################################################################################################################################################################################
            CGPointMake(-250, 150), CGPointMake(-200, 150), CGPointMake(-150, 150),    CGPointMake(-100, 150),         CGPointMake(-50, 150),      CGPointMake(0, 150),        CGPointMake(50, 150),       CGPointMake(100, 150),      CGPointMake(150, 150), CGPointMake(200, 150), CGPointMake(250, 150),
            //####################################################################################################################################################################################################################
            CGPointMake(-250, 100), CGPointMake(-200, 100), CGPointMake(-150, 100),    CGPointMake(-100, 100),         CGPointMake(-50, 100),      CGPointMake(0, 100),        CGPointMake(50, 100),       CGPointMake(100, 100),      CGPointMake(150, 100), CGPointMake(200, 100), CGPointMake(250, 100),
            //####################################################################################################################################################################################################################
            CGPointMake(-250, 50), CGPointMake(-200, 50), CGPointMake(-150, 50),     CGPointMake(-100, 50),                                                                                               CGPointMake(100, 50),       CGPointMake(150, 50), CGPointMake(200, 50), CGPointMake(250, 50),
            //####################################################################################################################################################################################################################
            CGPointMake(-250, 0), CGPointMake(-200, 0), CGPointMake(-150, 0),      CGPointMake(-100, 0),                                                                                                 CGPointMake(100, 0),        CGPointMake(150, 0), CGPointMake(200, 0), CGPointMake(250, 0),
            //####################################################################################################################################################################################################################
            CGPointMake(-250, -50), CGPointMake(-200, -50), CGPointMake(-150, -50),    CGPointMake(-100, -50),                                                                                             CGPointMake(100, -50),      CGPointMake(150, -50), CGPointMake(200, -50), CGPointMake(250, -50),
            //####################################################################################################################################################################################################################
            CGPointMake(-250, -100), CGPointMake(-200, -100), CGPointMake(-150, -100),   CGPointMake(-100, -100),        CGPointMake(-50, -100),     CGPointMake(0, -100),       CGPointMake(50, -100),      CGPointMake(100, -100),     CGPointMake(150, -100), CGPointMake(200, -100), CGPointMake(250, -100),
            //####################################################################################################################################################################################################################
            CGPointMake(-250, -150), CGPointMake(-200, -150), CGPointMake(-150, -150),   CGPointMake(-100, -150),        CGPointMake(-50, -150),     CGPointMake(0, -150),       CGPointMake(50, -150),      CGPointMake(100, -150),     CGPointMake(150, -150), CGPointMake(200, -150), CGPointMake(250, -150),
            //####################################################################################################################################################################################################################
            CGPointMake(-250, -200), CGPointMake(-200, -200), CGPointMake(-150, -200),   CGPointMake(-100, -200),        CGPointMake(-50, -200),     CGPointMake(0, -200),       CGPointMake(50, -200),      CGPointMake(100, -200),     CGPointMake(150, -200), CGPointMake(200, -200), CGPointMake(250, -200),
            //####################################################################################################################################################################################################################
            CGPointMake(-250, -250), CGPointMake(-200, -250), CGPointMake(-150, -250),   CGPointMake(-100, -250),        CGPointMake(-50, -250),     CGPointMake(0, -250),       CGPointMake(50, -250),      CGPointMake(100, -250),     CGPointMake(150, -250), CGPointMake(200, -250), CGPointMake(250, -250)
            //####################################################################################################################################################################################################################
    ];
    
    let searchArea_s4 =
        [
        //####################################################################################################################################################################################################################
         CGPointMake(-200, 200), CGPointMake(-150, 200),    CGPointMake(-100, 200),         CGPointMake(-50, 200),      CGPointMake(0, 200),        CGPointMake(50, 200),       CGPointMake(100, 200),      CGPointMake(150, 200), CGPointMake(200, 200),
         //####################################################################################################################################################################################################################
         CGPointMake(-200, 150), CGPointMake(-150, 150),    CGPointMake(-100, 150),         CGPointMake(-50, 150),      CGPointMake(0, 150),        CGPointMake(50, 150),       CGPointMake(100, 150),      CGPointMake(150, 150), CGPointMake(200, 150),
         //####################################################################################################################################################################################################################
         CGPointMake(-200, 100), CGPointMake(-150, 100),    CGPointMake(-100, 100),         CGPointMake(-50, 100),      CGPointMake(0, 100),        CGPointMake(50, 100),       CGPointMake(100, 100),      CGPointMake(150, 100), CGPointMake(200, 100),
         //####################################################################################################################################################################################################################
         CGPointMake(-200, 50), CGPointMake(-150, 50),     CGPointMake(-100, 50),                                                                                               CGPointMake(100, 50),       CGPointMake(150, 50), CGPointMake(200, 50),
         //####################################################################################################################################################################################################################
         CGPointMake(-200, 0), CGPointMake(-150, 0),      CGPointMake(-100, 0),                                                                                                 CGPointMake(100, 0),        CGPointMake(150, 0), CGPointMake(200, 0),
         //####################################################################################################################################################################################################################
         CGPointMake(-200, -50), CGPointMake(-150, -50),    CGPointMake(-100, -50),                                                                                             CGPointMake(100, -50),      CGPointMake(150, -50), CGPointMake(200, -50),
         //####################################################################################################################################################################################################################
         CGPointMake(-200, -100), CGPointMake(-150, -100),   CGPointMake(-100, -100),        CGPointMake(-50, -100),     CGPointMake(0, -100),       CGPointMake(50, -100),      CGPointMake(100, -100),     CGPointMake(150, -100), CGPointMake(200, -100),
         //####################################################################################################################################################################################################################
         CGPointMake(-200, -150), CGPointMake(-150, -150),   CGPointMake(-100, -150),        CGPointMake(-50, -150),     CGPointMake(0, -150),       CGPointMake(50, -150),      CGPointMake(100, -150),     CGPointMake(150, -150), CGPointMake(200, -150),
         CGPointMake(-200, -200), CGPointMake(-150, -200),   CGPointMake(-100, -200),        CGPointMake(-50, -200),     CGPointMake(0, -200),       CGPointMake(50, -200),      CGPointMake(100, -200),     CGPointMake(150, -200), CGPointMake(200, -200)
    //####################################################################################################################################################################################################################
    ];
    
    let searchArea_s3 =
        [
            //####################################################################################################################################################################################################################
            CGPointMake(-150, 150),    CGPointMake(-100, 150),         CGPointMake(-50, 150),      CGPointMake(0, 150),        CGPointMake(50, 150),       CGPointMake(100, 150),      CGPointMake(150, 150),
            //####################################################################################################################################################################################################################
            CGPointMake(-150, 100),    CGPointMake(-100, 100),         CGPointMake(-50, 100),      CGPointMake(0, 100),        CGPointMake(50, 100),       CGPointMake(100, 100),      CGPointMake(150, 100),
            //####################################################################################################################################################################################################################
            CGPointMake(-150, 50),     CGPointMake(-100, 50),          CGPointMake(-50, 50),       CGPointMake(0, 50),         CGPointMake(50, 50),        CGPointMake(100, 50),       CGPointMake(150, 50),
            //####################################################################################################################################################################################################################
            CGPointMake(-150, 0),      CGPointMake(-100, 0),           CGPointMake(-50, 0),        CGPointMake(0, 0),          CGPointMake(50, 0),         CGPointMake(100, 0),        CGPointMake(150, 0),
            //####################################################################################################################################################################################################################
            CGPointMake(-150, -50),    CGPointMake(-100, -50),         CGPointMake(-50, -50),      CGPointMake(0, -50),        CGPointMake(50, -50),       CGPointMake(100, -50),      CGPointMake(150, -50),
            //####################################################################################################################################################################################################################
            CGPointMake(-150, -100),   CGPointMake(-100, -100),        CGPointMake(-50, -100),     CGPointMake(0, -100),       CGPointMake(50, -100),      CGPointMake(100, -100),     CGPointMake(150, -100),
            //####################################################################################################################################################################################################################
            CGPointMake(-150, -150),   CGPointMake(-100, -150),        CGPointMake(-50, -150),     CGPointMake(0, -150),       CGPointMake(50, -150),      CGPointMake(100, -150),     CGPointMake(150, -150)
            //####################################################################################################################################################################################################################
    ];
    
    let searchArea_s2 =
        [CGPointMake(-100, 100),    CGPointMake(-50, 100),  CGPointMake(0, 100),  CGPointMake(50, 100), CGPointMake(100, 100),
         CGPointMake(-100, 50),     CGPointMake(-50, 50),   CGPointMake(0, 50),   CGPointMake(50, 50),  CGPointMake(100, 50),
         CGPointMake(-100, 0),      CGPointMake(-50, 0),    CGPointMake(0, 0),    CGPointMake(50, 0),   CGPointMake(100, 0),
         CGPointMake(-100, -50),     CGPointMake(-50, -50),   CGPointMake(0, -50),   CGPointMake(50, -50),  CGPointMake(100, -50),
         CGPointMake(-100, -100),    CGPointMake(-50, -100),  CGPointMake(0, -100),  CGPointMake(50, -100), CGPointMake(100, -100)];
    
    let searchArea_s1 =
        [
            CGPointMake(-50, 50),   CGPointMake(0, 50),   CGPointMake(50, 50),
            CGPointMake(-50, 0),    CGPointMake(0, 0),    CGPointMake(50, 0),
            CGPointMake(-50, -50),   CGPointMake(0, -50),   CGPointMake(50, -50),
            ];
}

public func logg(line: Any) {
    //print(line)
}

public func print123(line: Any) {
    print(line)
}






/*
 
 let searchArea_s4 =
 [
 //####################################################################################################################################################################################################################
 CGPointMake(-200, 200), CGPointMake(-150, 200),    CGPointMake(-100, 200),         CGPointMake(-50, 200),      CGPointMake(0, 200),        CGPointMake(50, 200),       CGPointMake(100, 200),      CGPointMake(150, 200), CGPointMake(200, 200),
 //####################################################################################################################################################################################################################
 CGPointMake(-200, 150), CGPointMake(-150, 150),    CGPointMake(-100, 150),         CGPointMake(-50, 150),      CGPointMake(0, 150),        CGPointMake(50, 150),       CGPointMake(100, 150),      CGPointMake(150, 150), CGPointMake(200, 150),
 //####################################################################################################################################################################################################################
 CGPointMake(-200, 100), CGPointMake(-150, 100),    CGPointMake(-100, 100),         CGPointMake(-50, 100),      CGPointMake(0, 100),        CGPointMake(50, 100),       CGPointMake(100, 100),      CGPointMake(150, 100), CGPointMake(200, 100),
 //####################################################################################################################################################################################################################
 CGPointMake(-200, 50), CGPointMake(-150, 50),     CGPointMake(-100, 50),          CGPointMake(-50, 50),       CGPointMake(0, 50),         CGPointMake(50, 50),        CGPointMake(100, 50),       CGPointMake(150, 50), CGPointMake(200, 50),
 //####################################################################################################################################################################################################################
 CGPointMake(-200, 0), CGPointMake(-150, 0),      CGPointMake(-100, 0),           CGPointMake(-50, 0),        CGPointMake(0, 0),          CGPointMake(50, 0),         CGPointMake(100, 0),        CGPointMake(150, 0), CGPointMake(200, 0),
 //####################################################################################################################################################################################################################
 CGPointMake(-200, -50), CGPointMake(-150, -50),    CGPointMake(-100, -50),         CGPointMake(-50, -50),      CGPointMake(0, -50),        CGPointMake(50, -50),       CGPointMake(100, -50),      CGPointMake(150, -50), CGPointMake(200, -50),
 //####################################################################################################################################################################################################################
 CGPointMake(-200, -100), CGPointMake(-150, -100),   CGPointMake(-100, -100),        CGPointMake(-50, -100),     CGPointMake(0, -100),       CGPointMake(50, -100),      CGPointMake(100, -100),     CGPointMake(150, -100), CGPointMake(200, -100),
 //####################################################################################################################################################################################################################
 CGPointMake(-200, -150), CGPointMake(-150, -150),   CGPointMake(-100, -150),        CGPointMake(-50, -150),     CGPointMake(0, -150),       CGPointMake(50, -150),      CGPointMake(100, -150),     CGPointMake(150, -150), CGPointMake(200, -150),
 CGPointMake(-200, -200), CGPointMake(-150, -200),   CGPointMake(-100, -200),        CGPointMake(-50, -200),     CGPointMake(0, -200),       CGPointMake(50, -200),      CGPointMake(100, -200),     CGPointMake(150, -200), CGPointMake(200, -200)
 //####################################################################################################################################################################################################################
 ];
 
 */