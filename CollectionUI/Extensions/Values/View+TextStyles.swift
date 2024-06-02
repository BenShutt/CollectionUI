//
//  View+TextStyles.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

extension View {
    func title() -> some View {
        font(.system(size: 20, weight: .heavy))
    }

    func header() -> some View {
        font(.system(size: 12, weight: .bold))
    }

    func body() -> some View {
        font(.system(size: 12, weight: .regular))
    }
}
