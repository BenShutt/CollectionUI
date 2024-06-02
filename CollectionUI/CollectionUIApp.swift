//
//  CollectionUIApp.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

@main
@MainActor struct CollectionUIApp: App {
    @State private var manager = Manager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(manager)
        }
    }
}
