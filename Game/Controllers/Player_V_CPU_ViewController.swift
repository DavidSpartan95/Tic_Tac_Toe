//
//  Player_VS_CPU_ViewController.swift
//  Game
//
//  Created by David Ulvan on 2023-09-11.
//

import UIKit
let NAV_TO_GAME_FROM_CPU = "navToGameFromCPU"
class Player_V_CPU_ViewController: UIViewController {
    @IBOutlet weak var txtFiledName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == NAV_TO_GAME_FROM_CPU {
            if let destVC = segue.destination as? GameViewController {
               
                if txtFiledName.text != ""{
                    destVC.playerXname = txtFiledName.text
                }
                destVC.currentGame.CPUon = true
            }
        }
    }
    
}
