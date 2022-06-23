//
//  HistoryDetailView.swift
//  RollTheDice
//
//  Created by Thomas Schatton on 21.06.22.
//

import SwiftUI

struct HistoryDetailView: View {
    @State private var result: GameResult
    
    init(result: GameResult) {
        _result = State(initialValue: result)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Rolled Total \(result.totalEyes)")
                .font(.headline)
            
            HStack(spacing: 10) {
                Text("Rolled Faces:")
                    .font(.headline)
                
                ForEach(result.rolledEyes) { face in
                    Text("\(face.value)")
                }
            }
            Text("\(result.timestamp.formatted(date: .abbreviated, time: .complete))")
                .font(.callout)
                .fontWeight(.light)
        }
    }
}

struct HistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDetailView(result: GameResult.example)
    }
}
