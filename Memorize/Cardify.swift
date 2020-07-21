//
//  Cardify.swift
//  Memorize
//
//  Created by Roland Schmitz on 19.07.20.
//  Copyright © 2020 Roland Schmitz. All rights reserved.
//

import Foundation
import SwiftUI

struct Cardify : AnimatableModifier {
    var rotation: Double
    let backGradient: LinearGradient
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool, backGradient: LinearGradient) {
        rotation = isFaceUp ? 0 : 180
        self.backGradient = backGradient
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color(.secondarySystemBackground))
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backGradient)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            Angle.degrees(rotation),
            axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
        )

    }
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool, backGradient: LinearGradient) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, backGradient: backGradient))
    }
}
