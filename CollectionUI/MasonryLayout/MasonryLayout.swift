//
//  MasonryLayout.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import UIKit

/// A `UICollectionViewLayout` for building a masonry of columns that stack items by their height
class MasonryLayout: UICollectionViewLayout {

    /// Map an index path to its corresponding layout attributes
    typealias AttributesMap = [IndexPath: UICollectionViewLayoutAttributes]

    /// The content to layout in the collection view
    var manager = Manager(shouldRefresh: false) {
        didSet {
            redrawLayout()
            invalidateLayout()
        }
    }

    /// The items sorted into columns with their associated frames
    private(set) var columns = MasonryColumns<Model>()

    /// Cache of the layout attributes
    private var attributes: AttributesMap = [:]

    // MARK: - UICollectionViewLayout

    override func prepare() {
        super.prepare()
        redrawLayout()
    }

    override var collectionViewContentSize: CGSize {
        columns.contentSize
    }

    override func shouldInvalidateLayout(
        forBoundsChange newBounds: CGRect
    ) -> Bool {
        guard let collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }

    override func layoutAttributesForItem(
        at indexPath: IndexPath
    ) -> UICollectionViewLayoutAttributes? {
        attributes[indexPath]
    }

    override func layoutAttributesForElements(
        in rect: CGRect
    ) -> [UICollectionViewLayoutAttributes]? {
        attributes.values.filter { attributes in
            rect.intersects(attributes.frame)
        }
    }

    // MARK: - Attributes

    /// Make a new layout attributes instance
    /// - Parameters:
    ///   - indexPath: Index path of the cell
    ///   - frame: Frame of the cell
    /// - Returns: A new layout attributes instance
    private func makeAttributes(
        indexPath: IndexPath,
        frame: CGRect
    ) -> UICollectionViewLayoutAttributes {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = frame
        return attributes
    }

    // MARK: - Layout

    /// Reset and re-build the layout properties
    private func redrawLayout() {
        guard let collectionView else {
            columns = MasonryColumns()
            attributes = [:]
            return
        }

        let builder = MasonryBuilder(
            parentWidth: collectionView.bounds.size.width,
            configuration: manager.configuration
        )
        columns = builder.build(items: manager.models)
        attributes = columns.reduce { indexPath, frame in
            makeAttributes(indexPath: indexPath, frame: frame.frame)
        }
    }
}
