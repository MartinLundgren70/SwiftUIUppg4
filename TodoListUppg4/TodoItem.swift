//
//  TodoItem.swift
//  TodoListUppg4
//
//  Created by Martin Lundgren on 2024-11-20.
//

import SwiftData
import Foundation

@Model
class TodoItem {
    var title: String
    var isDone: Bool = false
    
    init(title: String) {
        self.title = title
    }
}
