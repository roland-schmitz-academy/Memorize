//
//  Grid.swift
//  Memorize
//
//  Created by Roland Schmitz on 31.05.20.
//  Copyright © 2020 Roland Schmitz. All rights reserved.
//

import SwiftUI

struct Grid<Item : Identifiable, ItemView : View>: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView

    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }

    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }

    func body(for layout: GridLayout) -> some View {
        return ForEach(items) { (item: Item) in
            self.body(for: item, in: layout)
        }
    }

    private func body(for item: Item, in layout: GridLayout) -> some View {
        self.viewForItem(item)
            .frame(width: layout.itemWidth, height: layout.itemHeight)
            .position(layout.location(ofItemAt: items.firstIndex(matching: item)!))
    }

}
