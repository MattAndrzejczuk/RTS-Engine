//
//  UIPlayerControlPanel.swift
//  3D RPG Engine
//
//  Created by Mateusz Andrzejczuk on 8/4/16.
//  Copyright © 2016 Core Prime Inc. All rights reserved.
//

import Foundation
import SpriteKit

let Z_POSITION_PLAYER_STATS_CONTROLS: CGFloat! = 2501
let FONT_SIZE: CGFloat! = 32

class UIPlayerControlPanel : NSObject, UIPlayerComponents {
    
    
    var GameSceneRef: GameScene
    
    var inventoryButton = AttackButton(imageNamed: "btn-attack-idle")
    var attackButton = AttackButton(imageNamed: "btn-attack-idle")
    var ralleyButton = AttackButton(imageNamed: "btn-levelUp-idle")
    
    var spell1Button = AttackButton(imageNamed: "btn-ralley-idle")
    var spell2Button = AttackButton(imageNamed: "btn-frozenOrb-idle")
    var spell3Button = AttackButton(imageNamed: "btn-explosion-idle")
    var spell4Button = AttackButton(imageNamed: "btn-blizzard-idle")
    
    // HEALTH, MANA & EXP BARS:
    var HealthJUICE = SKSpriteNode(imageNamed: "healthBar")
    var ManaJUICE = SKSpriteNode(imageNamed: "manaBar")
    var ExpJUICE = SKSpriteNode(imageNamed: "expBar")
    var HealthContainer = SKSpriteNode(imageNamed: "barcontainer")
    var ManaContainer = SKSpriteNode(imageNamed: "barcontainer")
    var ExpContainer = SKSpriteNode(imageNamed: "barcontainer")
    var HealthContainer2 = SKSpriteNode(imageNamed: "barcontainer")
    var ManaContainer2 = SKSpriteNode(imageNamed: "barcontainer")
    var ExpContainer2 = SKSpriteNode(imageNamed: "barcontainer")
    
    var joyStick: Joystick = Joystick()
    
    var panelView: SKSpriteNode = SKSpriteNode(imageNamed: "SearchRadiusDummyV")
    var labelUnitName = SKLabelNode(fontNamed:"Copperplate")
    var labelArmor = SKLabelNode(fontNamed:"Copperplate")
    var labelDamage = SKLabelNode(fontNamed:"Copperplate")
    var labelSight = SKLabelNode(fontNamed:"Copperplate")
    var labelSpeed = SKLabelNode(fontNamed:"Copperplate")
    
    var guiTimer: Timer?
    var focusedUnit: AbstractUnit?
    
    var PlayerStatsWindow = SKSpriteNode(imageNamed: "stonePanelWindow")
    
    var lblPlayerLevel = SKLabelNode(fontNamed:"Copperplate")
    var lblPointsToSpend = SKLabelNode(fontNamed:"Copperplate")
    
    var lblPlayerHP = SKLabelNode(fontNamed:"Copperplate")
    var lblPlayerMana = SKLabelNode(fontNamed:"Copperplate")
    var lblPlayerDMG = SKLabelNode(fontNamed:"Copperplate")
    var lblPlayerARM = SKLabelNode(fontNamed:"Copperplate")

    
    var lblStatsStrength = SKLabelNode(fontNamed:"Copperplate")
    var lblStatsDexterity = SKLabelNode(fontNamed:"Copperplate")
    var lblStatsStamina = SKLabelNode(fontNamed:"Copperplate")
    var lblStatsMagic = SKLabelNode(fontNamed:"Copperplate")
    var lblStatsStrengthValue = SKLabelNode(fontNamed:"Copperplate")
    var lblStatsDexterityValue = SKLabelNode(fontNamed:"Copperplate")
    var lblStatsStaminaValue = SKLabelNode(fontNamed:"Copperplate")
    var lblStatsMagicValue = SKLabelNode(fontNamed:"Copperplate")
    
    var btnStrength = AttackButton(imageNamed: "btn-levelUp-idle")
    var btnDexterity = AttackButton(imageNamed: "btn-levelUp-idle")
    var btnStamina = AttackButton(imageNamed: "btn-levelUp-idle")
    var btnMagic = AttackButton(imageNamed: "btn-levelUp-idle")
    var btnCloseStats = AttackButton(imageNamed: "btn-stone-idle")
    
    var heroStat: HeroStat?
    
//    override init() {
//        super.init()
//    }
    
    // useless
    func castMissileAttack() {
        self.GameSceneRef.executeCohortFormationSequence()
    }
    
