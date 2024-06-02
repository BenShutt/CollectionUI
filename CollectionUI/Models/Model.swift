//
//  Model.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

/// Dummy models to layout in a collection view
struct Model: Identifiable, Equatable {
    var id: Int
    var foregroundColor: Color
    var backgroundColor: Color
    var height: CGFloat

    private static func randomHeight() -> CGFloat {
        .random(in: CGFloat.cellHeightMin...CGFloat.cellHeightMax)
    }

    static func random(id: Int) -> Model {
        Model(
            id: id,
            foregroundColor: .random(),
            backgroundColor: .random(),
            height: randomHeight()
        )
    }
}
