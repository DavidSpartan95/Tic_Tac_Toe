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
    
    @IBOutlet var boardImageViews: [UIImageView]!
    @IBOutlet weak var lblPlayerX: UILabel!
    @IBOutlet weak var lblPlayerO: UILabel!
    
    //Board that remembers all the markers has been placed
    var board = Array(repeating: marker.empty, count: 9)
    var playerXname: String?
    var playerOname: String?
    var playerXturn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let playerXname = playerXname {
            lblPlayerX.text = playerXname
        }
        if let playerOname = playerOname {
            lblPlayerO.text = playerOname
        }
    
    }
    
    @IBAction func tapOnBoard(_ sender: UITapGestureRecognizer) {
        print(getTag(sender))
        placeMarker(tag: getTag(sender), playerXturn: playerXturn)
        playerXturn.toggle()
    }
    
    func placeMarker(tag:Int, playerXturn: Bool){
        let symbol = (playerXturn.self) ? marker.X : marker.O
        let image = (symbol == marker.X) ? "xmark" : "circle"
        guard tag >= 0 && tag < boardImageViews.count else { return }
            boardImageViews[tag].image = UIImage(systemName: image)
    }
    
    func getTag(_ tapGesture: UITapGestureRecognizer) -> Int{
        if let imageView = tapGesture.view as? UIImageView {
            let tag = imageView.tag
            return tag
        }
        return -1
    }
    
}
