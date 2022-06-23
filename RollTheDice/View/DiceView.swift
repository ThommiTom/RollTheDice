//
//  DiceView.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 19.06.22.
//

import SwiftUI

struct DiceView: View {
    @ObservedObject var dice: Dice
    
    var body: some View {
        ZStack { 
            switch dice.currentValue {
            case 1:
                OneFace()
            case 2:
                TwoFace()
            case 3:
                ThreeFace()
            case 4:
                FourFace()
            case 5:
                FiveFace()
            case 6:
                SixFace()
            default:
                Color.black
                    .frame(width: 100, height: 100)
            }
        }
        .animation(.linear, value: dice.currentValue)
        .background(.red.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(color: .gray, radius: 1, x: 3, y: 3)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(dice: Dice())
    }
}
