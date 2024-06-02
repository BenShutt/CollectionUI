//
//  MasonryConfiguration.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

/// Layout properties of the masonry
struct MasonryConfiguration {

    /// Edge padding of the masonry
    var padding = EdgeInsets(.medium)

    /// Horizontal spacing between columns
    var hSpacing: CGFloat = .medium

    /// Vertical spacing between rows (in columns)
    var vSpacing: CGFloat = .medium

    /// The number of columns in the masonry
    @PositiveInteger var nColumns = .nColumns
}
