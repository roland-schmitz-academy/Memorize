//
//  CodableExtensions.swift
//  Memorize
//
//  Created by Roland Schmitz on 11.08.20.
//  Copyright © 2020 Roland Schmitz. All rights reserved.
//

import Foundation

extension Encodable {
    var jsonData: Data? {
        try? JSONEncoder().encode(self)
    }
    
    var jsonString: String {
        jsonData.asString()
    }
}
