//
//  StickyBottom.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

private struct StickyButton<Bottom: View>: ViewModifier {
    @ViewBuilder var bottom: () -> Bottom

    func body(content: Content) -> some View {
        content.safeAreaInset(
            edge: .bottom,
            spacing: 0
        ) {
            bottom()
                .background {
                    Color.appWhite
                        .ignoresSafeArea()
                }
                .compositingGroup()
                .shadow(radius: .small)
        }
    }
}

// MARK: - View + StickyButton

extension View {
    func stickyBottom(
        @ViewBuilder bottom: @escaping () -> some View
    ) -> some View {
        modifier(StickyButton(bottom: bottom))
    }
}
