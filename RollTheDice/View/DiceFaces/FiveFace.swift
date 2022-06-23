//
//  FiveFace.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 19.06.22.
//

import SwiftUI

struct FiveFace: View {
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 20, height: 20)
                    .opacity(1)
                Circle()
                    .frame(width: 20, height: 20)
                    .opacity(0)
                Circle()
                    .frame(width: 20, height: 20)
                    .opacity(1)
            }
            HStack {
                Circle()
                    .frame(width: 20, height: 20)
                    .opacity(0)
                Circle()
                    .frame(width: 20, height: 20)
                    .opacity(1)
                Circle()
                    .frame(width: 20, height: 20)
                    .opacity(0)
            }
            HStack {
                Circle()
                    .frame(width: 20, height: 20)
                    .opacity(1)
                Circle()
                    .frame(width: 20, height: 20)
                    .opacity(0)
                Circle()
                    .frame(width: 20, height: 20)
                    .opacity(1)
            }
        }
        .frame(width: 100, height: 100)
    }
}

struct FiveFace_Previews: PreviewProvider {
    static var previews: some View {
        FiveFace()
    }
}
