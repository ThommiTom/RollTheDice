//
//  ContentView.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 14.06.22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var game = GameManager()
    
    @State private var showHistory = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Roll The Dice!")
                    .font(.largeTitle.bold())
                    .padding()
                
                Spacer()
                
                Button {
                    showHistory = true
                } label: {
                    Image(systemName: "clock.arrow.circlepath")
                        .frame(width: 50, height: 50)
                        .foregroundColor(.primary)
                        .background(.thinMaterial)
                        .clipShape(Circle())
                        .padding(.horizontal)
                }
            }
            
            VStack(spacing: 10) {
                Text("Recent result")
                    .font(.title.weight(.light))

                VStack(spacing: 10) {
                    HStack {
                        ForEach(game.currentResult.rolledEyes) { rolledEye in
                            Text("\(rolledEye.value)")
                        }
                    }
                    Text("Total \(game.currentResult.totalEyes)")
                }
                .animation(.easeIn, value: game.currentResult.timestamp)                
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .padding(.vertical)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding()
            .opacity(game.currentResult.rolledEyes.isEmpty ? 0 : 1)
            .animation(.easeIn, value: game.history.results.first != nil)
            
            Spacer()
            
            VStack {
                ForEach(game.dices) { dice in
                    DiceView(dice: dice)
                }
            }
            .animation(.default, value: game.diceCount)
            
            Spacer()
            
            VStack {
                Text("Dice count")
                
                Stepper("Dice Count", value: $game.diceCount, in: 1...4)
                    .padding(.horizontal)
                    .labelsHidden()
            }
        }
        .onReceive(game.timer) { _ in
            if scenePhase == .active && !showHistory {
                game.rollTheDices()
            }
        }
        .onChange(of: game.diceCount) { _ in
            game.handleDiceCount()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                game.prepareHaptics()
            } else {
                game.deactivateHaptics()
            }
        }
        .sheet(isPresented: $showHistory) {
            HistoryView(game: game)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

