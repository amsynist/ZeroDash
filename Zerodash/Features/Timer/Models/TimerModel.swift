//
//  TimerModel.swift
//  Zerodash
//
//  Created by CA on 30/08/25.
//

import Observation

@Observable
final class TimerModel {
    var isRunning = false
    var secondsRemaining = 0
    func start(seconds: Int) { secondsRemaining = seconds; isRunning = true }
    func stop() { isRunning = false }
}
