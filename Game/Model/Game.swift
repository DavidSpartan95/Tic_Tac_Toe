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
    // place a marker at random
    func CPUplaceRandom()-> Int{
        while true {
            let randomNum = Int(arc4random_uniform(UInt32(boardSize)))
            if isPlacementLegal(atIndex: randomNum){
                placeMarker(tag: randomNum)
                return randomNum
            }
        }
    }
    
    func CPUplace()-> Int{
        let playerMarker:marker = playerXturn ? marker.O : marker.X
        let CPUmarker: marker = playerXturn ? marker.X : marker.O
        
        //check if CPU can win
        var move = oneMarkerAwayCheck(checkMarker: CPUmarker)

        if move != nil {
            placeMarker(tag: move!)
            return move!
        }
        // check if player is 1 maker away from wining, if so block it!
        move = oneMarkerAwayCheck(checkMarker: playerMarker)
        if move != nil {
            return move!
        }
        var placeRandom: Int?
        while true {
            let randomNum = Int(arc4random_uniform(UInt32(boardSize)))
            if isPlacementLegal(atIndex: randomNum){
                placeRandom = randomNum
                break
            }
        }
        currentSymbol = (playerXturn) ? marker.X : marker.O
        placeMarker(tag: placeRandom!)
        return placeRandom!
    }
    
    func oneMarkerAwayCheck(checkMarker: marker) -> Int? {
        let squaresPerRow = boardSize / Int(sqrt(Double(boardSize)))
        
        func checkRow(_ indices: [Int]) -> Int? {
            var tempRow = [marker]()
            for index in indices {
                tempRow.append(board[index])
            }
            
            var numOfCurrentSymbol = 0
            var emptySpot: Int?
            
            for (index, x) in tempRow.enumerated() {
                if x == .empty {
                    emptySpot = index
                } else if x == checkMarker {
                    numOfCurrentSymbol += 1
                }
            }
            
            if numOfCurrentSymbol == squaresPerRow - 1, let spot = emptySpot {
                let tag = indices[spot]
                print("2 In a ROW! place at \(tag)")
                currentSymbol = playerXturn ? marker.X : marker.O
                placeMarker(tag: tag)
                return tag
            }
            
            return nil
        }
        
        // Check horizontal and vertical rows
        var wereOnBoard = [Int]()
        for i in 0..<squaresPerRow {
            var horizontalIndices = [Int]()
            var verticalIndices = [Int]()
            
            for j in 0..<squaresPerRow {
                horizontalIndices.append(j + (squaresPerRow * i))
                verticalIndices.append(j * squaresPerRow + i)
            }
            
            if let tag = checkRow(horizontalIndices) {
                return tag
            }
            
            if let tag = checkRow(verticalIndices) {
                return tag
            }
        }
        
        // Check diagonal left to right
        var diagonalIndicesLR = [Int]()
        for i in 0..<squaresPerRow {
            diagonalIndicesLR.append(i * (squaresPerRow + 1))
        }
        
        if let tag = checkRow(diagonalIndicesLR) {
            return tag
        }
        
        // Check diagonal right to left
        var diagonalIndicesRL = [Int]()
        for i in 0..<squaresPerRow {
            diagonalIndicesRL.append((squaresPerRow - 1) * (i + 1))
        }
        
        if let tag = checkRow(diagonalIndicesRL) {
            return tag
        }
        
        return nil
    }
    
    func placeMarker(tag: Int) {
        guard tag >= 0 && tag < boardSize else {return}
        board[tag] = currentSymbol
        playerXturn.toggle()
    }
    
    func winCondition() -> Bool {
        let squaresPerRow = boardSize / Int(sqrt(Double(boardSize)))
        /*`tempRow` is a temporary container used to analyze rows (horizontal, vertical, or diagonal)
           to determine if they contain only a single type of marker (marker.X or marker.O).*/
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
        board = Array(repeating: marker.empty, count: boardSize)
    }
    
}
