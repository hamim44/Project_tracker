//
//  ProjectDetailView.swift
//  db-project-tracker
//
//  Created by Chris Ching on 2023-11-28.
//

import SwiftUI

struct ProjectDetailView: View {
    @State var update: ProjectUpdate?
    @Environment(\.dismiss) private var dismiss
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
                        StatBubbleView(title: "Hours", stat: "290", startColor: Color("Navy"), endColor: Color("Sky Blue"))
                        StatBubbleView(title: "Sessions", stat: "34", startColor: Color("Turtle Green"), endColor: Color("Lime"))
                        StatBubbleView(title: "Updates", stat: "32", startColor: Color("Maroon"), endColor: Color("Fuschia"))
                        StatBubbleView(title: "Wins", stat: "9", startColor: Color("Maroon"), endColor: Color("Olive"))
                        Spacer()
                        
                    }
                    
                    Text("My current focud is...")
                        .font(.featuredText)
                    HStack {
                        Image(systemName: "checkmark.square")
                        Text("Design the new website")
                            .font(.featuredText)
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
                        ForEach(project.updates) { update in
                            ProjectUpdateView(update: update)
                            
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
                        self.update = ProjectUpdate()
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
        .sheet(item: $update) { update in
            AddUpdateView(update: update, project: project)
                .presentationDetents([.fraction(0.3)])
        }
    }
}

#Preview {
    ProjectDetailView(project: Project())
}
