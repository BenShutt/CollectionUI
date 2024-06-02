//
//  ContentView.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(Manager.self) private var manager

    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
                .zIndex(1)

            CollectionView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay {
                    if manager.isLoading {
                        ProgressView()
                    }
                }
        }
        .stickyBottom {
            BottomButtons()
        }
    }
}
