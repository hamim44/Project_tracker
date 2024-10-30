//
//  EditUpdateView.swift
//  db-project-tracker
//
//  Created by Abrar Hamim on 28/10/24.
//

import SwiftUI

struct EditUpdateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var update: ProjectUpdate
    var project: Project
    var isEditMode: Bool
    
    @State private var headline: String = ""
    @State private var summary: String = ""
    @State private var hours: String = ""
    @State private var showConfirmation: Bool = false
    
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                Text(isEditMode ? "Edit Update" : "New Update")
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                
                TextField("Headline", text: $headline)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Summary", text: $summary,axis: .vertical)
                
                HStack {
                    TextField("Hours", text: $hours)
                        .frame(width: 60)
                        .keyboardType(.numberPad)
                        .onChange(of: hours) { oldValue, newValue in
                            let num = Int(TextHelper.limitChar(input: hours, limit: 2)) ?? 0
                            hours = num > 24 ? "24" : String(num)
                            
                        }
                    
                    Spacer()
                    Button(isEditMode ? "Save" : "add") {
                        
                        // Keep track of the difference in hours for an edit update
                        let hoursDifferents = Double(hours)! - update.hours
                        
                        update.headline = headline
                        update.summary = summary
                        update.hours = Double(hours)!
                        
                        if !isEditMode {
                            // Add project Update
                            project.updates.insert(update, at: 0)
                            
                            // force a swiftdata save
                            try? context.save()
                            
                            // Update stats
                            StatHelper.updateAdded(project: project, update: update)
                        } else {
                            StatHelper.updateEdited(project: project, hoursDifferents: hoursDifferents)
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .disabled(shouldDisable())
                    
                    if isEditMode {
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
            .textFieldStyle(.roundedBorder)
        }
        .confirmationDialog("Really delete the update?", isPresented: $showConfirmation,titleVisibility: .visible) {
            Button("Yes, delete it") {
                project.updates.removeAll { u in
                    u.id == update.id
                }
                // force a swiftdata save
                try? context.save()
                // delete Update
                StatHelper.updateDeleted(project: project, update: update)
                dismiss()
            }
        }
        .onAppear {
            headline = update.headline
            summary = update.summary
            hours = String(Int(update.hours))
        }
    }
    
    private func shouldDisable() -> Bool {
        return headline.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        summary.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        hours.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

