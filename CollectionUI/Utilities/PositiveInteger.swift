//
//  PositiveInteger.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import Foundation

/// Property wrapper that ensures the integer value is greater than 0.
/// On failure, a fatal error is raised as this would be a programmer's error.
@propertyWrapper
struct PositiveInteger {
    var value: Int

    init(wrappedValue value: Int) {
        guard value > 0 else { fatalError("PositiveInteger") }
        self.value = value
    }

    var wrappedValue: Int {
        get {
            value
        }
        set {
            guard newValue > 0 else { fatalError("PositiveInteger") }
            value = newValue
        }
    }
}
