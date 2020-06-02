//
// Created by Roland Schmitz on 30.05.20.
// Copyright (c) 2020 Roland Schmitz. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent : Equatable> {
    var cards: [Card]

    mutating func choose(card: Card) {
        print("card chosen -> \(card)")
        let faceupCardIndices = cards
            .filter { card in
                card.isFaceUp
            }
            .compactMap { card in
                cards.firstIndex(matching: card)
            }
        if faceupCardIndices.count > 1 {
            for index in 0..<cards.count {
                cards[index].isFaceUp = false
            }
        }
        if !card.isMatched, let cardIndex = cards.firstIndex(matching: card), !cards[cardIndex].isFaceUp {
            cards[cardIndex].isFaceUp = true
            if faceupCardIndices.count == 1 {
                let otherCardIndex = faceupCardIndices[0]
                if cards[faceupCardIndices[0]].content == cards[cardIndex].content {
                    cards[cardIndex].isMatched = true
                    cards[faceupCardIndices[0]].isMatched = true
                }
            }
        }
    }

    mutating func shuffleCards() {
        cards.shuffle()
        print("shuffled cards = \(cards)")
    }

    mutating func resetCards() {
        for index in 0..<cards.count {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }

    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairs {
            let cardPairContent = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: cardPairContent))
            cards.append(Card(id: pairIndex * 2 + 1, content: cardPairContent))
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

