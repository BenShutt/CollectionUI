//
//  CollectionView.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

struct CollectionView: UIViewControllerRepresentable {
    @Environment(Manager.self) private var manager

    func makeUIViewController(context: Context) -> CollectionViewController {
        CollectionViewController()
    }

    func updateUIViewController(
        _ viewController: CollectionViewController,
        context: Context
    ) {
        viewController.manager = manager
    }
}

// MARK: - CollectionViewController

class CollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "MasonryCell"

    private var layout: MasonryLayout {
        let layout = collectionViewLayout as? MasonryLayout
        guard let layout else { fatalError("MasonryLayout") }
        return layout
    }

    var manager: Manager? {
        get {
            layout.manager
        }
        set {
            layout.manager = newValue
            guard isViewLoaded else { return }
            collectionView.reloadData()
        }
    }

    // MARK: - Init

    init() {
        super.init(collectionViewLayout: MasonryLayout())
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: reuseIdentifier
        )
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        layout.columns.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        layout.columns[section].count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let model = layout.columns[indexPath].item

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        )
        cell.contentConfiguration = UIHostingConfiguration {
            Button(action: {
                // Implement...
            }, label: {
                CellView(model: model)
            })
            .buttonStyle(PlainButtonStyle())
        }
        .background(Color.clear)
        .margins(.all, 0)
        return cell
    }

    // MARK: - UICollectionViewDelegate

    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        // Cell button handles the tap
        collectionView.deselectItem(
            at: indexPath,
            animated: false
        )
    }
}

// MARK: - Preview

#Preview {
    CollectionView()
        .environment(Manager())
}
