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
        VStack(spacing: 0) {
            HStack {
                Text(viewModel.theme.name).font(.title).foregroundColor(Color(viewModel.theme.color))
                Spacer()
                Text("Score: \(viewModel.score)").font(.title).foregroundColor(Color(viewModel.theme.color))
            }.padding([.horizontal])
            Divider()
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .padding(5)
                    //.aspectRatio(2 / 3, contentMode: .fit)
                    .onTapGesture {
                        self.viewModel.choose(card: card)
                    }
            }
                //.padding()
                .foregroundColor(Color(viewModel.theme.color))
            Divider()
            HStack {
                Button(action: { self.viewModel.newGame() }) {
                    Text("New Game").padding(.vertical, 5).padding(.horizontal,20).background(Color(.systemBlue)).foregroundColor(Color(.systemBackground)).cornerRadius(10)
                }.padding(5)
                Button(action: { self.viewModel.repeatGame() }) {
                    Text("Shuffle").padding(.vertical, 5).padding(.horizontal,30).background(Color(.systemBlue)).foregroundColor(Color(.systemBackground)).cornerRadius(10)
                }.padding(5)
            }
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
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
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
