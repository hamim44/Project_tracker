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
                        
                    Spacer()
                    Button(isEditMode ? "Save" : "add") {
                        
                        update.headline = headline
                        update.summary = summary
                        update.hours = Double(hours)!
                        
                        if !isEditMode {
                            project.updates.insert(update, at: 0)
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    
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
        .confirmationDialog("Really delete the update?", isPresented: $showConfirmation) {
            Button("Yes, delete it") {
                project.updates.removeAll { u in
                    u.id == update.id
                }
                dismiss()
            }
        }
        .onAppear {
            headline = update.headline
            summary = update.summary
            hours = String(Int(update.hours))
        }
    }
}

