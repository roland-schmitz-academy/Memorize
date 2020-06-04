//
// Created by Roland Schmitz on 02.06.20.
// Copyright (c) 2020 Roland Schmitz. All rights reserved.
//

import Foundation
import SwiftUI

struct Theme {
    let name: String
    let emojis: [String]
    let numberOfPairs: Int?
    let color: UIColor
    init(_ name: String, emojis: String, numberOfPairs: Int? = nil, color: UIColor) {
        self.name = name
        self.emojis =  emojis.map { String($0) }
        print("emojis = \(emojis)")
        print("self.emojis = \(self.emojis)")
        self.numberOfPairs = numberOfPairs
        self.color = color
    }
}

let themes: [Theme] = [
    Theme("Halloween", emojis: "💀🎃👻☠️", numberOfPairs: 4, color: .systemOrange),
    Theme("Flags", emojis: "🇮🇹🇪🇺🇳🇱🇦🇺🇧🇷🇩🇪🇦🇹", numberOfPairs: 6, color: .systemIndigo),
    Theme("Animals", emojis: "🐨🐶🐷🐸🐹🐻🐼🐰🦊🐭😺🦋🙉🦎", numberOfPairs: 12, color: .systemGreen),
    Theme("Smileys", emojis: "😁😂😃😄😆😇😉😊😌😍😎😐😑😒😕🤔🤗😗🤥😳🙂🙁🙃🙄☺️☹️", color: .systemYellow),
    Theme("People", emojis: "👨‍🍳👨‍🎓👨‍🎤👨‍🎨👨‍🚀🤵👩‍🍳👩‍🏫👩‍💻👨🏻‍💻👩‍🎨👨‍🎨", numberOfPairs: 10, color: .systemPurple),
    Theme("Activity", emojis: "⚽️🎱🏀🏈⚾️🎾🏐🏉🥏", numberOfPairs: 8, color: .systemRed),
]