//
//  Player_V_Player_ViewController.swift
//  Game
//
//  Created by David Ulvan on 2023-09-11.
//

import UIKit

class Player_V_Player_ViewController: UIViewController {
    
    
    @IBOutlet weak var txtPlayerX: UITextField!
    @IBOutlet weak var txtPlayerO: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == NAV_TO_GAME {
            if let destVC = segue.destination as? GameViewController {
               
                if txtPlayerX.text != "" && txtPlayerO.text != ""{
                    destVC.playerXname = txtPlayerX.text
                    destVC.playerOname = txtPlayerO.text
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
