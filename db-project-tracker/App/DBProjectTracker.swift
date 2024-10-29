//
//  db_project_trackerApp.swift
//  db-project-tracker
//
//  Created by Chris Ching on 2023-11-10.
//

import SwiftUI
import SwiftData

@main
struct DBProjectTracker: App {
    var body: some Scene {
        WindowGroup {
            ProjectListView()
                .modelContainer(for: [Project.self, ProjectUpdate.self])
        }
    }
}
