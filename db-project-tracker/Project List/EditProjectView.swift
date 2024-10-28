//
//  EditProjectView.swift
//  db-project-tracker
//
//  Created by Chris Ching on 2023-11-28.
//

import SwiftUI
import SwiftData

struct EditProjectView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var project: Project
    var isEditMode: Bool
    
    @State private var showConfirmation: Bool = false
    @State var projectName: String = ""
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                Text(isEditMode ? "Edit Project" : "Add Project")
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                HStack {
                    TextField("Project name", text: $projectName)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(isEditMode ? "Save" : "Add") {
                        if isEditMode {
                            project.name = projectName
                            
                        } else {
                            // Save project to SwiftData
                            project.name = projectName
                            context.insert(project)
                        }
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .disabled(projectName.trimmingCharacters(in: .whitespacesAndNewlines) == "")
                    
                    if isEditMode {
                        //show delete button
                        Button("Delete") {
                            showConfirmation = true
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .confirmationDialog("Really delete", isPresented: $showConfirmation,titleVisibility: .visible) {
            Button("Yes, delete it") {
                context.delete(project)
                dismiss()
            }
        }
        .onAppear {
            projectName = project.name
        }
    }
}

