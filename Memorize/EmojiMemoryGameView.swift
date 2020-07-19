//
//  ContentView.swift
//  Memorize
//
//  Created by Roland Schmitz on 30.05.20.
//  Copyright © 2020 Roland Schmitz. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject private(set) var viewModel: EmojiMemoryGame
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(viewModel.theme.name).font(.title).foregroundColor(viewModel.theme.color)
                Spacer()
                Text("Score: \(viewModel.score)").font(.title).foregroundColor(viewModel.theme.color)
            }.padding([.horizontal])
            Divider()
            Grid(viewModel.cards) { card in
                CardView(card: card, gradient: self.viewModel.theme.gradient)
                    .padding(5)
                    //.aspectRatio(2 / 3, contentMode: .fit)
                    .onTapGesture {
                        self.viewModel.choose(card: card)
                    }
            }
                //.padding()
                .foregroundColor(viewModel.theme.color)
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
    let card: EmojiMemoryGame.Card
    let gradient: Gradient

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    @ViewBuilder
    func front(of card: EmojiMemoryGame.Card) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius).fill(Color(.secondarySystemBackground))
        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
        Pie(startAngle: .degrees(-90), endAngle: .degrees(20))
            .fill(LinearGradient(gradient: gradient, startPoint: .init(x: 0, y: 0), endPoint: .init(x: 1, y: 1)))
            .padding(5)
            .opacity(0.4)
        Text(card.content)
    }

    @ViewBuilder
    func back(of card: EmojiMemoryGame.Card) -> some View {
        if !card.isMatched {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(LinearGradient(gradient: gradient, startPoint: .init(x: 0, y: 0), endPoint: .init(x: 1, y: 1)))
        }
    }

    private func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                front(of: self.card)
            } else {
                back(of: self.card)
            }
        }.font(.system(size: fontSize(for: size)))
    }

    // MARK: - Card drawing constants

    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}

