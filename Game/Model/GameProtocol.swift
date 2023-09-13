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
    
    func winCondition()-> Bool
    
    func placementIsLegal(atIndex: Int) -> Bool
    
    func boardIsFull() -> Bool
    
    func placeMarker(tag: Int)
    
    func reset()
    
}