    func castSpell1() {
        print("BUTTON IS IN DEBUG MODE!!!")
//        self.GameSceneRef.autoCompletePlainGrassNodes() //MAP EDITOR
//        self.GameSceneRef.executeCohortFormationSequence()
        
        self.GameSceneRef.connectGameSceneToWebSocket()
    }
    func castSpell2() {
//        self.GameSceneRef.fireFrozenOrbPlayerHelper()
//        self.GameSceneRef.resetMapEditor() //MAP EDITOR
        self.GameSceneRef.sendTestDebugPingToSocket()
    }
    func castSpell3() {
//        self.GameSceneRef.DIRT_BRUSH_ENABLED = !self.GameSceneRef.DIRT_BRUSH_ENABLED //MAP EDITOR
//        self.GameSceneRef.fireMissileBombPlayerHelper()
        self.GameSceneRef.joinMultiplayerGame()
    }
    func castSpell4() {
//        self.GameSceneRef.autoCorrectGrassCornerNodes() //MAP EDITOR
//        self.GameSceneRef.playerCastBlizzardHelper()
        self.GameSceneRef.joinMultiplayerGame()
    }
    
    func hideStatsWindow() {
        PlayerStatsWindow.isHidden = true
        
        btnStrength.isHidden = true
        btnDexterity.isHidden = true
        btnStamina.isHidden = true
        btnMagic.isHidden = true
        btnCloseStats.isHidden = true
        
        lblStatsStrength.isHidden = true
        lblStatsDexterity.isHidden = true
        lblStatsStamina.isHidden = true
        lblStatsMagic.isHidden = true
        
        lblStatsStrengthValue.isHidden = true
        lblStatsDexterityValue.isHidden = true
        lblStatsStaminaValue.isHidden = true
        lblStatsMagicValue.isHidden = true
        
        lblPlayerLevel.isHidden = true
        lblPlayerHP.isHidden = true
        lblPlayerMana.isHidden = true
        lblPlayerDMG.isHidden = true
        lblPlayerARM.isHidden = true
        lblPointsToSpend.isHidden = true
    }
    
    func showStatsWindow() {
        PlayerStatsWindow.isHidden = false
        
        btnStrength.isHidden = false
        btnDexterity.isHidden = false
        btnStamina.isHidden = false
        btnMagic.isHidden = false
        btnCloseStats.isHidden = false
        
        lblStatsStrength.isHidden = false
        lblStatsDexterity.isHidden = false
        lblStatsStamina.isHidden = false
        lblStatsMagic.isHidden = false
        
        lblStatsStrengthValue.isHidden = false
        lblStatsDexterityValue.isHidden = false
        lblStatsStaminaValue.isHidden = false
        lblStatsMagicValue.isHidden = false
        
        lblPlayerLevel.isHidden = false
        lblPlayerHP.isHidden = false
        lblPlayerMana.isHidden = false
        lblPlayerDMG.isHidden = false
        lblPlayerARM.isHidden = false
        lblPointsToSpend.isHidden = false
    }
    
