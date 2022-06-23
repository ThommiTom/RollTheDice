//
//  ResultVie.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 14.06.22.
//

import SwiftUI

struct ResultView: View {
    @State private var loggedData: [AccelerationData]
    
    @State private var minX: Double = 0.0
    @State private var minY: Double = 0.0
    @State private var minZ: Double = 0.0
    
    @State private var aveX: Double = 0.0
    @State private var aveY: Double = 0.0
    @State private var aveZ: Double = 0.0
    
    @State private var maxX: Double = 0.0
    @State private var maxY: Double = 0.0
    @State private var maxZ: Double = 0.0
    
    
    let dF = DateFormatter()
    
    init(data: [AccelerationData]) {
        _loggedData = State(initialValue: data)
        dF.dateFormat = "s.SSS"
        
        let minResult = getMin()
        _minX  = State(initialValue: minResult.xMin)
        _minY  = State(initialValue: minResult.yMin)
        _minZ  = State(initialValue: minResult.zMin)
        
        let averageResult = getAverage()
        _aveX = State(initialValue: averageResult.xAve)
        _aveY = State(initialValue: averageResult.yAve)
        _aveZ = State(initialValue: averageResult.zAve)
        
        let maxResult = getMax()
        _maxX  = State(initialValue: maxResult.xMax)
        _maxY  = State(initialValue: maxResult.yMax)
        _maxZ  = State(initialValue: maxResult.zMax)
        
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Measurement duration:")
                    .fontWeight(.bold)
                Text("\(calcDuration()) s")
                    .fontWeight(.light)
            }
            .padding(.top, 20)
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("X-Force")
                        .fontWeight(.bold)
                    Divider()
                    HStack {
                        Text("X min:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(minX.formatted(.number.precision(.fractionLength(2))))")
                            .fontWeight(.light)
                    }
                    HStack {
                        Text("X Ave:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(aveX.formatted(.number.precision(.fractionLength(2))))")
                            .fontWeight(.light)
                    }
                    HStack {
                        Text("X max:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(maxX.formatted(.number.precision(.fractionLength(2))))")
                            .fontWeight(.light)
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Y-Force")
                        .fontWeight(.bold)
                    Divider()
                    HStack {
                        Text("Y min:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(minY.formatted(.number.precision(.fractionLength(2))))")
                            .fontWeight(.light)
                    }
                    HStack {
                        Text("Y Ave:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(aveY.formatted(.number.precision(.fractionLength(2))))")
                            .fontWeight(.light)
                    }
                    HStack {
                        Text("Y max:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(maxY.formatted(.number.precision(.fractionLength(2))))")
                            .fontWeight(.light)
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Z-Force")
                        .fontWeight(.bold)
                    Divider()
                    HStack {
                        Text("Z min:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(minZ.formatted(.number.precision(.fractionLength(2))))")
                            .fontWeight(.light)
                    }
                    HStack {
                        Text("Z Ave:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(aveZ.formatted(.number.precision(.fractionLength(2))))")
                            .fontWeight(.light)
                    }
                    HStack {
                        Text("Z max:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(maxZ.formatted(.number.precision(.fractionLength(2))))")
                            .fontWeight(.light)
                    }
                }
            }
            .padding()
            
            Divider()
            
            HStack {
                Text("time")
                Spacer()
                Text("x-force")
                Spacer()
                Text("y-force")
                Spacer()
                Text("z-force")
            }
            .padding([.leading, .trailing], 15)
            .font(.headline)
            
            ScrollView {
                ForEach(loggedData) { dataSet in
                    HStack(alignment: .center, spacing: 5) {
                        Text(getTimestamp(for: dataSet.timestamp))
                        Spacer()
                        Text("\(dataSet.rawData.x.formatted(.number.precision(.fractionLength(3))))")
                        Spacer()
                        Text("\(dataSet.rawData.y.formatted(.number.precision(.fractionLength(3))))")
                        Spacer()
                        Text("\(dataSet.rawData.z.formatted(.number.precision(.fractionLength(3))))")
                    }
                    .padding([.leading, .trailing], 15)
                }
            }
        }
    }
    
    func calcDuration() -> TimeInterval {
        loggedData.last!.timestamp.timeIntervalSinceReferenceDate - loggedData.first!.timestamp.timeIntervalSinceReferenceDate
    }
    
    func getMin() -> (xMin: Double, yMin: Double, zMin: Double) {
        var result = (xMin: 0.0, yMin: 0.0, zMin: 0.0)
        
        let xForces = loggedData.map { $0.rawData.x }
        let yForces = loggedData.map { $0.rawData.y }
        let zForces = loggedData.map { $0.rawData.z }
        
        result.xMin = xForces.min() ?? 0.0
        result.yMin = yForces.min() ?? 0.0
        result.zMin = zForces.min() ?? 0.0
        
        return result
    }

    func getMax() -> (xMax: Double, yMax: Double, zMax: Double) {
        var result = (xMax: 0.0, yMax: 0.0, zMax: 0.0)
        
        let xForces = loggedData.map { $0.rawData.x }
        let yForces = loggedData.map { $0.rawData.y }
        let zForces = loggedData.map { $0.rawData.z }
        
        result.xMax = xForces.max() ?? 0.0
        result.yMax = yForces.max() ?? 0.0
        result.zMax = zForces.max() ?? 0.0
        
        return result
    }
    
    func getAverage() -> (xAve: Double, yAve: Double, zAve: Double) {
        var result = (xAve: 0.0, yAve: 0.0, zAve: 0.0)
        
        let xForces = loggedData.map { $0.rawData.x }
        let yForces = loggedData.map { $0.rawData.y }
        let zForces = loggedData.map { $0.rawData.z }
        
        for i in 0..<loggedData.count {
            result.xAve += xForces[i]
            result.yAve += yForces[i]
            result.zAve += zForces[i]
        }
        
        result.xAve /= Double(xForces.count)
        result.yAve /= Double(yForces.count)
        result.zAve /= Double(zForces.count)
        
        return result
    }
    
    func getTimestamp(for stamp: Date) -> String {
        let delta = stamp.timeIntervalSince1970 - loggedData.first!.timestamp.timeIntervalSince1970
        
        return dF.string(from: Date(timeIntervalSince1970: delta))
    }
}

struct ResultVie_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(data: [AccelerationData](repeating: AccelerationData.examle, count: 10))
    }
}
