//
// Created by Roland Schmitz on 30.05.20.
// Copyright (c) 2020 Roland Schmitz. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent : Equatable> {
    private(set) var cards: [Card]
    private(set) var score: Int = 0

    mutating func choose(card: Card) {
        print("card chosen -> \(card)")
        let faceupCardIndices = cards.indices
            .filter {
                cards[$0].isFaceUp
            }
        if faceupCardIndices.count > 1 {
            for index in cards.indices {
                if cards[index].isFaceUp {
                    cards[index].wasAlreadySeen = true
                    cards[index].isFaceUp = false
                }
            }
        }
        if !card.isMatched, let cardIndex = cards.firstIndex(matching: card), !cards[cardIndex].isFaceUp {
            cards[cardIndex].isFaceUp = true
            if faceupCardIndices.count == 1 {
                if cards[faceupCardIndices[0]].content == cards[cardIndex].content {
                    cards[cardIndex].isMatched = true
                    cards[faceupCardIndices[0]].isMatched = true
                    score += Int( 2 + (cards[cardIndex].bonusRemaining + cards[faceupCardIndices[0]].bonusRemaining) * 10.0 )
                } else {
                    if cards[cardIndex].wasAlreadySeen {
                        score -= 10
                    }
                    if cards[faceupCardIndices[0]].wasAlreadySeen {
                        score -= 10
                    }
                }

            }
        }
    }

    mutating func shuffleCards() {
        cards.shuffle()
    }

    mutating func resetGame() {
        score = 0
        for index in cards.indices {
            let card = cards[index]
            cards[index] = Card(id: card.id, content: card.content)
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
        let id: Int
        let content: CardContent
        
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var wasAlreadySeen: Bool = false
        
        let bonusTimeLimit: TimeInterval = 6
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime - lastFaceUpDate.timeIntervalSinceNow
            } else {
                return pastFaceUpTime
            }
        }
            
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            bonusTimeLimit > 0 ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime && lastFaceUpDate == .none {
                lastFaceUpDate = Date()
            }
        }

        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = .none
        }
    }
}