    init(gameScene: GameScene, playerUnit: AbstractUnit) {
        self.GameSceneRef = gameScene
        self.heroStat = HeroStat(unit: playerUnit)
        
        labelUnitName.position = CGPoint(x: (gameScene.size.width * 0.9), y: (gameScene.size.height * 0.94))
        labelUnitName.text = "Footman"
        labelUnitName.zPosition = 2001
        labelUnitName.fontSize = 28
        
        labelArmor.position = CGPoint(x: (gameScene.size.width * 0.9), y: (gameScene.size.height * 0.86))
        labelArmor.text = "Armor: 0"
        labelArmor.zPosition = 2001
        labelArmor.fontSize = 28
        
        labelDamage.position = CGPoint(x: (gameScene.size.width * 0.9), y: (gameScene.size.height * 0.81))
        labelDamage.text = "Damage: 1"
        labelDamage.zPosition = 2001
        labelDamage.fontSize = 28
        
        labelSight.position = CGPoint(x: (gameScene.size.width * 0.9), y: (gameScene.size.height * 0.76))
        labelSight.text = "Sight: 5"
        labelSight.zPosition = 2001
        labelSight.fontSize = 28
        
        labelSpeed.position = CGPoint(x: (gameScene.size.width * 0.9), y: (gameScene.size.height * 0.71))
        labelSpeed.text = "Speed: 4"
        labelSpeed.zPosition = 2001
        labelSpeed.fontSize = 28
        
        self.panelView.xScale = 5.0
        self.panelView.yScale = 12.0
        self.panelView.position = CGPoint(x: (gameScene.size.width * 0.91), y: (gameScene.size.height * 0.70))
        self.panelView.zPosition = 2000
        
        self.attackButton.xScale = 0.30
        self.attackButton.yScale = 0.30
        self.attackButton.position = CGPoint(x: (gameScene.size.width * 0.95), y: 90)
        self.attackButton.zPosition = 2000
        self.attackButton.nameCustom = "attack"
        
        //self.ralleyButton.xScale = 0.65
        //self.ralleyButton.yScale = 0.65
        //self.ralleyButton.position = CGPointMake((gameScene.size.width * 0.77), 150)
        //self.ralleyButton.zPosition = 2000
        //self.ralleyButton.nameCustom = "lvlUp"
        
        self.spell1Button.xScale = 0.30
        self.spell1Button.yScale = 0.30
        self.spell1Button.position = CGPoint(x: (gameScene.size.width * 0.59), y: 90) /// 0.55  / no 4 / no 15
        self.spell1Button.zPosition = 2000
        self.spell1Button.nameCustom = "spell1"
        
        self.spell2Button.xScale = 0.30
        self.spell2Button.yScale = 0.30
        self.spell2Button.position = CGPoint(x: (gameScene.size.width * 0.68), y: 90)
        self.spell2Button.zPosition = 2000
        self.spell2Button.nameCustom = "spell2"
        
        self.spell3Button.xScale = 0.30
        self.spell3Button.yScale = 0.30
        self.spell3Button.position = CGPoint(x: (gameScene.size.width * 0.77), y: 90)
        self.spell3Button.zPosition = 2000
        self.spell3Button.nameCustom = "spell3"
        
        self.spell4Button.xScale = 0.30
        self.spell4Button.yScale = 0.30
        self.spell4Button.position = CGPoint(x: (gameScene.size.width * 0.86), y: 90)
        self.spell4Button.zPosition = 2000
        self.spell4Button.nameCustom = "spell4"
        
        self.ralleyButton.xScale = 0.20
        self.ralleyButton.yScale = 0.20
        self.ralleyButton.position = CGPoint(x: (gameScene.size.width * 0.5), y: 200)
        self.ralleyButton.zPosition = 2000
        self.ralleyButton.nameCustom = "lvlUp"
        
        self.joyStick.position = CGPoint(x: 150, y: 150)
        self.joyStick.zPosition = 2000
        
        
        
        lblStatsStrength.position = CGPoint(x: (gameScene.size.width * 0.3), y: (gameScene.size.height * 0.25))
        lblStatsStrength.text = "Strength"
        lblStatsStrength.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblStatsStrength.fontSize = FONT_SIZE
        
        lblStatsDexterity.position = CGPoint(x: (gameScene.size.width * 0.3), y: (gameScene.size.height * 0.4))
        lblStatsDexterity.text = "Dexterity"
        lblStatsDexterity.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblStatsDexterity.fontSize = FONT_SIZE
        
        lblStatsStamina.position = CGPoint(x: (gameScene.size.width * 0.3), y: (gameScene.size.height * 0.55))
        lblStatsStamina.text = "Stamina"
        lblStatsStamina.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblStatsStamina.fontSize = FONT_SIZE
        
        lblStatsMagic.position = CGPoint(x: (gameScene.size.width * 0.3), y: (gameScene.size.height * 0.7))
        lblStatsMagic.text = "Magic"
        lblStatsMagic.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblStatsMagic.fontSize = FONT_SIZE
        
        
        lblStatsStrengthValue.position = CGPoint(x: (gameScene.size.width * 0.40), y: (gameScene.size.height * 0.25))
        lblStatsStrengthValue.text = String(heroStat!.Strength)
        lblStatsStrengthValue.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblStatsStrengthValue.fontSize = FONT_SIZE
        
        lblStatsDexterityValue.position = CGPoint(x: (gameScene.size.width * 0.40), y: (gameScene.size.height * 0.4))
        lblStatsDexterityValue.text = String(heroStat!.Dexterity)
        lblStatsDexterityValue.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblStatsDexterityValue.fontSize = FONT_SIZE
        
        lblStatsStaminaValue.position = CGPoint(x: (gameScene.size.width * 0.40), y: (gameScene.size.height * 0.55))
        lblStatsStaminaValue.text = String(heroStat!.Stamina)
        lblStatsStaminaValue.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblStatsStaminaValue.fontSize = FONT_SIZE
        
        lblStatsMagicValue.position = CGPoint(x: (gameScene.size.width * 0.40), y: (gameScene.size.height * 0.7))
        lblStatsMagicValue.text = String(heroStat!.Magic)
        lblStatsMagicValue.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblStatsMagicValue.fontSize = FONT_SIZE
        
        
        lblPlayerLevel.position = CGPoint(x: (gameScene.size.width * 0.30), y: (gameScene.size.height * 0.8))
        lblPlayerLevel.text = "Level \(heroStat!.Level)"
        lblPlayerLevel.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblPlayerLevel.fontSize = FONT_SIZE
        lblPlayerHP.position = CGPoint(x: (gameScene.size.width * 0.65), y: (gameScene.size.height * 0.7))
        lblPlayerHP.text = "Life: \(gameScene.playerSK.HP)/\(gameScene.playerSK.HP_MAX)"
        lblPlayerHP.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblPlayerHP.fontSize = FONT_SIZE
        lblPlayerMana.position = CGPoint(x: (gameScene.size.width * 0.65), y: (gameScene.size.height * 0.6))
        lblPlayerMana.text = "Mana: \(gameScene.playerSK.MANA)/\(gameScene.playerSK.MANA_MAX)"
        lblPlayerMana.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblPlayerMana.fontSize = FONT_SIZE
        lblPlayerDMG.position = CGPoint(x: (gameScene.size.width * 0.65), y: (gameScene.size.height * 0.5))
        lblPlayerDMG.text = "Damage: \(gameScene.playerSK.DMG)"
        lblPlayerDMG.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblPlayerDMG.fontSize = FONT_SIZE
        lblPlayerARM.position = CGPoint(x: (gameScene.size.width * 0.65), y: (gameScene.size.height * 0.4))
        lblPlayerARM.text = "Armor: \(gameScene.playerSK.Armor)"
        lblPlayerARM.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblPlayerARM.fontSize = FONT_SIZE

        lblPointsToSpend.position = CGPoint(x: (gameScene.size.width * 0.50), y: (gameScene.size.height * 0.8))
        lblPointsToSpend.text = "Points To Spend: \(heroStat!.SpendPoints)"
        lblPointsToSpend.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        lblPointsToSpend.fontSize = FONT_SIZE
        
        
        self.PlayerStatsWindow.xScale = 0.30
        self.PlayerStatsWindow.yScale = 0.30
        self.PlayerStatsWindow.position = CGPoint(x: (gameScene.size.width * 0.50), y: (gameScene.size.height * 0.54))
        self.PlayerStatsWindow.zPosition = 2500
        
        self.btnStrength.xScale = 0.25
        self.btnStrength.yScale = 0.25
        self.btnStrength.position = CGPoint(x: (gameScene.size.width * 0.5), y: (gameScene.size.height * 0.25))
        self.btnStrength.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        self.btnStrength.nameCustom = "strength"
        
        self.btnDexterity.xScale = 0.25
        self.btnDexterity.yScale = 0.25
        self.btnDexterity.position = CGPoint(x: (gameScene.size.width * 0.5), y: (gameScene.size.height * 0.4))
        self.btnDexterity.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        self.btnDexterity.nameCustom = "dexterity"
        
        self.btnStamina.xScale = 0.25
        self.btnStamina.yScale = 0.25
        self.btnStamina.position = CGPoint(x: (gameScene.size.width * 0.5), y: (gameScene.size.height * 0.55))
        self.btnStamina.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        self.btnStamina.nameCustom = "stamina"
        
        self.btnMagic.xScale = 0.25
        self.btnMagic.yScale = 0.25
        self.btnMagic.position = CGPoint(x: (gameScene.size.width * 0.5), y: (gameScene.size.height * 0.7))
        self.btnMagic.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        self.btnMagic.nameCustom = "magic"
        
        self.btnCloseStats.xScale = 0.25
        self.btnCloseStats.yScale = 0.25
        self.btnCloseStats.position = CGPoint(x: (gameScene.size.width * 0.75), y: (gameScene.size.height * 0.8))
        self.btnCloseStats.zPosition = Z_POSITION_PLAYER_STATS_CONTROLS
        self.btnCloseStats.nameCustom = "exitstats"
        

        
        
        HealthJUICE.xScale = 3
        HealthJUICE.yScale = 0.5
        HealthJUICE.position = CGPoint(x: 500, y: 50)
        HealthJUICE.zPosition = 2001
        
        ManaJUICE.xScale = 3
        ManaJUICE.yScale = 0.5
        ManaJUICE.position = CGPoint(x: 500, y: 100)
        ManaJUICE.zPosition = 2001
        
        ExpJUICE.xScale = 3
        ExpJUICE.yScale = 0.5
        ExpJUICE.position = CGPoint(x: 500, y: 150)
        ExpJUICE.zPosition = 2001
        
        HealthContainer.xScale = 3.1
        HealthContainer.yScale = 0.51
        HealthContainer.position = CGPoint(x: 499.2, y: 50)
        HealthContainer.zPosition = 2000
        
        ManaContainer.xScale = 3.1
        ManaContainer.yScale = 0.51
        ManaContainer.position = CGPoint(x: 499.1, y: 100)
        ManaContainer.zPosition = 2000
        
        ExpContainer.xScale = 3.1
        ExpContainer.yScale = 0.51
        ExpContainer.position = CGPoint(x: 499.01, y: 150)
        ExpContainer.zPosition = 2000
        
        HealthContainer2.xScale = 1.6
        HealthContainer2.yScale = 0.51
        HealthContainer2.position = CGPoint(x: 460, y: 50)
        HealthContainer2.zPosition = 2002
        
        ManaContainer2.xScale = 1.6
        ManaContainer2.yScale = 0.51
        ManaContainer2.position = CGPoint(x: 460, y: 100)
        ManaContainer2.zPosition = 2002
        
        ExpContainer2.xScale = 1.6
        ExpContainer2.yScale = 0.51
        ExpContainer2.position = CGPoint(x: 460, y: 150)
        ExpContainer2.zPosition = 2002

        
        self.GameSceneRef.addChild(HealthJUICE)
        self.GameSceneRef.addChild(ManaJUICE)
        self.GameSceneRef.addChild(ExpJUICE)
        self.GameSceneRef.addChild(HealthContainer)
        self.GameSceneRef.addChild(ManaContainer)
        self.GameSceneRef.addChild(ExpContainer)
        self.GameSceneRef.addChild(HealthContainer2)
        self.GameSceneRef.addChild(ManaContainer2)
        self.GameSceneRef.addChild(ExpContainer2)
        
//        self.GameSceneRef.addChild(self.panelView)
        self.GameSceneRef.addChild(self.attackButton)
        self.GameSceneRef.addChild(self.ralleyButton)
        self.GameSceneRef.addChild(self.spell1Button)
        self.GameSceneRef.addChild(self.PlayerStatsWindow)
        self.GameSceneRef.addChild(lblPointsToSpend)
        self.GameSceneRef.addChild(self.spell2Button)
        self.GameSceneRef.addChild(self.spell3Button)
        self.GameSceneRef.addChild(self.spell4Button)
        
        self.GameSceneRef.addChild(self.joyStick)
//        self.GameSceneRef.addChild(self.labelUnitName)
//        self.GameSceneRef.addChild(self.labelArmor)
//        self.GameSceneRef.addChild(self.labelDamage)
//        self.GameSceneRef.addChild(self.labelSight)
//        self.GameSceneRef.addChild(self.labelSpeed)
        
        self.GameSceneRef.addChild(btnStrength)
        self.GameSceneRef.addChild(btnDexterity)
        self.GameSceneRef.addChild(btnStamina)
        self.GameSceneRef.addChild(btnMagic)
        self.GameSceneRef.addChild(btnCloseStats)
        
        self.GameSceneRef.addChild(lblStatsStrength)
        self.GameSceneRef.addChild(lblStatsDexterity)
        self.GameSceneRef.addChild(lblStatsStamina)
        self.GameSceneRef.addChild(lblStatsMagic)
        
        self.GameSceneRef.addChild(lblStatsStrengthValue)
        self.GameSceneRef.addChild(lblStatsDexterityValue)
        self.GameSceneRef.addChild(lblStatsStaminaValue)
        self.GameSceneRef.addChild(lblStatsMagicValue)
        
        self.GameSceneRef.addChild(lblPlayerLevel)
        self.GameSceneRef.addChild(lblPlayerHP)
        self.GameSceneRef.addChild(lblPlayerMana)
        self.GameSceneRef.addChild(lblPlayerDMG)
        self.GameSceneRef.addChild(lblPlayerARM)
        
        
    }
    
