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
            .filter { card in card.isFaceUp && !card.isMatched }
            .compactMap { card in cards.firstIndex(matching: card) }
        if faceupCardIndices.count == 2 {
            if cards[faceupCardIndices[0]].content == cards[faceupCardIndices[1]].content {
                cards[faceupCardIndices[0]].isMatched = true
                cards[faceupCardIndices[1]].isMatched = true
            } else {
                cards[faceupCardIndices[0]].isFaceUp = false
                cards[faceupCardIndices[1]].isFaceUp = false
            }
        }
        if let index = cards.firstIndex(matching: card) {
            cards[index].isFaceUp.toggle()
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

