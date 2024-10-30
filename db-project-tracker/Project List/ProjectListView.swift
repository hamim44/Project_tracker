//
//  ContentView.swift
//  db-project-tracker
//
//  Created by Chris Ching on 2023-11-10.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
    
    @State private var newProject: Project?
    @Query private var projects: [Project]
    @State private var showProjectDetails: Project?
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color("Deep Purple"), Color("Blush Pink")],
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack (alignment: .leading) {
                    
                    Text("Projects")
                        .font(.screenHeading)
                        .foregroundStyle(Color.white)
                    if projects.count > 0 {
                        ScrollView (showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 26) {
                                
                                ForEach(projects.sorted(by: { p1, p2 in
                                    p1.startDate < p2.startDate })) { p in
                                        ProjectCardView(project: p)
                                            .onTapGesture {
                                                showProjectDetails = p
                                            }
                                            .onLongPressGesture {
                                                newProject = p
                                            }
                                        
                                    }
                            }
                        }
                    } else {
                        Spacer()
                        HStack {
                            Spacer()
                            Button("Tap to add a new project") {
                                newProject = Project()
                            }
                            .buttonStyle(.bordered)
                            .foregroundStyle(.white)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .padding()
                
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            // Create new project
                            self.newProject = Project()
                        }, label: {
                            ZStack {
                                Circle()
                                    .frame(width: 65)
                                    .foregroundColor(.black)
                                Image("cross")
                            }
                        })
                        Spacer()
                    }
                }
                .padding(.leading)
            }
            .navigationDestination(item: $showProjectDetails) { project in
                ProjectDetailView(project: project)
            }
        }
        .sheet(item: $newProject) { project in
            let isEdit = project.name.trimmingCharacters(in: .whitespacesAndNewlines) != ""
            EditProjectView(project: project, isEditMode: isEdit)
                .presentationDetents([.fraction(0.2)])
        }
    }
}

#Preview {
    ProjectListView()
}
