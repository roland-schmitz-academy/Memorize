//
// Created by Roland Schmitz on 30.05.20.
// Copyright (c) 2020 Roland Schmitz. All rights reserved.
//

import Foundation

class EmojiMemoryGame : ObservableObject {
    typealias Card = MemoryGame<String>.Card
    @Published var theme: Theme
    @Published private var model: MemoryGame<String>

    init() {
        let theme = themes.randomElement()!
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }

    private class func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let pairCount = theme.numberOfPairs ?? Int.random(in: 2...emojis.count)
        return MemoryGame(numberOfPairs: pairCount) { pairIndex in emojis[pairIndex] }
    }

    // MARK: - Access to the model
    var cards: [Card] {
        model.cards
    }

    var score: Int {
        return model.score
    }

    // MARK: - Intents

    func newGame() {
        let theme = themes.randomElement()!
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }

    func repeatGame() {
        model.resetGame()
        model.shuffleCards()
    }

    func choose(card: Card) {
        model.choose(card: card)
    }
}