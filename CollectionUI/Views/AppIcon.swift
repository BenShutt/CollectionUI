//
//  AppIcon.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

/// A SwiftUI view used to generate the app icon PNG file.
///
/// # Usage
/// ```swift
/// try AppIcon.writePNG(to: URL(filePath: "/path/to/AppIcon.png"))
/// ```
@MainActor struct AppIcon: View {
    var body: some View {
        MasonryView(size: 600)
            .frame(width: .appIconWidth, height: .appIconHeight)
            .background(Color.appLightGray)
    }

    static func writePNG(to url: URL) throws {
        let renderer = ImageRenderer(content: AppIcon())
        renderer.scale = 1 // Fixed 1x scaling
        renderer.proposedSize = .init(
            width: .appIconWidth,
            height: .appIconHeight
        )
        let pngData = renderer.uiImage?.pngData()
        guard let pngData else { throw AppIconError.pngData }
        try pngData.write(to: url, options: .atomic)
    }
}

// MARK: - MasonryView

private struct MasonryView: View {
    var size: CGFloat

    private var columnWidth: CGFloat {
        size * 0.275
    }

    private var smallHeight: CGFloat {
        size * 0.3
    }

    private var largeHeight: CGFloat {
        size * 0.6
    }

    var body: some View {
        ZStack {
            ColorView(
                width: columnWidth,
                height: largeHeight,
                alignment: .topLeading
            )

            ColorView(
                width: columnWidth,
                height: smallHeight,
                alignment: .bottomLeading
            )

            ColorView(
                width: columnWidth,
                height: smallHeight,
                alignment: .top
            )

            ColorView(
                width: columnWidth,
                height: largeHeight,
                alignment: .bottom
            )

            ColorView(
                width: columnWidth,
                height: largeHeight,
                alignment: .topTrailing
            )

            ColorView(
                width: columnWidth,
                height: smallHeight,
                alignment: .bottomTrailing
            )
        }
        .frame(width: size, height: size)
    }
}

// MARK: - ColorView

private struct ColorView: View {
    var width: CGFloat
    var height: CGFloat
    var alignment: Alignment

    private var cornerRadius: CGFloat {
        width * 0.2
    }

    var body: some View {
        Color.appDarkGray
            .frame(width: width, height: height)
            .clipShape(.rect(cornerRadius: cornerRadius))
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: alignment
            )
    }
}

// MARK: - AppIconError

enum AppIconError: Error {
    case pngData
}

// MARK: - CGFloat + AppIcon

private extension CGFloat {
    static let appIconWidth: CGFloat = 1024
    static let appIconHeight: CGFloat = 1024
}

// MARK: - Preview

#Preview {
    MasonryView(size: 250)
}
