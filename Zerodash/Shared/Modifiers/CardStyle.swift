//
//  CardStyle.swift
//  Zerodash
//
//  Created by CA on 30/08/25.
//

import SwiftUI

public extension View {
    func cardStyle() -> some View {
        self.padding(16)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
