//
//  Cardify.swift
//  Memorize
//
//  Created by Roland Schmitz on 19.07.20.
//  Copyright © 2020 Roland Schmitz. All rights reserved.
//

import Foundation
import SwiftUI

struct Cardify : ViewModifier {
    let isFaceUp: Bool
    let backGradient: LinearGradient
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color(.secondarySystemBackground))
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backGradient)
            }
        }
    }
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool, backGradient: LinearGradient) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, backGradient: backGradient))
    }
}