    func toggleHidePointsToSpend() {
        
    }
    
    func updateLevelValues() {
        let experience = CGFloat((self.heroStat!.XP)) / CGFloat((self.heroStat?.XP_MAX)!)
        self.updateResourceBar(experience, resourceType: .exp)
        
        let maxHP = self.GameSceneRef.playerSK.HP_MAX
        let maxMana = self.GameSceneRef.playerSK.MANA_MAX
        let armor = self.GameSceneRef.playerSK.Armor_MAX
        let dmg = self.GameSceneRef.playerSK.DMG_MAX
        
        self.GameSceneRef.playerSK.HP_MAX = maxHP + (heroStat?.BonusHP)!
        self.GameSceneRef.playerSK.MANA_MAX = maxMana + (heroStat?.BonusMagic)!
        self.GameSceneRef.playerSK.Armor = armor + (heroStat?.BonusARM)!
        self.GameSceneRef.playerSK.DMG = dmg + (heroStat?.BonusDMG)!
        
        lblStatsStrengthValue.text = String(heroStat!.Strength)
        lblStatsDexterityValue.text = String(heroStat!.Dexterity)
        lblStatsStaminaValue.text = String(heroStat!.Stamina)
        lblStatsMagicValue.text = String(heroStat!.Magic)
        lblPlayerLevel.text = "Level \(heroStat!.Level)"
        lblPlayerHP.text = "Life: \(GameSceneRef.playerSK.HP)/\(GameSceneRef.playerSK.HP_MAX)"
        lblPlayerMana.text = "Mana: \(GameSceneRef.playerSK.MANA)/\(GameSceneRef.playerSK.MANA_MAX)"
        lblPlayerDMG.text = "Damage: \(GameSceneRef.playerSK.DMG)"
        lblPlayerARM.text = "Armor: \(GameSceneRef.playerSK.Armor)"
        lblPointsToSpend.text = "Points To Spend: \(heroStat!.SpendPoints)"
        
    }
    
