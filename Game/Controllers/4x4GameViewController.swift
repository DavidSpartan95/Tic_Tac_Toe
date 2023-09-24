//
//  4x4GameViewController.swift
//  Game
//
//  Created by David Ulvan on 2023-09-19.
//

import UIKit

class _x4GameViewController: UIViewController {

    @IBOutlet var boardImages: [UIImageView]!
    
    @IBOutlet weak var lblScoreX: UILabel!
    @IBOutlet weak var lblScoreO: UILabel!
    
    var hardMode: Bool = false
    
    let currentGame = Game(playerX: "PlayerX", playerO: "PlayerO",boardSize:16, playerXturn: true)
    
    override func viewDidLoad() {
        
        currentGame.CPUon = true
        super.viewDidLoad()

        
    }
    @IBAction func tapOnBoard(_ sender: UITapGestureRecognizer) {
        //get tag to find out wich view has been tapped
        guard let tag = getTag(sender) else {return}
        //check if the view is empty/dont contain any X or O maker
        if !currentGame.isPlacementLegal(atIndex: tag){return}
        //change the image of the view
        boardImages[tag].image = (currentGame.currentSymbol == marker.X) ? UIImage(systemName: "xmark") : UIImage(systemName: "circle")
        //register were the marker was played to the game class
        currentGame.placeMarker(tag: tag)
        //show result in an Alert if win condition has been meet
        if currentGame.gameOver(){
            showResult()
            return
        }
        //If CPU (player vs CPU) has been selected the CPU will place next marker
        if currentGame.CPUon{
            //CPUmove will place a marker and return an Int to indicate were it placed the marker
            let CPU_PLACEMENT = hardMode ? currentGame.CPUplace() : currentGame.CPUplaceRandom()
            boardImages[CPU_PLACEMENT].image = (currentGame.currentSymbol == marker.X) ? UIImage(systemName: "xmark") : UIImage(systemName: "circle")
            
            if currentGame.gameOver(){
                showResult()
            }
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
                    for x in self.boardImages {x.image = nil}
                    //Update the Score
                   self.lblScoreX.text = ": \(self.currentGame.playerXscore)"
                   self.lblScoreO.text = ": \(self.currentGame.playerOscore)"
                }
            )
            alertController.addAction(okAction)
            // Present the alert
            present(alertController, animated: true, completion: nil)
    }
    

}
