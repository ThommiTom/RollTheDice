//
//  Accelerometer.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 17.06.22.
//

import Foundation
import CoreMotion

enum DeviceState {
    case resting
    case sidewayShaking
    case forwardJerk
}

class Motion {
    let motion = CMMotionManager()
    var deviceState = DeviceState.resting
    
    init() {
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = 1.0 / 60.0
            motion.startDeviceMotionUpdates()
        }
    }
    
    func getDeviceState() {
        guard let sample = motion.deviceMotion?.userAcceleration else { return }
        
        if sample.y > 2.0 {
            deviceState = .forwardJerk
        } else if  -0.15 < sample.x || sample.x > 0.15 {
            deviceState = .resting
        } else {
            deviceState = .sidewayShaking
        }
    }
}