    func activateFromViewController() {
        guiTimer = Timer.scheduledTimer(timeInterval: 0.1,
                                                          target: self,
                                                          selector: #selector(UIPlayerControlPanel.updateGUIFromTimer),
                                                          userInfo: nil,
                                                          repeats: true)
        self.attackButton.makeInteractable(self)
        self.ralleyButton.makeInteractable(self)
        self.btnStrength.makeInteractable(self)
        self.btnDexterity.makeInteractable(self)
        self.btnStamina.makeInteractable(self)
        self.btnMagic.makeInteractable(self)
        self.btnCloseStats.makeInteractable(self)
        self.spell1Button.makeInteractable(self)
        self.spell2Button.makeInteractable(self)
        self.spell3Button.makeInteractable(self)
        self.spell4Button.makeInteractable(self)
        
        if let stat = heroStat {
            if stat.SpendPoints <= 0 {
                ralleyButton.isHidden = false
            }
        }
    }
    
    func updateGUIFromTimer() {
        if let unit = focusedUnit {
            self.labelUnitName.text = unit.nameGUI
            self.labelArmor.text = "Armor: \(unit.Armor)"
            self.labelSpeed.text = "HP: \(unit.HP) "
            self.labelDamage.text = "Damage: \(unit.DMG) "
        }
    }
    
    
    
