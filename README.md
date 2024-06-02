# CollectionUI

An example SwiftUI app that uses a `UICollectionViewController` to render a masonry layout.

![Video](Docs/MasonryTrimmed.mp4)

## Motivation

While the masonry layout works well 🙌, the main reason for developing this project was to demonstrate interfacing with `UICollectionViewController` in a SwiftUI app. This is a useful (hybrid) option for when SwiftUI's stacks/grids/tables do not provide enough configuration.

It is worth mentioning, a pure SwiftUI solution should be attempted first. There are also other ways to develop the layout of a `UICollectionView`, this project's subclassing of `UICollectionViewLayout` may be a little on the old side.

## Notable Entities

The project is reasonably well documented, but here is a summary of the notable entities.

### MasonryColumns

Stores a 2D array of columns and their vertically stacked items. When a new item is going to be added, the last element of each column is compared to see which has the least `maxY`. The shortest column then has the new item appended.

###  MasonryBuilder

Takes an array of models and computes their frames in the collection view.

### MasonryLayout

A `UICollectionViewLayout` subclass that overrides the necessary methods serving the layout attributes.

### CollectionView

A `UIViewControllerRepresentable` that wraps a `UICollectionViewController` with a custom `MasonryLayout`.

### MasonryConfiguration

Properties that configure how the masonry layout will look in the `UICollectionView`.

### Manager

An example of an `@Observable` that loads models (via an dummy asynchronous load) for layout in the masonry.

### Model

A simply dummy model that is rendered in the cells. They each have a fixed and random height to achieve the masonry design.