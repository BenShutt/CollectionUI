//
//  ButtonView.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

struct ButtonView: View {
    var title: LocalizedStringKey
    var foregroundColor: Color
    var backgroundColor: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .title()
                .foregroundStyle(foregroundColor)
                .frame(maxWidth: .infinity)
                .padding(.large)
                .background(backgroundColor)
                .clipShape(Capsule())
        }
    }
}
