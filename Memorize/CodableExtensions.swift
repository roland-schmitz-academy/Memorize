//
//  CodableExtensions.swift
//  Memorize
//
//  Created by Roland Schmitz on 11.08.20.
//  Copyright © 2020 Roland Schmitz. All rights reserved.
//

import Foundation

extension Encodable {
    func jsonData(with encoder: JSONEncoder = JSONEncoder()) -> Data? {
        try? encoder.encode(self)
    }
    
    func jsonString(with encoder: JSONEncoder = JSONEncoder()) -> String {
        jsonData(with: encoder).asString()
    }

    func prettyJsonString() -> String {
        jsonString(with: PrettyJSONEncoder())
    }
}

open class PrettyJSONEncoder : JSONEncoder {
    public override init() {
        super.init()
        outputFormatting = .prettyPrinted
    }
}
