//
//  Game.swift
//  Game
//
//  Created by David Ulvan on 2023-09-13.
//

import Foundation
import UIKit

class Game:GameRules{
    
    var boardSize: Int
    var playerXturn: Bool
    var playerX: String
    var playerO: String
    var currentSymbol: marker
    let playerXstart: Bool
    var resultMSG: String = ""
    var CPUon: Bool = false
    //Board that remembers all the markers that has been placed
    var board = Array(repeating: marker.empty, count: 9)
    
    init(playerX: String,playerO: String, boardSize: Int,playerXturn: Bool) {
        self.playerX = playerX
        self.playerO = playerO
        self.boardSize = boardSize
        self.playerXturn = playerXturn
        currentSymbol = (playerXturn) ? marker.X : marker.O
        playerXstart = playerXturn
    }
    
    func isPlacementLegal(atIndex: Int) -> Bool {
        currentSymbol = (playerXturn) ? marker.X : marker.O
        return board[atIndex] == .empty
        
    }
    
    func placeMarker(tag: Int) {
        guard tag >= 0 && tag < boardSize else { return }
        board[tag] = currentSymbol
        playerXturn.toggle()
    }
    
    func winCondition() -> Bool {
        //check horizontal
        if board[0] == currentSymbol && board[1] == currentSymbol && board[2] == currentSymbol {return true}
        if board[3] == currentSymbol && board[4] == currentSymbol && board[5] == currentSymbol {return true}
        if board[6] == currentSymbol && board[7] == currentSymbol && board[8] == currentSymbol {return true}
        //check horizontal
        if board[0] == currentSymbol && board[3] == currentSymbol && board[6] == currentSymbol {return true}
        if board[1] == currentSymbol && board[4] == currentSymbol && board[7] == currentSymbol {return true}
        if board[2] == currentSymbol && board[5] == currentSymbol && board[8] == currentSymbol {return true}
        //check diagenal
        if board[0] == currentSymbol && board[4] == currentSymbol && board[8] == currentSymbol {return true}
        if board[2] == currentSymbol && board[4] == currentSymbol && board[6] == currentSymbol {return true}
        
        return false
    }

    func isBoardFull() -> Bool {
        for x in board {
            if x == .empty {return false}
        }
        return true
    }
    
    func gameOver() -> Bool {
        if winCondition() {
            resultMSG = (currentSymbol == marker.X) ? "\(playerX) WON" : "\(playerO) WON"
            reset()
            return true
        } else if isBoardFull() {
            resultMSG = "DRAW"
            reset()
            return true
        } else {
            return false
        }
        
    }
    func reset() {
        playerXturn = playerXstart
        board = Array(repeating: marker.empty, count: 9)
    }
    
}
