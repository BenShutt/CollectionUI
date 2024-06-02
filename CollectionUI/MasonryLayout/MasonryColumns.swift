//
//  MasonryColumns.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import Foundation

// MARK: - MasonryItem

/// A model that has a height so can be positioned in a masonry
protocol MasonryItem: Equatable {

    /// The height of the item
    var height: CGFloat { get }
}

// MARK: - Model + MasonryItem

/// The demo model has a fixed height
extension Model: MasonryItem {}

// MARK: - MasonryFrame

/// A `MasonryItem` and its associated frame in the masonry
struct MasonryFrame<Item: MasonryItem> {

    /// The item to position
    var item: Item

    /// The position and size of the item in the masonry
    var frame: CGRect
}

// MARK: - MasonryColumns

/// Structure wrapping an array of columns and their respective rows of items (2D).
struct MasonryColumns<Item: MasonryItem> {

    /// The columns and their rows
    var columns: [[MasonryFrame<Item>]] = []

    /// The size of the masonry
    var contentSize: CGSize = .zero

    /// Shorthand for getting the `count` of `columns`
    var count: Int { columns.count }

    /// Map to the index and max Y coordinate of each column
    var maxYs: [ColumnMaxY] {
        columns.enumerated().compactMap { offset, element in
            guard let maxY = element.last?.frame.maxY else { return nil }
            return ColumnMaxY(column: offset, maxY: maxY)
        }
    }

    /// Reduce the items (in the columns) into a map from its respective index path to a value
    /// - Parameter mapValue: Mapping of an individual index path and frame to a value
    /// - Returns: Mapping of all index paths and frames
    func reduce<Value>(
        mapValue: (IndexPath, MasonryFrame<Item>) -> Value
    ) -> [IndexPath: Value] {
        columns.enumerated().reduce(into: [:]) { map, indexElement in
            let section = indexElement.offset
            let rows = indexElement.element
            rows.enumerated().forEach { item, frame in
                let indexPath = IndexPath(item: item, section: section)
                map[indexPath] = mapValue(indexPath, frame)
            }
        }
    }

    // MARK: - Subscript

    subscript(column: Int) -> [MasonryFrame<Item>] {
        get { columns[column] }
        set { columns[column] = newValue }
    }

    subscript(indexPath: IndexPath) -> MasonryFrame<Item> {
        columns[indexPath.section][indexPath.item]
    }
}

// MARK: - ColumnMaxY

/// The index and max Y coordinate of a column
struct ColumnMaxY: Comparable {

    /// Index of the column in the 2D array
    var column: Int

    /// The max Y coordinate of the last item in the column
    var maxY: CGFloat

    // MARK: - Comparable

    static func < (lhs: ColumnMaxY, rhs: ColumnMaxY) -> Bool {
        lhs.maxY < rhs.maxY
    }
}
