//
//  BottomButtons.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

struct BottomButtons: View {
    @Environment(Manager.self) private var manager

    var body: some View {
        VStack(spacing: .medium) {
            ButtonView(
                title: "add_button",
                foregroundColor: .appLightGray,
                backgroundColor: .appDarkGray
            ) {
                manager.add()
            }

            ButtonView(
                title: "refresh_button",
                foregroundColor: .appBlack,
                backgroundColor: .appYellow
            ) {
                manager.refresh()
            }
        }
        .padding(.extraLarge)
    }
}
