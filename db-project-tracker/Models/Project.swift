//
//  Project.swift
//  db-project-tracker
//
//  Created by Chris Ching on 2023-11-10.
//

import Foundation
import SwiftData

@Model
class Project: Identifiable {
    
    @Attribute(.unique) var id: String
    var name = ""
    var startDate = Date()
    var focus = ""
    @Relationship(deleteRule: .cascade, inverse: \ProjectUpdate.project)
    var updates: [ProjectUpdate] = [ProjectUpdate]()
    var hours: Double = 0
    var sessions: Int = 0
    var wins: Int = 0
    
    init() {
        id = UUID().uuidString
    }
}
