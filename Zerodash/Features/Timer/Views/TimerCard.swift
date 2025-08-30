//
//  TimerCard.swift
//  Zerodash
//
//  Created by CA on 30/08/25.
//

import SwiftUI

struct TimerCard: View {
    var model: TimerModel
    var body: some View {
        VStack(spacing: 8) {
            Text("Timer").font(.headline)
            Text("\(model.secondsRemaining) s")
        }
        .cardStyle()
    }
}
