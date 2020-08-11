//
//  Data+asString.swift
//  EmojiArt
//
//  Created by Roland Schmitz on 09.08.20.
//

import Foundation

extension Data {
    func asString(encoding: String.Encoding = .utf8) -> String {
        String(data: self, encoding: String.Encoding.utf8) ?? "null"
    }
}

extension Optional where Wrapped == Data {
    func asString(encoding: String.Encoding = .utf8) -> String {
        self?.asString(encoding: encoding) ?? "null"
    }

}