    func moveByXPositive() {
        panelView.position.x += MIN_GRID_SIZE
        attackButton.position.x += MIN_GRID_SIZE
        joyStick.position.x += MIN_GRID_SIZE
//        self.GameSceneRef.playerDidTouchNewRallyForcesButton()
        labelUnitName.position.x += MIN_GRID_SIZE
        labelArmor.position.x += MIN_GRID_SIZE
        labelDamage.position.x += MIN_GRID_SIZE
        labelSight.position.x += MIN_GRID_SIZE
        labelSpeed.position.x += MIN_GRID_SIZE
        ralleyButton.position.x += MIN_GRID_SIZE
        spell4Button.position.x += MIN_GRID_SIZE
        spell3Button.position.x += MIN_GRID_SIZE
        spell2Button.position.x += MIN_GRID_SIZE
        spell1Button.position.x += MIN_GRID_SIZE
        
        ManaContainer.position.x += MIN_GRID_SIZE
        ExpContainer.position.x += MIN_GRID_SIZE
        HealthContainer.position.x += MIN_GRID_SIZE
        ManaContainer2.position.x += MIN_GRID_SIZE
        ExpContainer2.position.x += MIN_GRID_SIZE
        HealthContainer2.position.x += MIN_GRID_SIZE
        ExpJUICE.position.x += MIN_GRID_SIZE
        ManaJUICE.position.x += MIN_GRID_SIZE
        HealthJUICE.position.x += MIN_GRID_SIZE
        
        // SKILLS WINDOW
        btnStrength.position.x += MIN_GRID_SIZE
        btnDexterity.position.x += MIN_GRID_SIZE
        btnStamina.position.x += MIN_GRID_SIZE
        btnMagic.position.x += MIN_GRID_SIZE
        btnCloseStats.position.x += MIN_GRID_SIZE
        lblStatsStrength.position.x += MIN_GRID_SIZE
        lblStatsDexterity.position.x += MIN_GRID_SIZE
        lblStatsStamina.position.x += MIN_GRID_SIZE
        lblStatsMagic.position.x += MIN_GRID_SIZE
        lblStatsStrengthValue.position.x += MIN_GRID_SIZE
        lblStatsDexterityValue.position.x += MIN_GRID_SIZE
        lblStatsStaminaValue.position.x += MIN_GRID_SIZE
        lblStatsMagicValue.position.x += MIN_GRID_SIZE
        lblPlayerLevel.position.x += MIN_GRID_SIZE
        lblPlayerHP.position.x += MIN_GRID_SIZE
        lblPlayerMana.position.x += MIN_GRID_SIZE
        lblPlayerDMG.position.x += MIN_GRID_SIZE
        lblPlayerARM.position.x += MIN_GRID_SIZE
        PlayerStatsWindow.position.x += MIN_GRID_SIZE
        lblPointsToSpend.position.x += MIN_GRID_SIZE
        // SKILLS WINDOW
    }
    func moveByXNegative() {
        panelView.position.x -= MIN_GRID_SIZE
        attackButton.position.x -= MIN_GRID_SIZE
        joyStick.position.x -= MIN_GRID_SIZE
//        self.GameSceneRef.playerDidTouchNewRallyForcesButton()
        labelUnitName.position.x -= MIN_GRID_SIZE
        labelArmor.position.x -= MIN_GRID_SIZE
        labelDamage.position.x -= MIN_GRID_SIZE
        labelSight.position.x -= MIN_GRID_SIZE
        labelSpeed.position.x -= MIN_GRID_SIZE
        ralleyButton.position.x -= MIN_GRID_SIZE
        spell4Button.position.x -= MIN_GRID_SIZE
        spell3Button.position.x -= MIN_GRID_SIZE
        spell2Button.position.x -= MIN_GRID_SIZE
        spell1Button.position.x -= MIN_GRID_SIZE
        
        ManaContainer2.position.x -= MIN_GRID_SIZE
        ExpContainer2.position.x -= MIN_GRID_SIZE
        HealthContainer2.position.x -= MIN_GRID_SIZE
        ManaContainer.position.x -= MIN_GRID_SIZE
        ExpContainer.position.x -= MIN_GRID_SIZE
        HealthContainer.position.x -= MIN_GRID_SIZE
        ExpJUICE.position.x -= MIN_GRID_SIZE
        ManaJUICE.position.x -= MIN_GRID_SIZE
        HealthJUICE.position.x -= MIN_GRID_SIZE
        
        // SKILLS WINDOW
        btnStrength.position.x -= MIN_GRID_SIZE
        btnDexterity.position.x -= MIN_GRID_SIZE
        btnStamina.position.x -= MIN_GRID_SIZE
        btnMagic.position.x -= MIN_GRID_SIZE
        btnCloseStats.position.x -= MIN_GRID_SIZE
        lblStatsStrength.position.x -= MIN_GRID_SIZE
        lblStatsDexterity.position.x -= MIN_GRID_SIZE
        lblStatsStamina.position.x -= MIN_GRID_SIZE
        lblStatsMagic.position.x -= MIN_GRID_SIZE
        lblStatsStrengthValue.position.x -= MIN_GRID_SIZE
        lblStatsDexterityValue.position.x -= MIN_GRID_SIZE
        lblStatsStaminaValue.position.x -= MIN_GRID_SIZE
        lblStatsMagicValue.position.x -= MIN_GRID_SIZE
        lblPlayerLevel.position.x -= MIN_GRID_SIZE
        lblPlayerHP.position.x -= MIN_GRID_SIZE
        lblPlayerMana.position.x -= MIN_GRID_SIZE
        lblPlayerDMG.position.x -= MIN_GRID_SIZE
        lblPlayerARM.position.x -= MIN_GRID_SIZE
        PlayerStatsWindow.position.x -= MIN_GRID_SIZE
        lblPointsToSpend.position.x -= MIN_GRID_SIZE
        // SKILLS WINDOW
    }
    func moveByYPositive() {
        panelView.position.y += MIN_GRID_SIZE
        attackButton.position.y += MIN_GRID_SIZE
        joyStick.position.y += MIN_GRID_SIZE
//        self.GameSceneRef.playerDidTouchNewRallyForcesButton()
        labelUnitName.position.y += MIN_GRID_SIZE
        labelArmor.position.y += MIN_GRID_SIZE
        labelDamage.position.y += MIN_GRID_SIZE
        labelSight.position.y += MIN_GRID_SIZE
        labelSpeed.position.y += MIN_GRID_SIZE
        ralleyButton.position.y += MIN_GRID_SIZE
        spell4Button.position.y += MIN_GRID_SIZE
        spell3Button.position.y += MIN_GRID_SIZE
        spell2Button.position.y += MIN_GRID_SIZE
        spell1Button.position.y += MIN_GRID_SIZE
        
        ManaContainer2.position.y += MIN_GRID_SIZE
        ExpContainer2.position.y += MIN_GRID_SIZE
        HealthContainer2.position.y += MIN_GRID_SIZE
        ManaContainer.position.y += MIN_GRID_SIZE
        ExpContainer.position.y += MIN_GRID_SIZE
        HealthContainer.position.y += MIN_GRID_SIZE
        ExpJUICE.position.y += MIN_GRID_SIZE
        ManaJUICE.position.y += MIN_GRID_SIZE
        HealthJUICE.position.y += MIN_GRID_SIZE
        
        // SKILLS WINDOW
        btnStrength.position.y += MIN_GRID_SIZE
        btnDexterity.position.y += MIN_GRID_SIZE
        btnStamina.position.y += MIN_GRID_SIZE
        btnMagic.position.y += MIN_GRID_SIZE
        btnCloseStats.position.y += MIN_GRID_SIZE
        lblStatsStrength.position.y += MIN_GRID_SIZE
        lblStatsDexterity.position.y += MIN_GRID_SIZE
        lblStatsStamina.position.y += MIN_GRID_SIZE
        lblStatsMagic.position.y += MIN_GRID_SIZE
        lblStatsStrengthValue.position.y += MIN_GRID_SIZE
        lblStatsDexterityValue.position.y += MIN_GRID_SIZE
        lblStatsStaminaValue.position.y += MIN_GRID_SIZE
        lblStatsMagicValue.position.y += MIN_GRID_SIZE
        lblPlayerLevel.position.y += MIN_GRID_SIZE
        lblPlayerHP.position.y += MIN_GRID_SIZE
        lblPlayerMana.position.y += MIN_GRID_SIZE
        lblPlayerDMG.position.y += MIN_GRID_SIZE
        lblPlayerARM.position.y += MIN_GRID_SIZE
        PlayerStatsWindow.position.y += MIN_GRID_SIZE
        lblPointsToSpend.position.y += MIN_GRID_SIZE
        // SKILLS WINDOW
    }
    func moveByYNegative() {
        panelView.position.y -= MIN_GRID_SIZE
        attackButton.position.y -= MIN_GRID_SIZE
        joyStick.position.y -= MIN_GRID_SIZE
//        self.GameSceneRef.playerDidTouchNewRallyForcesButton()
        labelUnitName.position.y -= MIN_GRID_SIZE
        labelArmor.position.y -= MIN_GRID_SIZE
        labelDamage.position.y -= MIN_GRID_SIZE
        labelSight.position.y -= MIN_GRID_SIZE
        labelSpeed.position.y -= MIN_GRID_SIZE
        ralleyButton.position.y -= MIN_GRID_SIZE
        spell4Button.position.y -= MIN_GRID_SIZE
        spell3Button.position.y -= MIN_GRID_SIZE
        spell2Button.position.y -= MIN_GRID_SIZE
        spell1Button.position.y -= MIN_GRID_SIZE
        
        ManaContainer2.position.y -= MIN_GRID_SIZE
        ExpContainer2.position.y -= MIN_GRID_SIZE
        HealthContainer2.position.y -= MIN_GRID_SIZE
        ManaContainer.position.y -= MIN_GRID_SIZE
        ExpContainer.position.y -= MIN_GRID_SIZE
        HealthContainer.position.y -= MIN_GRID_SIZE
        ExpJUICE.position.y -= MIN_GRID_SIZE
        ManaJUICE.position.y -= MIN_GRID_SIZE
        HealthJUICE.position.y -= MIN_GRID_SIZE
        
        // SKILLS WINDOW
        btnStrength.position.y -= MIN_GRID_SIZE
        btnDexterity.position.y -= MIN_GRID_SIZE
        btnStamina.position.y -= MIN_GRID_SIZE
        btnMagic.position.y -= MIN_GRID_SIZE
        btnCloseStats.position.y -= MIN_GRID_SIZE
        lblStatsStrength.position.y -= MIN_GRID_SIZE
        lblStatsDexterity.position.y -= MIN_GRID_SIZE
        lblStatsStamina.position.y -= MIN_GRID_SIZE
        lblStatsMagic.position.y -= MIN_GRID_SIZE
        lblStatsStrengthValue.position.y -= MIN_GRID_SIZE
        lblStatsDexterityValue.position.y -= MIN_GRID_SIZE
        lblStatsStaminaValue.position.y -= MIN_GRID_SIZE
        lblStatsMagicValue.position.y -= MIN_GRID_SIZE
        lblPlayerLevel.position.y -= MIN_GRID_SIZE
        lblPlayerHP.position.y -= MIN_GRID_SIZE
        lblPlayerMana.position.y -= MIN_GRID_SIZE
        lblPlayerDMG.position.y -= MIN_GRID_SIZE
        lblPlayerARM.position.y -= MIN_GRID_SIZE
        PlayerStatsWindow.position.y -= MIN_GRID_SIZE
        lblPointsToSpend.position.y -= MIN_GRID_SIZE
        // SKILLS WINDOW
    }
    
    func updateXP(_ unit: AbstractUnit) {
        let didLevelUp = heroStat?.addExperience(unit)
        updateLevelValues()
        
        if didLevelUp == true {
            ralleyButton.isHidden = false
        }
    }
    
    func orderPlayerToAttack() {
        self.GameSceneRef.playerDidTouchNewAttackButton()
    }
    
    func orderPlayerToRalleyForces() {
        self.GameSceneRef.playerDidTouchNewRallyForcesButton()
    }
    
    func updateResourceBar(_ percentLeft: CGFloat, resourceType: ResourceBar) {
        let totalValue = percentLeft * 3
        
        if resourceType == .hp {
            HealthJUICE.xScale = totalValue
        }
        else if resourceType == .mana {
            ManaJUICE.xScale = totalValue
        }
        else if resourceType == .exp {
            ExpJUICE.xScale = totalValue
        }
    }
    
    enum ResourceBar {
        case mana, hp, exp
    }
}
