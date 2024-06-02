//
//  Color+Random.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        Color(red: .random(), green: .random(), blue: .random())
    }
}

// MARK: - Double + Random

private extension Double {
    static func random() -> Double {
        .random(in: 0...1)
    }
}
