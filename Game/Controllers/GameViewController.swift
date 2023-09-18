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
    @IBOutlet weak var lblScorePlayerX: UILabel!
    @IBOutlet weak var lblPlayerO: UILabel!
    @IBOutlet weak var lblScorePlayerO: UILabel!
    
    @IBOutlet weak var lblScoreX: UILabel!
    @IBOutlet weak var lblScoreO: UILabel!
    
    @IBOutlet weak var imgArrowX: UIImageView!
    @IBOutlet weak var imgArrowO: UIImageView!
    
    var playerXname: String?
    var playerOname: String?
    
    let currentGame = Game(playerX: "PlayerX", playerO: "PlayerO",boardSize:9, playerXturn: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblScoreX.text = ": \(currentGame.playerXscore)"
        lblScoreO.text = ": \(currentGame.playerOscore)"
        
        updateTurnIndicator(playerXturn: currentGame.playerXturn)
        /*change the value of playerXname and/or playerOname if the user
        typed in a new value for them in previus screen*/
        if let playerXname = playerXname {
            currentGame.playerX = playerXname
            lblPlayerX.text = currentGame.playerX
            lblScorePlayerX.text = playerXname
        }
        if let playerOname = playerOname {
            currentGame.playerO = playerOname
            lblPlayerO.text = currentGame.playerO
            lblScorePlayerO.text = playerOname
        }
    }
    
    @IBAction func tapOnBoard(_ sender: UITapGestureRecognizer) {
        //get tag to find out wich view has been tapped
        guard let tag = getTag(sender) else {return}
        //check if the view is empty/dont contain any X or O maker
        if !currentGame.isPlacementLegal(atIndex: tag){return}
        //change the image of the view
        boardImageViews[tag].image = (currentGame.currentSymbol == marker.X) ? UIImage(systemName: "xmark") : UIImage(systemName: "circle")
        //register were the marker was played to the game class
        currentGame.placeMarker(tag: tag)
        //show result in an Alert if win condition has been meet
        updateTurnIndicator(playerXturn: currentGame.playerXturn)
        if currentGame.gameOver(){
            showResult()
            return
        }
        //If CPU (player vs CPU) has been selected the CPU will place next marker
        if currentGame.CPUon{
            boardImageViews[currentGame.CPUmove()].image = (currentGame.currentSymbol == marker.X) ? UIImage(systemName: "xmark") : UIImage(systemName: "circle")
            updateTurnIndicator(playerXturn: currentGame.playerXturn)
            if currentGame.gameOver(){
                showResult()
            }
        }
    }

    func updateTurnIndicator(playerXturn: Bool) {
        if (playerXturn) {
            imgArrowX.alpha = 1.0
            imgArrowO.alpha = 0.0
        }else{
            imgArrowX.alpha = 0.0
            imgArrowO.alpha = 1.0
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
                    //Update the Score
                    self.lblScoreX.text = ": \(self.currentGame.playerXscore)"
                    self.lblScoreO.text = ": \(self.currentGame.playerOscore)"
                    //replace the indication marker
                    self.updateTurnIndicator(playerXturn: self.currentGame.playerXturn)
                }
            )
            alertController.addAction(okAction)
            // Present the alert
            present(alertController, animated: true, completion: nil)
    }
    
}
