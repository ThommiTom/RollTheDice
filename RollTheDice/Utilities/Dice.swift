//
//  Dice.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 15.06.22.
//

import Foundation

class Dice: ObservableObject, Identifiable {
    @Published private(set) var currentValue = 1
    @Published private(set) var rolledValue = 0
    
    let id = UUID()
    
    enum RollSpeed {
        case slow, medium, fast, notRolling
    }
    private var speed = RollSpeed.fast
    
    private var isRolling = false
    
    private var counter = 0
    private let multiplier = 1
    
    private var mediumLimit: Int
    private let slowLimit: Int
    private let stopLimit: Int
    
    private let values = [ 1, 2, 3, 4, 5, 6 ]
    private let moveSet = [
        1: [ 2, 3, 4, 5 ],
        2: [ 1, 3, 4, 6 ],
        3: [ 1, 2, 5, 6 ],
        4: [ 1, 2, 5, 6 ],
        5: [ 1, 3, 4, 6 ],
        6: [ 2, 3, 4, 5 ]
    ]
    
    init() {
        mediumLimit = 20 * multiplier
        slowLimit = 28 * multiplier
        stopLimit = 37 * multiplier
    }
    
    func move() {
        let possibleMoves = moveSet[currentValue]
        currentValue = (possibleMoves?.randomElement())!
    }
    
    func shake() {
        move()
    }
    
    func roll(getResults: @escaping (Int) -> Void) -> Bool {
        isRolling = true
        counter += 1
        
        switch speed {
        case .slow:
            if counter % 3 == 0 {
                move()
            }
            
            if counter == stopLimit {
                speed = .notRolling
            }
        case .medium:
            if counter % 2 == 0 {
                move()
            }
            
            if counter == slowLimit {
                speed = .slow
            }
        case .fast:
            move()
            
            if counter == mediumLimit {
                speed = .medium
            }
        case .notRolling:
            defer {
                isRolling = false
                counter = 0
                speed = .fast
            }
            
            rolledValue = currentValue
            getResults(rolledValue)
        }
        return isRolling
    }
}
