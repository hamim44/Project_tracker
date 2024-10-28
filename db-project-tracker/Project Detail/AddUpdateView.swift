//
//  AddUpdateView.swift
//  db-project-tracker
//
//  Created by Abrar Hamim on 28/10/24.
//

import SwiftUI

struct AddUpdateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var update: ProjectUpdate
    var project: Project
    @State private var headline: String = ""
    @State private var summary: String = ""
    @State private var hours: String = ""

    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                Text("New Update")
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
                    Button("Save") {
                        // Save project to SwiftData
                        update.headline = headline
                        update.summary = summary
                        update.hours = Double(hours)!
                        project.updates.insert(update, at: 0)
                        
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
                
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            .textFieldStyle(.roundedBorder)
        }
    }
}

