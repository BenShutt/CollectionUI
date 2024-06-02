//
//  EdgeInsets+Extensions.swift
//  CollectionUI
//
//  Created by Ben Shutt on 02/06/2024.
//

import SwiftUI

extension EdgeInsets {
    init(_ value: CGFloat) {
        self.init(
            top: value,
            leading: value,
            bottom: value,
            trailing: value
        )
    }

    var horizontal: CGFloat { leading + trailing }
    var vertical: CGFloat { top + bottom }
}
