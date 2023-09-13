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
        
        if !currentGame.placementIsLegal(atIndex: tag){return}
        print(tag)
        boardImageViews[tag].image = (currentGame.currentSymbol == marker.X) ? UIImage(systemName: "xmark") : UIImage(systemName: "circle")
        
        currentGame.placeMarker(tag: tag)
        
        if currentGame.winCondition(){
            showResult(resultMsg: "\(currentGame.currentSymbol) WON")
        }else if currentGame.boardIsFull(){
            showResult(resultMsg: "DRAW")
        }
    }

    func getTag(_ tapGesture: UITapGestureRecognizer) -> Int?{
        if let imageView = tapGesture.view as? UIImageView {
            let tag = imageView.tag
            return tag
        }
        return nil
    }
    func resetGame(){
        //remove all the images
        for x in boardImageViews {x.image = nil}
    }
    
    func showResult(resultMsg: String){
        let alertController = UIAlertController(
                title: "RESULT",
                message: "\(resultMsg)",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: { _ in
                    self.resetGame()
                    self.currentGame.reset()
                }
            )
            alertController.addAction(okAction)
            // Present the alert
            present(alertController, animated: true, completion: nil)
    }
    
}
