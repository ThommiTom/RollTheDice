//
//  Haptics.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 19.06.22.
//

import Foundation
import CoreHaptics

class Feedback {
    private var engine: CHHapticEngine?
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func deactivateHaptics() {
        engine?.stop()
    }
    
    func shaking() {
        // check if device has haptic engine
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        // insstance holds multiple events
        var events = [CHHapticEvent]()
        
        // creating haptic events
        for i in stride(from: 0.6, through: 0.7, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i - 0.4)
            
            events.append(event)
        }
        
        // create player
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern in shakingFeedback(): \(error.localizedDescription)")
        }
    }
    
    func rolling() {
        // check if device has haptic engine
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        // insstance holds multiple events
        var events = [CHHapticEvent]()
        
        // creating haptic events
        for i in stride(from: 0.8, through: 1.0, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i - 0.8)
            
            events.append(event)
        }
        
        // create player
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern in rollingFeedback(): \(error.localizedDescription)")
        }
    }
}
