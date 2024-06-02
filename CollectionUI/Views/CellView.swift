//
//  CellView.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

struct CellView: View {
    var model: Model

    /// Shape used for both the border and for clipping
    private var roundedRect: some InsettableShape {
        .rect(cornerRadius: .extraLarge)
    }

    private var backgroundColor: Color {
        model.backgroundColor.opacity(.cellBackgroundOpacity)
    }

    private var foregroundColor: Color {
        model.foregroundColor.opacity(.cellBorderOpacity)
    }

    var body: some View {
        backgroundColor
            .frame(maxWidth: .infinity)
            .frame(height: model.height)
            .overlay {
                HeightView(height: model.height)
            }
            .overlay {
                roundedRect
                    .strokeBorder(foregroundColor, lineWidth: .medium)
            }
            .background(Color.appWhite)
            .clipShape(roundedRect)
            .compositingGroup()
            .shadow(radius: .small)
    }
}

// MARK: - HeightView

private struct HeightView: View {
    var height: CGFloat

    var body: some View {
        VStack(spacing: .small) {
            Text("cell_title")
                .body()
                .scaledSingleLine()
                .foregroundStyle(Color.appDarkGray)
            Text(height, format: .number)
                .title()
                .scaledSingleLine()
                .foregroundStyle(Color.appBlack)
        }
        .padding(.extraLarge)
    }
}

// MARK: - Preview

#Preview {
    CellView(model: .random(id: 1))
}
