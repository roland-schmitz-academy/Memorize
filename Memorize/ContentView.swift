//
//  ContentView.swift
//  Memorize
//
//  Created by Roland Schmitz on 30.05.20.
//  Copyright © 2020 Roland Schmitz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let viewModel: EmojiMemoryGame
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                .onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(Color(.systemOrange))
        .font(.largeTitle)
    }
}

struct CardView : View {
    var card: EmojiMemoryGame.Card

    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground))
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
