//
//  GameData.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 20.06.22.
//

import Foundation

struct RolledEye: Identifiable, Codable {
    var id = UUID()
    var value: Int
}

struct GameResult: Codable {
    var timestamp = Date.now
    var rolledEyes = [RolledEye]()
    var totalEyes: Int {
        get {
            var temp = 0
            for face in rolledEyes {
                temp += face.value
            }
            
            return temp
        }
    }
    
    static let example = GameResult(timestamp: .now, rolledEyes: [RolledEye(value: 1), RolledEye(value: 5), RolledEye(value: 3)])
}

struct History: Codable {
    var results = [GameResult]()
}

