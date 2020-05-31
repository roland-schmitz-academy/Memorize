//
//  ContentView.swift
//  Memorize
//
//  Created by Roland Schmitz on 30.05.20.
//  Copyright © 2020 Roland Schmitz. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .padding(5)
                    //.aspectRatio(2 / 3, contentMode: .fit)
                    .onTapGesture {
                        self.viewModel.choose(card: card)
                    }
            }
                .padding()
                .foregroundColor(Color(.systemOrange))

            Button(action: { self.viewModel.shuffleCards() }) {
                Text("Shuffle").padding().background(Color(.systemBlue)).foregroundColor(Color(.systemBackground)).cornerRadius(10)
            }.padding()

        }
    }
}

struct CardView : View {
    var card: EmojiMemoryGame.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    private func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color(.secondarySystemBackground))
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(self.card.content)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }.font(.system(size: fontSize(for: size)))
    }

    // MARK: - Card drawing constants

    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
