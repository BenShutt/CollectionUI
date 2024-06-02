//
//  View+Extensions.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

extension View {
    func scaledSingleLine(scaleFactor: CGFloat = 0.25) -> some View {
        lineLimit(1)
            .truncationMode(.tail)
            .minimumScaleFactor(scaleFactor)
    }
}
