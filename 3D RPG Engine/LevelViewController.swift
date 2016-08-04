//
//  LevelViewController.swift
//  3D RPG Engine
//
//  Created by Mateusz Andrzejczuk on 7/27/16.
//  Copyright © 2016 Core Prime Inc. All rights reserved.
//

import UIKit
import SpriteKit

class LevelViewController: UIViewController {

    var CampaignNumber: Int?
    
    var MainGameController: GameViewController?
    
    var currentLevel = 0
    var musicEnabled = false
    
    var musicView: SKView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.purpleColor()
        // Do any additional setup after loading the view.
        
        generateAllButtons()
        
//        let CheckIfGameControllerFinished = NSTimer.scheduledTimerWithTimeInterval(
//            2.0,
//            target: self,
//            selector: Selector("TickScenarioSceneListener"),
//            userInfo: nil,
//            repeats: true
//        );
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "NSNTellLevelControllerToLaunchNextMap:",
                                                         name: "NSNTellLevelControllerToLaunchNextMap",
                                                         object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        /*
         .runAction(SKAction.playSoundFileNamed("Sword\(selectedNumber).wav", waitForCompletion: true))
 */
    }
    
    func DoThisOnce() {
        if musicEnabled == false {

        }

    }
    
    func generateAllButtons() {
        let btn_01 = UIButton(frame: CGRectMake(50,30,250,40))
        btn_01.center.x = self.view.center.x
        btn_01.setTitle("Act I", forState: .Normal)
        btn_01.tag = 1
        btn_01.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn_01.backgroundColor = UIColor.grayColor()
        btn_01.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 16)
        view.addSubview(btn_01)
        
        btn_01.addTarget(self, action: "openMap:", forControlEvents: .TouchUpInside);
        
        
        let btn_02 = UIButton(frame: CGRectMake(50,80,250,40))
        btn_02.center.x = self.view.center.x
        btn_02.setTitle("Act II (coming soon)", forState: .Normal)
        btn_02.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn_02.backgroundColor = UIColor.grayColor()
        btn_02.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 16)
        view.addSubview(btn_02)
        btn_02.enabled = false
        btn_02.alpha = 0.3
        //        btn_02.addTarget(self, action: "switchVC_FlipHorizontal", forControlEvents: .TouchUpInside);
        
        
        let btn_03 = UIButton(frame: CGRectMake(50,130,250,40))
        btn_03.center.x = self.view.center.x
        btn_03.setTitle("Back To Campaign Menu", forState: .Normal)
        btn_03.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn_03.backgroundColor = UIColor.grayColor()
        btn_03.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 16)
        view.addSubview(btn_03)
        
        btn_03.addTarget(self, action: "returnToMainMenu", forControlEvents: .TouchUpInside);
    }
    
    func openMap(sender: UIButton!) {
        let freshGameController = GameViewController()
        MainGameController = freshGameController
        let MapName = "map0\(sender.tag)"
        currentLevel = sender.tag
        print("loading map: '" + MapName + "'")
        if let vc = MainGameController {
            vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
            presentViewController(vc, animated: true, completion: {
                vc.LoadMapPickedFromMainMenu(MapName)
            })
        }
    }
    
    func toggleNextMapAfterVictory() {
        
        DestroyAllSpriteNodesFromCurrentGameScene()
        
        currentLevel += 1
        MainGameController = GameViewController()
        let MapName = "map0\(currentLevel)"
        print("loading map: '" + MapName + "'")
        if let vc = MainGameController {
            vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
            presentViewController(vc, animated: true, completion: {
                vc.LoadNextMapAfterVictory(MapName)
            })
        }
    }
    
    func DestroyAllSpriteNodesFromCurrentGameScene() {
//        MainGameController?.mainScene?.AllUnitsInGameScene
//        if let mgc = MainGameController {
//            if let mainS = mgc.mainScene {
//                for unit in mainS.AllUnitsInGameScene {
//                    unit.disposeOfSpritesAfterGameOver()
//                }
//                print123("ALL UNITS HAVE BEEN WIPED FROM THE GAME SCENE!")
//            }
//        }
    }
    
    func NSNTellLevelControllerToLaunchNextMap(notification: NSNotification) {
        toggleNextMapAfterVictory()
    }
    
    func returnToMainMenu() {
        self.dismissViewControllerAnimated(true, completion: {
        })
    }
}