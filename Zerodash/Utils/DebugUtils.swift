//
//  DebugUtils.swift
//  Zerodash
//
//  Created by CA on 27/08/25.
//

import Foundation

/// Debug-only print function that emits zero code in release builds
func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    let output = items.map { "\($0)" }.joined(separator: separator)
    print(output, terminator: terminator)
    #endif
}

/// Debug-only print with prefix for categorization
func debugPrint(_ category: String, _ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    let output = items.map { "\($0)" }.joined(separator: separator)
    print("[\(category)] \(output)", terminator: terminator)
    #endif
}


