//
//  ContentView.swift
//  Memorize
//
//  Created by Roland Schmitz on 30.05.20.
//  Copyright © 2020 Roland Schmitz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
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
                .font(self.viewModel.cards.count < 10 ? .largeTitle : .headline)

            Button(action: { self.viewModel.shuffleCards() }) {
                Text("Shuffle").padding().background(Color(.systemBlue)).foregroundColor(Color(.systemBackground)).cornerRadius(10)
            }.padding()

        }
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
        }.aspectRatio(2/3, contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
