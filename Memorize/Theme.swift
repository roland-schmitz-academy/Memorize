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
    let gradient: Gradient
    var color: Color {
        gradient.stops.first!.color
    }

    init(_ name: String, emojis: String, numberOfPairs: Int? = nil, color: Color) {
        self.name = name
        self.emojis =  emojis.map { String($0) }
        print("emojis = \(emojis)")
        print("self.emojis = \(self.emojis)")
        self.numberOfPairs = numberOfPairs
        self.gradient = Gradient(colors: [color, color])
    }
    init(_ name: String, emojis: String, numberOfPairs: Int? = nil, gradient: Gradient) {
        self.name = name
        self.emojis =  emojis.map { String($0) }
        print("emojis = \(emojis)")
        print("self.emojis = \(self.emojis)")
        self.numberOfPairs = numberOfPairs
        self.gradient = gradient
    }
}

let themes: [Theme] = [
    Theme("Halloween", emojis: "💀🎃👻☠️", numberOfPairs: 4, gradient: Gradient(colors: [Color(.systemOrange), Color(.systemRed),Color(.systemOrange)])),
    Theme("Flags", emojis: "🇮🇹🇪🇺🇳🇱🇦🇺🇧🇷🇩🇪🇦🇹", numberOfPairs: 6, gradient: Gradient(colors: [Color(.systemRed), Color(.systemGreen),Color(.systemBlue),Color(.systemYellow),Color(.systemOrange)])),
    Theme("Animals", emojis: "🐨🐶🐷🐸🐹🐻🐼🐰🦊🐭😺🦋🙉🦎", numberOfPairs: 12, color: Color(.systemGreen)),
    Theme("Smileys", emojis: "😁😂😃😄😆😇😉😊😌😍😎😐😑😒😕🤔🤗😗🤥😳🙂🙁🙃🙄☺️☹️", color: Color(.systemYellow)),
    Theme("People", emojis: "👨‍🍳👨‍🎓👨‍🎤👨‍🎨👨‍🚀🤵👩‍🍳👩‍🏫👩‍💻👨🏻‍💻👩‍🎨👨‍🎨", numberOfPairs: 10, color: Color(.systemPurple)),
    Theme("Activity", emojis: "⚽️🎱🏀🏈⚾️🎾🏐🏉🥏", numberOfPairs: 8, color: Color(.systemRed)),
]
