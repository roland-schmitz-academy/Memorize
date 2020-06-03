//
// Created by Roland Schmitz on 31.05.20.
// Copyright (c) 2020 Roland Schmitz. All rights reserved.
//

import Foundation
import CoreGraphics

struct GridLayout {
    var itemCount: Int
    var size: CGSize
    var columnRowRatio: Double

    init(itemCount: Int, in size: CGSize, itemAspectRatio: Double = 1/1) {
        self.itemCount = itemCount
        self.size = size
        self.columnRowRatio = Double(size.width / size.height) / itemAspectRatio
    }

    var estimatedRowCount: Int { Int(sqrt(Double(itemCount - 1) / columnRowRatio )) + 1 }
    var columnCount: Int { (itemCount - 1) / estimatedRowCount + 1 }
    var rowCount: Int { (itemCount - 1) / columnCount + 1 }
    var itemWidth: CGFloat { size.width / CGFloat(columnCount) }
    var itemHeight: CGFloat { size.height / CGFloat(rowCount) }

    func location(ofItemAt itemIndex: Int) -> CGPoint {
        let rowIndex = itemIndex / columnCount
        let columnIndex = itemIndex % columnCount
        return CGPoint(
            x: (CGFloat(columnIndex) + 0.5) * itemWidth,
            y: (CGFloat(rowIndex) + 0.5) * itemHeight
        )
    }
}
