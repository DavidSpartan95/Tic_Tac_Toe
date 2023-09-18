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
    var playerXscore = 0
    var playerOscore = 0
    //Board remembers all the markers that has been placed
    var board: [marker]
    
    init(playerX: String,playerO: String, boardSize: Int,playerXturn: Bool) {
        self.playerX = playerX
        self.playerO = playerO
        self.boardSize = boardSize
        self.playerXturn = playerXturn
        currentSymbol = (playerXturn) ? marker.X : marker.O
        playerXstart = playerXturn
        board = Array(repeating: marker.empty, count: boardSize)
    }
    
    func isPlacementLegal(atIndex: Int) -> Bool {
        currentSymbol = (playerXturn) ? marker.X : marker.O
        return board[atIndex] == .empty
        
    }
    func CPUmove()-> Int{
        while true {
            let randomNum = Int(arc4random_uniform(UInt32(boardSize)))
            if isPlacementLegal(atIndex: randomNum){
                placeMarker(tag: randomNum)
                return randomNum
            }
        }
    }
    
    func placeMarker(tag: Int) {
        guard tag >= 0 && tag < boardSize else { return }
        board[tag] = currentSymbol
        playerXturn.toggle()
    }
    
    func winCondition() -> Bool {
        
        let squaresPerRow = boardSize / Int(sqrt(Double(boardSize)))
        /* tempRow will be filled to check if any of the horizotnal, verticals or diagenal rows
         only cointains one type of marker (marker.X or marker.O) */
        var tempRow = Array(repeating: marker.empty, count: squaresPerRow)
    
        //check horizontal
        for i in 0..<squaresPerRow{
            for j in 0..<squaresPerRow{
                tempRow[j] = board[j+(squaresPerRow*i)]
            }
            if (tempRow.allSatisfy { $0 == currentSymbol }) {return true}
        }
        
        //check vertical
        for i in 0..<squaresPerRow{
            for j in 0..<squaresPerRow{
                tempRow[j] = board[j*squaresPerRow+i]
            }
            if (tempRow.allSatisfy { $0 == currentSymbol }) {return true}
        }
        
        //check diagenal left to right
        for j in 0..<squaresPerRow{
            tempRow[j] = board[j*(squaresPerRow)+j]
        }
        if (tempRow.allSatisfy { $0 == currentSymbol }) {return true}
        
        //check diagenal right to left
        for j in 0..<squaresPerRow{
            tempRow[j] = board[(squaresPerRow-1)*(j+1)]
        }
        if (tempRow.allSatisfy { $0 == currentSymbol }) {return true}
        
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
            (playerXscore, playerOscore) = (currentSymbol == marker.X) ? (playerXscore + 1, playerOscore) : (playerXscore, playerOscore + 1)
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
