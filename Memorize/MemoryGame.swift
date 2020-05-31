//
// Created by Roland Schmitz on 30.05.20.
// Copyright (c) 2020 Roland Schmitz. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]

    mutating func choose(card: Card) {
        print("card chosen -> \(card)")
        if let index = cards.firstIndex(matching: card) {
            cards[index].isFaceUp.toggle()
        }
    }

    mutating func shuffleCards() {
        cards.shuffle()
        print("shuffled cards = \(cards)")
    }

    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairs {
            let cardPairContent = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: cardPairContent))
            cards.append(Card(id: pairIndex * 2 + 1, isFaceUp: true, content: cardPairContent))
        }
        shuffleCards()
    }

    struct Card : Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}

