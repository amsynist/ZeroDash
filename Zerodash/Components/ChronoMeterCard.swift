//
//  ChronoMeter.swift
//  Zerodash
//
//  Created by CA on 27/08/25.
//
import SwiftUI

// MARK: - Chronometer Card
struct ChronometerCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text("CHRONOMETER")
                    .foregroundColor(.white)
                    .font(.caption.weight(.bold))
                Text("Date & Schedule")
                    .foregroundColor(.white.opacity(0.6))
                    .font(.caption2)
            }
            
            Text("Tuesday, 26 August 2025")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold))
            
            HStack {
                VStack {
                    Text("WEEK")
                        .foregroundColor(.white.opacity(0.6))
                        .font(.caption2)
                    Text("35")
                        .foregroundColor(.green)
                        .font(.title2.weight(.bold))
                }
                Spacer()
                VStack {
                    Text("DAY")
                        .foregroundColor(.white.opacity(0.6))
                        .font(.caption2)
                    Text("238")
                        .foregroundColor(.green)
                        .font(.title2.weight(.bold))
                }
            }
        }
        .padding(20)
        .background(.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
