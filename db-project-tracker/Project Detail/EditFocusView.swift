//
//  EditFocusView.swift
//  db-project-tracker
//
//  Created by Abrar Hamim on 28/10/24.
//

import SwiftUI

struct EditFocusView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var project: Project
    @State var focus: String = ""
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                Text("Edit project Foucs")
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                HStack {
                    TextField("focus", text: $focus)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Save") {
                        // Save project to SwiftData
                        project.focus = focus
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .disabled(focus.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }}

