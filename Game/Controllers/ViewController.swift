//
//  ViewController.swift
//  Game
//
//  Created by David Ulvan on 2023-09-11.
//

import UIKit

let NAV_TO_PVP = "navToPvP"
let NAV_TO_GAME = "navToGame"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == NAV_TO_PVP {
            let destVC = segue.destination as! Player_V_Player_ViewController
        }
    }

    @IBAction func onPvPclick(_ sender: Any) {
        
    }
    
    @IBAction func onPvEclick(_ sender: Any) {
        
    }
    
}

