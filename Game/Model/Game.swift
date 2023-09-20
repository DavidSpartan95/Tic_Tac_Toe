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
    // place a marker not at random
    func CPUplace()-> Int{
        
        var move = winingMove()
        print("MOVE is:\(move)")
        if move != nil {
            print("WINING MOVE")
            return move!
        }
        move = blockPlayer()
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
    
    func blockPlayer()-> Int? {
        let squaresPerRow = boardSize / Int(sqrt(Double(boardSize)))
        /*
           `tempRow` is a temporary container used to analyze rows (horizontal, vertical, or diagonal)
           to determine if they contain only a single type of marker (marker.X or marker.O).
        */
        var tempRow = Array(repeating: marker.empty, count: squaresPerRow)
        var wereOnBoard: [Int] = []
    
        //check horizontal
        for i in 0..<squaresPerRow{
            for j in 0..<squaresPerRow{
                tempRow[j] = board[j+(squaresPerRow*i)]
                wereOnBoard.append(j+(squaresPerRow*i))
            }
            //var numOfempty = 0
            var numOfCurretSymbol = 0
            var emptySpot: Int?
            for (index, x) in tempRow.enumerated() {
                if x == .empty {
                    //numOfempty += 1
                    emptySpot = index
                }else if x == currentSymbol {
                    numOfCurretSymbol += 1
                }
            }
            if (numOfCurretSymbol == squaresPerRow-1 && emptySpot != nil) {
                print("2 In a ROW! place at \(wereOnBoard[emptySpot!])")
                currentSymbol = (playerXturn) ? marker.X : marker.O
                placeMarker(tag: wereOnBoard[emptySpot!])
                return wereOnBoard[emptySpot!]
            }
            wereOnBoard = []
        }
        
        //check vertical
        for i in 0..<squaresPerRow{
            for j in 0..<squaresPerRow{
                tempRow[j] = board[j*squaresPerRow+i]
                wereOnBoard.append(j*squaresPerRow+i)
            }
            var numOfCurretSymbol = 0
            var emptySpot: Int?
            for (index, x) in tempRow.enumerated() {
                if x == .empty {
                    //numOfempty += 1
                    emptySpot = index
                }else if x == currentSymbol {
                    numOfCurretSymbol += 1
                }
            }
            if (numOfCurretSymbol == squaresPerRow-1 && emptySpot != nil) {
                print("2 In a ROW! place at \(wereOnBoard[emptySpot!])")
                currentSymbol = (playerXturn) ? marker.X : marker.O
                placeMarker(tag: wereOnBoard[emptySpot!])
                return wereOnBoard[emptySpot!]
            }
            wereOnBoard = []
        }
        //check diagenal left to right
        for i in 0..<squaresPerRow{
            tempRow[i] = board[i*(squaresPerRow)+i]
            wereOnBoard.append(i*(squaresPerRow)+i)
        }
        var numOfCurretSymbol = 0
        var emptySpot: Int?
        for (index, x) in tempRow.enumerated() {
            if x == .empty {
                //numOfempty += 1
                emptySpot = index
            }else if x == currentSymbol {
                numOfCurretSymbol += 1
            }
        }
        if (numOfCurretSymbol == squaresPerRow-1 && emptySpot != nil) {
            print("2 In a ROW! place at \(wereOnBoard[emptySpot!])")
            currentSymbol = (playerXturn) ? marker.X : marker.O
            placeMarker(tag: wereOnBoard[emptySpot!])
            return wereOnBoard[emptySpot!]
        }
        wereOnBoard = []
        
        //check diagenal right to left
        for i in 0..<squaresPerRow{
            tempRow[i] = board[(squaresPerRow-1)*(i+1)]
            wereOnBoard.append((squaresPerRow-1)*(i+1))
        }
        numOfCurretSymbol = 0
        emptySpot = nil
        for (index, x) in tempRow.enumerated() {
            if x == .empty {
                //numOfempty += 1
                emptySpot = index
            }else if x == currentSymbol {
                numOfCurretSymbol += 1
            }
        }
        if (numOfCurretSymbol == squaresPerRow-1 && emptySpot != nil) {
            print("2 In a ROW! place at \(wereOnBoard[emptySpot!])")
            currentSymbol = (playerXturn) ? marker.X : marker.O
            placeMarker(tag: wereOnBoard[emptySpot!])
            return wereOnBoard[emptySpot!]
        }
        return nil
    }
    
    func winingMove()-> Int? {
        var CPUmarker = marker.empty
       if playerXturn {
           print("DDDD")
             CPUmarker = marker.X
        }else{
            print("SSSS")
             CPUmarker = marker.O
        }
       
        let squaresPerRow = boardSize / Int(sqrt(Double(boardSize)))
        /*
           `tempRow` is a temporary container used to analyze rows (horizontal, vertical, or diagonal)
           to determine if they contain only a single type of marker (marker.X or marker.O).
        */
        var tempRow = Array(repeating: marker.empty, count: squaresPerRow)
        var wereOnBoard: [Int] = []
    
        //check horizontal
        for i in 0..<squaresPerRow{
            for j in 0..<squaresPerRow{
                tempRow[j] = board[j+(squaresPerRow*i)]
                wereOnBoard.append(j+(squaresPerRow*i))
            }
            //var numOfempty = 0
            var numOfCurretSymbol = 0
            var emptySpot: Int?
            for (index, x) in tempRow.enumerated() {
                if x == .empty {
                    //numOfempty += 1
                    emptySpot = index
                }else if x == CPUmarker {
                    numOfCurretSymbol += 1
                }
            }
            if (numOfCurretSymbol == squaresPerRow-1 && emptySpot != nil) {
                print("2 In a ROW! place at \(wereOnBoard[emptySpot!])")
                currentSymbol = (playerXturn) ? marker.X : marker.O
                placeMarker(tag: wereOnBoard[emptySpot!])
                return wereOnBoard[emptySpot!]
            }
            wereOnBoard = []
        }
        
        //check vertical
        for i in 0..<squaresPerRow{
            for j in 0..<squaresPerRow{
                tempRow[j] = board[j*squaresPerRow+i]
                wereOnBoard.append(j*squaresPerRow+i)
            }
            var numOfCurretSymbol = 0
            var emptySpot: Int?
            for (index, x) in tempRow.enumerated() {
                if x == .empty {
                    //numOfempty += 1
                    emptySpot = index
                }else if x == CPUmarker {
                    numOfCurretSymbol += 1
                }
            }
            if (numOfCurretSymbol == squaresPerRow-1 && emptySpot != nil) {
                print("2 In a ROW! place at \(wereOnBoard[emptySpot!])")
                currentSymbol = (playerXturn) ? marker.X : marker.O
                placeMarker(tag: wereOnBoard[emptySpot!])
                return wereOnBoard[emptySpot!]
            }
            wereOnBoard = []
        }
        //check diagenal left to right
        for i in 0..<squaresPerRow{
            tempRow[i] = board[i*(squaresPerRow)+i]
            wereOnBoard.append(i*(squaresPerRow)+i)
        }
        var numOfCurretSymbol = 0
        var emptySpot: Int?
        for (index, x) in tempRow.enumerated() {
            if x == .empty {
                //numOfempty += 1
                emptySpot = index
            }else if x == CPUmarker {
                numOfCurretSymbol += 1
            }
        }
        if (numOfCurretSymbol == squaresPerRow-1 && emptySpot != nil) {
            print("2 In a ROW! place at \(wereOnBoard[emptySpot!])")
            currentSymbol = (playerXturn) ? marker.X : marker.O
            placeMarker(tag: wereOnBoard[emptySpot!])
            return wereOnBoard[emptySpot!]
        }
        wereOnBoard = []
        
        //check diagenal right to left
        for i in 0..<squaresPerRow{
            tempRow[i] = board[(squaresPerRow-1)*(i+1)]
            wereOnBoard.append((squaresPerRow-1)*(i+1))
        }
        numOfCurretSymbol = 0
        emptySpot = nil
        for (index, x) in tempRow.enumerated() {
            if x == .empty {
                //numOfempty += 1
                emptySpot = index
            }else if x == CPUmarker {
                numOfCurretSymbol += 1
            }
        }
        if (numOfCurretSymbol == squaresPerRow-1 && emptySpot != nil) {
            print("2 In a ROW! place at \(wereOnBoard[emptySpot!])")
            currentSymbol = (playerXturn) ? marker.X : marker.O
            placeMarker(tag: wereOnBoard[emptySpot!])
            return wereOnBoard[emptySpot!]
        }
        return nil
    }
    
    
    func placeMarker(tag: Int) {
        guard tag >= 0 && tag < boardSize else {return}
        print(tag)
        board[tag] = currentSymbol
        playerXturn.toggle()
    }
    
    func winCondition() -> Bool {
        
        let squaresPerRow = boardSize / Int(sqrt(Double(boardSize)))
        /*
           `tempRow` is a temporary container used to analyze rows (horizontal, vertical, or diagonal)
           to determine if they contain only a single type of marker (marker.X or marker.O).
        */
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
