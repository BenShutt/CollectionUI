//
//  HeaderView.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

struct HeaderView: View {
    @Environment(Manager.self) private var manager

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: .medium) {
                ForEach(1...Int.nTags, id: \.self) { index in
                    Button(action: {
                        manager.configuration.nColumns = index
                    }, label: {
                        TagView(index: index)
                    })
                }
            }
            .padding(.medium)
        }
        .background(Color.appLightGray)
        .compositingGroup()
        .shadow(radius: .small)
    }
}

// MARK: - TagView

@MainActor private struct TagView: View {
    @Environment(Manager.self) private var manager

    var index: Int

    private var isSelected: Bool {
        index == manager.configuration.nColumns
    }

    private var backgroundColor: Color {
        isSelected ? .appYellow : .appDarkGray
    }

    private var foregroundColor: Color {
        isSelected ? .appBlack : .appLightGray
    }

    var body: some View {
        Text("\(index) columns")
            .header()
            .foregroundStyle(foregroundColor)
            .padding(.medium)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

// MARK: - Preview

#Preview {
    HeaderView()
}
