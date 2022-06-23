//
//  HistoryView.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 20.06.22.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var game: GameManager
    
    var body: some View {
        VStack {
            HStack {
                Text("History")
                    .font(.largeTitle)
                
                Spacer()
            }
            
            if game.history.results.isEmpty {
                Spacer()
                VStack {
                    Image(systemName: "clock.arrow.circlepath")
                        .resizable()
                        .frame(width: 100, height: 90)
                    Text("There is no Dice Rolling History!")
                }
                .opacity(0.7)
                Spacer()
            } else {
                VStack {
                    List {
                        ForEach(game.history.results, id: \.timestamp) { result in
                            HistoryDetailView(result: result)
                        }
                        .onDelete(perform: game.deleteItems)
                    }
                    .listStyle(.plain)
                    
                    Button("Delete all", role: .destructive) {
                        game.removeHistory()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .padding()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(game: GameManager())
    }
}
