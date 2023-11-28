//
//  ProjectDetailView.swift
//  db-project-tracker
//
//  Created by Chris Ching on 2023-11-28.
//

import SwiftUI

struct ProjectDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    var project: Project
    
    var body: some View {
        
        VStack {
            Text(project.name)
                .navigationBarBackButtonHidden(true)
            Button("Back") {
                // Navigate back
                dismiss()
            }
        }
    }
}

#Preview {
    ProjectDetailView(project: Project())
}
