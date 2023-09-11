//
//  GameViewController.swift
//  Game
//
//  Created by David Ulvan on 2023-09-11.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var lblPlayerX: UILabel!
    @IBOutlet weak var lblPlayerO: UILabel!
    
    var playerXname: String?
    var playerOname: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let playerXname = playerXname {
            lblPlayerX.text = playerXname
        }
        if let playerOname = playerOname {
            lblPlayerO.text = playerOname
        }
        // Do any additional setup after loading the view.
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
