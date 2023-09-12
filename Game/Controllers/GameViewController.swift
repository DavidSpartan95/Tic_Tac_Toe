//
//  GameViewController.swift
//  Game
//
//  Created by David Ulvan on 2023-09-11.
//

import UIKit

 enum marker {
    case X,O,empty
}

class GameViewController: UIViewController {
    
    @IBOutlet weak var lblPlayerX: UILabel!
    @IBOutlet weak var lblPlayerO: UILabel!
    
    @IBOutlet weak var A1: UIImageView!
    @IBOutlet weak var A2: UIImageView!
    @IBOutlet weak var A3: UIImageView!
    @IBOutlet weak var B1: UIImageView!
    @IBOutlet weak var B2: UIImageView!
    @IBOutlet weak var B3: UIImageView!
    @IBOutlet weak var C1: UIImageView!
    @IBOutlet weak var C2: UIImageView!
    @IBOutlet weak var C3: UIImageView!
    
    var boardImageViews: [UIImageView] = []
    
    var board = Array(repeating: marker.empty, count: 9)
    var playerXname: String?
    var playerOname: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardImageViews = [A1, A2, A3, B1, B2, B3, C1, C2, C3]
        
        if let playerXname = playerXname {
            lblPlayerX.text = playerXname
        }
        if let playerOname = playerOname {
            lblPlayerO.text = playerOname
        }
        // Do any additional setup after loading the view.
    }
   
    @IBAction func tapA1(_ sender: Any) {
        placeMarker(tag: getTag(sender), symbol: marker.X)
    }
    @IBAction func tapA2(_ sender: Any) {
        placeMarker(tag: getTag(sender), symbol: marker.X)
    }
    @IBAction func tapA3(_ sender: Any) {
        placeMarker(tag: getTag(sender), symbol: marker.X)
    }
    @IBAction func tapB1(_ sender: Any) {
        placeMarker(tag: getTag(sender), symbol: marker.X)
    }
    @IBAction func tapB2(_ sender: Any) {
        placeMarker(tag: getTag(sender), symbol: marker.X)
    }
    @IBAction func tapB3(_ sender: Any) {
        placeMarker(tag: getTag(sender), symbol: marker.X)
    }
    @IBAction func tapC1(_ sender: Any) {
        placeMarker(tag: getTag(sender), symbol: marker.X)
    }
    @IBAction func tapC2(_ sender: Any) {
        placeMarker(tag: getTag(sender), symbol: marker.X)
    }
    @IBAction func tapC3(_ sender: Any) {
        placeMarker(tag: getTag(sender), symbol: marker.X)
    }
    
    func placeMarker(tag:Int, symbol: marker){
        let image = (symbol == marker.X) ? "xmark.circle.fill" : "circle.fill"
        guard tag >= 0 && tag < boardImageViews.count else { return }
            boardImageViews[tag].image = UIImage(systemName: image)
    }
    
    func getTag(_ sender: Any) -> Int{
        if let tapGesture = sender as? UITapGestureRecognizer,
           let imageView = tapGesture.view as? UIImageView {
            let tag = imageView.tag
            return tag
        }
        return -1
    }
    
}
