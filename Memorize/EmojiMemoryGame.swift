//
// Created by Roland Schmitz on 30.05.20.
// Copyright (c) 2020 Roland Schmitz. All rights reserved.
//

import Foundation

class EmojiMemoryGame : ObservableObject {
    typealias Card = MemoryGame<String>.Card
    @Published private var model: MemoryGame<String> = createMemoryGame()

    private class func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["😺", "🐭", "🙉", "🦋", "🎃", "💀", "👻", "🤖", "♥️", "♣️", "♦️", "♠️"].shuffled()
        return MemoryGame(numberOfPairs: Int.random(in: 2...5)) { pairIndex in emojis[pairIndex] }
    }

    // MARK: - Access to the model

    func shuffle() {
        model.resetCards()
        model.shuffleCards()
    }

    var cards: [Card] {
        model.cards
    }

    // MARK: - Intents

    func choose(card: Card) {
        model.choose(card: card)
    }
}