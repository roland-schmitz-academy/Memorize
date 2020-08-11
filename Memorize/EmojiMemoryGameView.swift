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
                Text(viewModel.theme.name).font(.title).foregroundColor(color())
                Spacer()
                Text("Score: \(viewModel.score)").font(.title).foregroundColor(color())
            }.padding([.horizontal])
            Divider()
            Grid(viewModel.cards) { card in
                CardView(card: card, gradient: gradient())
                    .padding(5)
                    //.aspectRatio(2 / 3, contentMode: .fit)
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 0.5)) {
                            self.viewModel.choose(card: card)
                        }
                    }
            }
                //.padding()
            .foregroundColor(color())
            Divider()
            HStack {
                Button(action: {
                    withAnimation(Animation.easeInOut) {
                        self.viewModel.newGame()
                    }
                }) {
                    Text("New Game").padding(.vertical, 5).padding(.horizontal,20).background(Color(.systemBlue)).foregroundColor(Color(.systemBackground)).cornerRadius(10)
                }.padding(5)
                Button(action: {
                    withAnimation(Animation.easeInOut) {
                        self.viewModel.repeatGame()
                    }
                }) {
                    Text("Shuffle").padding(.vertical, 5).padding(.horizontal,30).background(Color(.systemBlue)).foregroundColor(Color(.systemBackground)).cornerRadius(10)
                }.padding(5)
            }
        }
    }
    
    
    func color() -> Color {
        if viewModel.theme.colors.count < 1 {
            return Color(.orange)
        } else {
            return Color(viewModel.theme.colors[0])
        }
    }

    func gradient() -> Gradient {
        if viewModel.theme.colors.count < 2 {
            return Gradient(colors: [color(), color()])
        } else {
            return Gradient(colors: viewModel.theme.colors.map { Color($0) })
        }
    }
    
}

struct CardView : View {
    let card: EmojiMemoryGame.Card
    let gradient: Gradient
    
    var frontGradient: LinearGradient {
        LinearGradient(
            gradient: gradient,
            startPoint: .init(x: 0, y: 1),
            endPoint: .init(x: 1, y: 0))
    }

    var backGradient: LinearGradient {
        LinearGradient(
            gradient: gradient,
            startPoint: .init(x: 0, y: 0),
            endPoint: .init(x: 1, y: 1))
    }

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: .degrees(-90), endAngle: .degrees(-animatedBonusRemaining * 360 - 90))
                            .fill(frontGradient)
                            .onAppear {
                                startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: .degrees(-90), endAngle: .degrees(-card.bonusRemaining * 360 - 90))
                            .fill(frontGradient)
                    }
                }
                .padding(5)
                .opacity(0.4)
                .transition(.identity)
                Text(card.content)
                    .font(.system(size: fontSize(for: size)))
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp, backGradient: backGradient)
            .transition(.scale)
        }
    }

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

