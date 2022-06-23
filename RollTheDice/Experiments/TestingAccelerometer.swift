//
//  TestingAccelerometer.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 14.06.22.
//

import CoreMotion
import SwiftUI

struct AccelerationData: Identifiable {
    let id = UUID()
    let timestamp: Date
    let rawData: CMAcceleration
    
    static let examle = AccelerationData(timestamp: .now, rawData: CMAcceleration(x: Double.random(in: -2.0...2.0), y: Double.random(in: -2.0...2.0), z: Double.random(in: -2.0...2.0)))
}

struct TestingAccelerometer: View {
    let motion = CMMotionManager()
    
    @State private var loggedData = [AccelerationData]()
    @State private var rawData: CMAcceleration?
    @State private var userData: CMAcceleration?
    @State private var gravity: CMAcceleration?
    @State private var isRunning = false
    
    private let timer = Timer.publish(every: (1.0/60.0), on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack {
                
                Image("XYZ-Axes")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .scaledToFit()
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack {
                        Text("Raw Force")
                            .font(.callout.bold())
                            .padding(.bottom, 5)
                        Text("X\t\(rawData?.x ?? 0.0)")
                        Text("Y\t\(rawData?.y ?? 0.0)")
                        Text("Z\t\(rawData?.z ?? 0.0)")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                    VStack {
                        Text("User Force")
                            .font(.callout.bold())
                            .padding(.bottom, 5)
                        Text("X\t\(userData?.x ?? 0.0)")
                        Text("Y\t\(userData?.y ?? 0.0)")
                        Text("Z\t\(userData?.z ?? 0.0)")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                    VStack {
                        Text("Gravitational Force")
                            .font(.callout.bold())
                            .padding(.bottom, 5)
                        Text("X\t\(gravity?.x ?? 0.0)")
                        Text("Y\t\(gravity?.y ?? 0.0)")
                        Text("Z\t\(gravity?.z ?? 0.0)")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                .padding(.horizontal)
    
                
                Spacer()
                
                NavigationLink {
                    ResultView(data: loggedData)
                } label: {
                    Text("shows logs")
                        .padding(10)
                        .background(.green)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .disabled(loggedData.isEmpty || isRunning ? true : false)
                .opacity(loggedData.isEmpty || isRunning ? 0.5 : 1.0)
                
                Spacer()
                HStack(alignment: .center, spacing: 50) {
                    Button("Reset", role: .destructive) {
                        loggedData.removeAll()
                        rawData?.x = 0.0
                        rawData?.y = 0.0
                        rawData?.z = 0.0
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isRunning ? true : false)
                    
                    Button(isRunning ? "Stop Accelerometer" : "Start Accelerometer") {
                        if isRunning {
                            stopDeviceMotion()
                            stopAccelerometers()
                        } else {
                            startDeviceMotion()
                            startAccelerometers()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                
            }
            .navigationTitle("Accelerometer")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onReceive(timer) { _ in
            if isRunning {
                if let data = self.motion.accelerometerData {
                    let sampleData = data.acceleration
                    rawData = sampleData
                    let sample = AccelerationData(timestamp: Date.now, rawData: sampleData)
                    loggedData.append(sample)
                }
                
                if let data = motion.deviceMotion?.userAcceleration {
                    userData = data
                }
                
                if let gravity = motion.deviceMotion?.gravity {
                    self.gravity = gravity
                }
            }
        }
    }
    
    func startDeviceMotion() {
        if motion.isDeviceMotionAvailable {
            defer {
                isRunning = true
            }
            motion.deviceMotionUpdateInterval = 1.0 / 60.0
            motion.startDeviceMotionUpdates()
        }
    }
    
    func stopDeviceMotion() {
        motion.stopDeviceMotionUpdates()
        isRunning = false
    }
    
    func startAccelerometers() {
        // make sure the accelerometer hardware is available.
        if self.motion.isAccelerometerAvailable {
            defer {
                isRunning = true
            }
            self.motion.accelerometerUpdateInterval = 1.0 / 60.0
            self.motion.startAccelerometerUpdates()
        }
    }
    
    func stopAccelerometers() {
        motion.stopAccelerometerUpdates()
        isRunning = false
    }
}

struct TestingAccelerometer_Previews: PreviewProvider {
    static var previews: some View {
        TestingAccelerometer()
    }
}
