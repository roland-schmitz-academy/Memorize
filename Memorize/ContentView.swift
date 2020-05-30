//
//  ContentView.swift
//  Memorize
//
//  Created by Roland Schmitz on 30.05.20.
//  Copyright © 2020 Roland Schmitz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            ForEach(0..<4) { (index: Int) in
                CardView(isFaceUp: index.isMultiple(of: 2))
            }
        }
        .padding()
        .foregroundColor(Color(.systemOrange))
        .font(.largeTitle)
    }
}

struct CardView : View {
    var isFaceUp: Bool

    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground))
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                Text("😺")
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
