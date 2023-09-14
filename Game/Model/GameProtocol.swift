//
//  GameProtocol.swift
//  Game
//
//  Created by David Ulvan on 2023-09-13.
//

import Foundation

protocol GameRules {

    var playerXturn: Bool {get set}
    var playerX: String {get set}
    var playerO: String {get set}
    var boardSize: Int {get set}
    var board: [marker] {get set}
    
    func isPlacementLegal(atIndex: Int) -> Bool
    
    func placeMarker(tag: Int)
    
    func winCondition()-> Bool
    
    func isBoardFull() -> Bool
    
    func reset()
    
}
