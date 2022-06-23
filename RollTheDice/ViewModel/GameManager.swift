//
//  DiceGame.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 20.06.22.
//

import Foundation

class GameManager: ObservableObject {
    @Published var history = History()
    @Published var currentResult = GameResult()
    @Published var diceCount: Int = 1
    @Published var dices = [Dice()]
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    let motion = Motion()
    let feedback = Feedback()
    
    private var dicesRolling = false
    private var rolledFaces = [RolledEye]()
    
    fileprivate let saveLocation = FileManager.DocumentDirectory.appendingPathComponent("history.json")
    
    init() {
        load()
    }
    
    private func load() {
        if let data: History = FileManager().load(location: saveLocation) {
            history = data
        }
    }
    
    private func save() {
        FileManager().save(element: history, location: saveLocation)
    }
    
    func handleDiceCount() {
        dices.removeAll()
        for _ in 1...diceCount {
            dices.append(Dice())
        }
    }
    
    func rollTheDices() {
        if !dicesRolling {
            motion.getDeviceState()
            switch motion.deviceState {
            case .resting:
                return
            case .sidewayShaking:
                feedback.shaking()
                for dice in dices {
                    dice.shake()
                }
            case .forwardJerk:
                dicesRolling = true
                feedback.rolling()
            }
        } else {
            feedback.rolling()
            for i in 0..<dices.count {
                if i == dices.count - 1 {
                    dicesRolling = dices[i].roll(getResults: { result in
                        self.rolledFaces.append(RolledEye(value: result))
                    })
                } else {
                    _ = dices[i].roll(getResults: { result in
                        self.rolledFaces.append(RolledEye(value: result))
                    })
                }
            }
            
            if !dicesRolling {
                currentResult.timestamp = .now
                currentResult.rolledEyes = rolledFaces
                history.results.insert(currentResult, at: 0)
                save()
                rolledFaces.removeAll()
            }
        }
    }
    
    func prepareHaptics() {
        feedback.prepareHaptics()
    }
    
    func deactivateHaptics() {
        feedback.deactivateHaptics()
    }
    
    func deleteItems(offset: IndexSet) {
        history.results.remove(atOffsets: offset)
        save()
    }
    
    func removeHistory() {
        history.results.removeAll()
        save()
    }
}
