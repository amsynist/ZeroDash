//
//  TasksModel.swift
//  Zerodash
//
//  Created by CA on 30/08/25.
//


import Observation
import Foundation


struct Item: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var done = false
}


@Observable
final class TasksModel {
   

    var items: [Item] = []

    func add(_ title: String) { items.append(.init(title: title)) }

    func toggle(_ id: Item.ID) {
        if let i = items.firstIndex(where: { $0.id == id }) {
            items[i].done.toggle()
        }
    }
}
