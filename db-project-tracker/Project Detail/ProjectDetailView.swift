//
//  ProjectDetailView.swift
//  db-project-tracker
//
//  Created by Chris Ching on 2023-11-28.
//

import SwiftUI
import SwiftData

struct ProjectDetailView: View {
    
    @State var NewUpdate: ProjectUpdate?
    @State var showEditFocus = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    var project: Project
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [Color("Navy"),Color("Sky Blue")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            LinearGradient(colors: [Color("Washed Blue").opacity(0),Color("Sky Blue")],
                           startPoint: .top,
                           endPoint: .bottom)
            .frame(width: 2)
            .padding(.leading, -150)
            
            VStack {
                VStack(alignment: .leading,spacing: 13) {
                    Text(project.name)
                        .font(.screenHeading)
                    
                    HStack(alignment: .center,spacing: 13) {
                        Spacer()
                        StatBubbleView(title: "Hours", stat: String(project.hours), startColor: Color("Navy"), endColor: Color("Sky Blue"))
                        StatBubbleView(title: "Sessions", stat: String(project.sessions), startColor: Color("Turtle Green"), endColor: Color("Lime"))
                        StatBubbleView(title: "Updates", stat: String(project.updates.count), startColor: Color("Maroon"), endColor: Color("Fuschia"))
                        StatBubbleView(title: "Wins", stat: String(project.wins), startColor: Color("Maroon"), endColor: Color("Olive"))
                        Spacer()
                        
                    }
                    
                    Text("My current focud is...")
                        .font(.featuredText)
                    HStack {
                        if(project.focus.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
                            Button {
                                completeMilestorne()
                            } label: {
                                Image(systemName: "checkmark.square")
                            }

                        }
                        
                        Text(project.focus.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "Tap to set focus": project.focus)
                            .font(.featuredText)
                            .onTapGesture {
                                showEditFocus = true
                            }
                    }
                    .padding(.leading)
                    
                }
                .padding()
                .foregroundStyle(.white)
                .background {
                    Color.black
                        .opacity(0.7)
                        .clipShape(.rect(bottomLeadingRadius: 15, bottomTrailingRadius: 15))
                        .ignoresSafeArea()
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 27) {
                        ForEach(project.updates.sorted(by: { u1, u2 in
                            u1.date > u2.date
                        })) { update in
                            ProjectUpdateView(update: update)
                                .onTapGesture {
                                }
                                .onLongPressGesture {
                                    NewUpdate = update
                                }
                            
                        }
                    }
                    .padding()
                    .padding(.bottom, 75)
                }
            }
            VStack {
                Spacer()
                HStack {
                    Button {
                        //Todo : add project update
                        self.NewUpdate = ProjectUpdate()
                    } label: {
                        ZStack{
                            Circle()
                                .foregroundStyle(.black)
                                .frame(width: 65)
                            
                            Image("cross")
                        }
                    }
                    .padding([.leading, .top])
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.white)
                    .tint(.black)
                    .padding([.trailing, .top])
                }
                .background {
                    Color.black
                        .opacity(0.7)
                        .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                        .ignoresSafeArea()
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .sheet(item: $NewUpdate) { update in
            let isEdit = update.headline.trimmingCharacters(in: .whitespacesAndNewlines) != ""
            EditUpdateView(update: update, project: project, isEditMode: isEdit)
                .presentationDetents([.fraction(0.3)])
        }
        .sheet(isPresented: $showEditFocus) {
            EditFocusView(project: project)
                .presentationDetents([.fraction(0.2)])
        }
    }
    
    func completeMilestorne() {
        //create a new project update for milestone
        let update = ProjectUpdate()
        update.updateType = .milestone
        update.headline = "Milestone Achieved"
        update.summary = project.focus
        project.updates.insert(update, at: 0)
        
        // force a swiftdata save
        try? context.save()
        
        //Update the stats
        StatHelper.updateAdded(project: project, update: update)
        
        //clear the project focus
        project.focus = ""
    }
}

#Preview {
    ProjectDetailView(project: Project())
}
