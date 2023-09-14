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
    
    var playerXname: String?
    var playerOname: String?
    
    let currentGame = Game(playerX: "PlayerX", playerO: "PlayerO",boardSize:9, playerXturn: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let playerXname = playerXname {
            currentGame.playerX = playerXname
            lblPlayerX.text = currentGame.playerX
        }
        if let playerOname = playerOname {
            currentGame.playerO = playerOname
            lblPlayerO.text = currentGame.playerO
        }
    }
    
    @IBAction func tapOnBoard(_ sender: UITapGestureRecognizer) {
        
        guard let tag = getTag(sender) else {return}
        
        if !currentGame.isPlacementLegal(atIndex: tag){return}
        
        boardImageViews[tag].image = (currentGame.currentSymbol == marker.X) ? UIImage(systemName: "xmark") : UIImage(systemName: "circle")
        
        currentGame.placeMarker(tag: tag)

        if currentGame.gameOver(){
            showResult()
        }
    }

    func getTag(_ tapGesture: UITapGestureRecognizer) -> Int?{
        if let imageView = tapGesture.view as? UIImageView {
            let tag = imageView.tag
            return tag
        }
        return nil
    }
    
    func showResult(){
        let alertController = UIAlertController(
                title: "RESULT",
                message: currentGame.resultMSG,
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: { _ in
                    //remove all the images when closing the Alert
                    for x in self.boardImageViews {x.image = nil}
                }
            )
            alertController.addAction(okAction)
            // Present the alert
            present(alertController, animated: true, completion: nil)
    }
    
}
