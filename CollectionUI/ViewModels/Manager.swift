//
//  Manager.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

/// Loads a collection of models asynchronously.
/// The class represents the manager that loads the app data.
@MainActor @Observable class Manager {

    /// Configuration properties of the masonry layout
    var configuration = MasonryConfiguration()

    /// Models to position and render in the masonry
    var models: [Model] = []

    /// Whether the models are loading.
    /// - Note: Loading states is overkill for this project. But added to demonstrate
    /// what a manager of this sorts typically looks like.
    var isLoading = false

    // MARK: - Init

    /// Initialize the manager and refresh the models
    init() {
        refresh()
    }

    // MARK: - Refresh

    /// Dispatch a new task to refresh the models
    func refresh() {
        Task { await refreshMain() }
    }

    /// Refresh the models, dispatching the computationally expensive work
    /// onto a background thread.
    /// - Note: Run *on* the main actor
    private func refreshMain() async {
        guard !isLoading else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            models = []
            models = try await refreshBackground()
        } catch {
            print(error) // Implement...
        }
    }

    /// Computationally expensive function to load the models.
    /// - Note: Run *off* the main actor
    /// - Returns: A new random array of models
    private nonisolated func refreshBackground() async throws -> [Model] {
        // Simulate expensive task (for demo purposes)
        try await Task.sleep(for: .seconds(.taskDuration))
        return (1...Int.nModels).map { .random(id: $0) }
    }

    // MARK: - Add

    /// Add a random element to `models`
    func add() {
        guard !isLoading else { return }
        models.append(.random(id: models.count))
    }
}
