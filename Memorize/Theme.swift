//
// Created by Roland Schmitz on 02.06.20.
// Copyright (c) 2020 Roland Schmitz. All rights reserved.
//

import Foundation
import SwiftUI

struct Theme {
    let name: String
    let emojis: [String]
    let numberOfPairs: Int/*?*/
    var colors: [UIColor]

    init(_ name: String, emojis: String, numberOfPairs: Int/*? = nil*/, colors: UIColor...) {
        self.name = name
        self.emojis =  emojis.map { String($0) }
        print("emojis = \(emojis)")
        print("self.emojis = \(self.emojis)")
        self.numberOfPairs = numberOfPairs
        assert(colors.count > 0, "at least one color needed for Theme \(name)")
        self.colors = colors
    }
}

extension Theme : Encodable {
    enum CodingKeys : CodingKey {
        case name, emojis, numberOfPairs
    }    
}

//extension UIColor : Encodable {
//    enum CodingKeys : CodingKey {
//        case cgColor
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        encoder.container(keyedBy: CodingKeys.self)
//    }
//}
//


let themes: [Theme] = [
    Theme("Halloween", emojis: "💀🎃👻☠️", numberOfPairs: 4, colors: .systemOrange, .systemRed, .systemOrange),
    Theme("Flags", emojis: "🇮🇹🇪🇺🇳🇱🇦🇺🇧🇷🇩🇪🇦🇹", numberOfPairs: 6, colors: .systemRed, .systemGreen, .systemBlue, .systemYellow, .systemOrange),
    Theme("Animals", emojis: "🐨🐶🐷🐸🐹🐻🐼🐰🦊🐭😺🦋🙉🦎", numberOfPairs: 12, colors: .systemGreen),
    Theme("Smileys", emojis: "😁😂😃😄😆😇😉😊😌😍😎😐😑😒😕🤔🤗😗🤥😳🙂🙁🙃🙄☺️☹️", numberOfPairs: 7, colors: .systemYellow),
    Theme("People", emojis: "👨‍🍳👨‍🎓👨‍🎤👨‍🎨👨‍🚀🤵👩‍🍳👩‍🏫👩‍💻👨🏻‍💻👩‍🎨👨‍🎨", numberOfPairs: 10, colors: .systemPurple),
    Theme("Activity", emojis: "⚽️🎱🏀🏈⚾️🎾🏐🏉🥏", numberOfPairs: 8, colors: .systemRed),
]
