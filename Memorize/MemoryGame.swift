//
// Created by Roland Schmitz on 30.05.20.
// Copyright (c) 2020 Roland Schmitz. All rights reserved.
//

import Foundation

class MemoryGame<CardContent> {
    var cards: [Card]

    func choose(card: Card) {
        print("card chosen -> \(card)")
    }

    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairs {
            let cardPairContent = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: cardPairContent))
            cards.append(Card(id: pairIndex * 2 + 1, isFaceUp: true, content: cardPairContent))
        }
    }

    struct Card : Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}

