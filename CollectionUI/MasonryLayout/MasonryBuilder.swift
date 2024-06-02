//
//  MasonryBuilder.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

/// Given a width and configuration, build items into columns by their heights.
/// New items are added to the shortest column each time.
struct MasonryBuilder {

    /// The width of the collection view
    let parentWidth: CGFloat

    /// The configuration properties of the layout
    let configuration: MasonryConfiguration

    // MARK: - Shorthand

    /// Shorthand to get the `padding` of `configuration`
    private var padding: EdgeInsets { configuration.padding }

    /// Shorthand to get the `hSpacing` of `configuration`
    private var hSpacing: CGFloat { configuration.hSpacing }

    /// Shorthand to get the `vSpacing` of `configuration`
    private var vSpacing: CGFloat { configuration.vSpacing }

    /// Shorthand to get the `nColumns` of `configuration`
    private var nColumns: Int { configuration.nColumns }

    // MARK: - Computed

    /// The width of an individual cell
    private var cellWidth: CGFloat {
        let hPadding = padding.horizontal
        let hSpacers = hSpacing * CGFloat(nColumns - 1)
        return max(0, parentWidth - hPadding - hSpacers) / CGFloat(nColumns)
    }

    /// The origin X coordinate of a column with index `column`
    /// - Parameter column: Index of the column (zero based)
    /// - Returns: The origin X of the column
    private func leadingX(column: Int) -> CGFloat {
        padding.leading + (cellWidth + hSpacing) * CGFloat(column)
    }

    // MARK: - Make

    /// Map an item to its respective frame
    /// - Parameters:
    ///   - originX: Origin X coordinate
    ///   - originY: Origin Y coordinate
    ///   - item: The item to position
    /// - Returns: The item and its associated frame
    private func makeFrame<Item: MasonryItem>(
        originX: CGFloat,
        originY: CGFloat,
        item: Item
    ) -> MasonryFrame<Item> {
        MasonryFrame(
            item: item,
            frame: CGRect(
                x: originX,
                y: originY,
                width: cellWidth,
                height: item.height
            )
        )
    }

    // MARK: - Build

    /// Build the masonry by grouping the given `items` into columns
    /// - Parameter items: The items to group
    /// - Returns: The columns of grouped items
    func build<Item: MasonryItem>(items: [Item]) -> MasonryColumns<Item> {
        // Initialize the array of columns to append to
        var columns = MasonryColumns<Item>()

        // Iterate and add to the shortest column each time
        items.forEach { item in
            if columns.count < nColumns {
                // Add to first row of columns
                columns.columns.append([makeFrame(
                    originX: leadingX(column: columns.count),
                    originY: padding.top,
                    item: item
                )])
            } else if let shortestColumn = columns.maxYs.min() {
                // Append to column
                columns[shortestColumn.column].append(makeFrame(
                    originX: leadingX(column: shortestColumn.column),
                    originY: shortestColumn.maxY + vSpacing,
                    item: item
                ))
            }
        }

        // Set the content size
        let maxY = columns.maxYs.max()?.maxY
        let height = if let maxY { maxY + padding.bottom } else { CGFloat(0) }
        columns.contentSize = CGSize(width: parentWidth, height: height)
        return columns
    }
}
