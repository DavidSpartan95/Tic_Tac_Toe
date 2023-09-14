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
            print()
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
        
        let numberOfRows = boardSize / Int(sqrt(Double(boardSize)))
        var tempLine = Array(repeating: marker.empty, count: numberOfRows)
    
        //check horizontal
        for i in 0..<numberOfRows{
            for j in 0..<numberOfRows{
                tempLine[j] = board[j+(numberOfRows*i)]
            }
            if (tempLine.allSatisfy { $0 == currentSymbol }) {return true}
        }
        //check vertical
        for i in 0..<numberOfRows{
            for j in 0..<numberOfRows{
                tempLine[j] = board[j*numberOfRows+i]
            }
            if (tempLine.allSatisfy { $0 == currentSymbol }) {return true}
        }
        //check diagenal left to right
        for j in 0..<numberOfRows{
            
            tempLine[j] = board[j*(numberOfRows)+j]
        }
        if (tempLine.allSatisfy { $0 == currentSymbol }) {return true}
        //check diagenal right to left
        for j in 0..<numberOfRows{
            tempLine[j] = board[(numberOfRows-1)*(j+1)]
        }
        print(tempLine)
        if (tempLine.allSatisfy { $0 == currentSymbol }) {return true}
        
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
