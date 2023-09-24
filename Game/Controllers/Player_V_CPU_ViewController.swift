//
//  Player_VS_CPU_ViewController.swift
//  Game
//
//  Created by David Ulvan on 2023-09-11.
//

import UIKit
let NAV_TO_GAME_FROM_CPU = "navToGameFromCPU"
let NAV_TO_4x4_GAME = "to4x4Game"
class Player_V_CPU_ViewController: UIViewController {
    @IBOutlet weak var txtFiledName: UITextField!
    
    @IBOutlet weak var hardModeSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        hardModeSwitch.isOn = false
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == NAV_TO_GAME_FROM_CPU {
            if let destVC = segue.destination as? GameViewController {
               
                if txtFiledName.text != ""{
                    destVC.playerXname = txtFiledName.text
                }
                destVC.currentGame.CPUon = true
                destVC.hardMode = hardModeSwitch.isOn
            }
        }
        if segue.identifier == NAV_TO_4x4_GAME {
            if let destVC = segue.destination as? _x4GameViewController {
            
                destVC.currentGame.CPUon = true
                print(hardModeSwitch.isOn)
                destVC.hardMode = hardModeSwitch.isOn
            }
        }
    }
}
