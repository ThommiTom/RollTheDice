//
//  Example.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 17.06.22.
//

import SwiftUI

struct AnimationExample: View {
    @State private var redDegrees = 0.0
    @State private var redOffset = 0.0
    @State private var blueDegrees = -90.0
    @State private var blueOffset = 50.0
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 50, height: 50)
                        .rotation3DEffect(.degrees(redDegrees), axis: (x: 0, y: -1, z: 0), anchor: .trailing, perspective: 1)
                        .offset(x: redOffset, y: 0)
                    
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 50, height: 50)
                        .rotation3DEffect(.degrees(blueDegrees), axis: (x: 0, y: -1, z: 0), anchor: .leading, perspective: 1)
                        .offset(x: blueOffset, y: 0)
                }
                
                Button("Rotate Horizontally right") {
                    withAnimation(.linear(duration: 1).repeatForever()) {
                        redDegrees = 90
                        redOffset = -50
                        blueDegrees = 0
                        blueOffset = 0
                    }
                }
            }
            
//            Divider()
//                .padding()
//            
//            VStack {
//                ZStack {
//                    Rectangle()
//                        .fill(.red)
//                        .frame(width: 50, height: 50)
//                        .rotation3DEffect(.degrees(redDegrees), axis: (x: 0, y: -1, z: 0), anchor: .leading, perspective: 1)
//                        .offset(x: redOffset, y: 0)
//                    
//                    Rectangle()
//                        .fill(.blue)
//                        .frame(width: 50, height: 50)
//                        .rotation3DEffect(.degrees(blueDegrees), axis: (x: 0, y: -1, z: 0), anchor: .trailing, perspective: 1)
//                        .offset(x: blueOffset, y: 0)
//                }
//                
//                Button("Rotate Horizontally left") {
//                    withAnimation(.linear(duration: 1).repeatForever()) {
//                        redDegrees = -90
//                        redOffset = 50
//                        blueDegrees = 0
//                        blueOffset = 0
//                    }
//                }
//            }
//            
//            ZStack {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 50, height: 50)
//                    .rotation3DEffect(.degrees(redDegrees), axis: (x: 1, y: 0, z: 0), anchor: .bottom, perspective: 1)
//                    .offset(x: 0, y: redOffset)
//                
//                Rectangle()
//                    .fill(.blue)
//                    .frame(width: 50, height: 50)
//                    .rotation3DEffect(.degrees(blueDegrees), axis: (x: 1, y: 0, z: 0), anchor: .top, perspective: 1)
//                    .offset(x: 0, y: blueOffset)
//            }
//            
//            Button("Rotate Vertically") {
//                withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
//                    redDegrees = 90
//                    redOffset = -50
//                    blueDegrees = 0
//                    blueOffset = 0
//                }
//            }
//            
//            Divider()
//                .padding()
//            
//            ZStack {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 50, height: 50)
//                    .rotation3DEffect(.degrees(redDegrees), axis: (x: 0, y: 0, z: 1), perspective: 0.1)
//            }
//            
//            Button("Rotate Vertically") {
//                withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
//                    redDegrees = 90
//                    redOffset = -50
//                    blueDegrees = 0
//                    blueOffset = 0
//                }
//            }
        }
    }
}

struct AnimationExample_Previews: PreviewProvider {
    static var previews: some View {
        AnimationExample()
    }
}
