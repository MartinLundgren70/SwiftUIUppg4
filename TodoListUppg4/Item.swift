//
//  Item.swift
//  TodoListUppg4
//
//  Created by Martin Lundgren on 2024-11-20.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
