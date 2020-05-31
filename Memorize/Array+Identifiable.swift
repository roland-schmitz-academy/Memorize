//
// Created by Roland Schmitz on 31.05.20.
// Copyright (c) 2020 Roland Schmitz. All rights reserved.
//

import Foundation

extension Array where Element : Identifiable {
    func firstIndex(matching other: Element) -> Int? {
        firstIndex { element in element.id == other.id }
    }
}