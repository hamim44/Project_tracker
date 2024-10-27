//
//  ProjectUpdateView.swift
//  db-project-tracker
//
//  Created by Abrar Hamim on 27/10/24.
//

import SwiftUI

struct ProjectUpdateView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
                .shadow(radius: 5,x: 0,y: 4)
            
            
            VStack(alignment: .leading,spacing: 10) {
                HStack {
                    Text("Thuesday, September 12, 2023")
                        .padding(.leading)
                    Spacer()
                    Text("9 Hours")
                        .padding(.trailing)
                }
                .padding(.vertical,5)
                .background {
                    Color.orchid
                        
                }
                Text("Project headline")
                    .font(.smallHeadline)
                    .padding(.horizontal)
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. ")
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            .foregroundStyle(.white)
            .font(.regularText)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    ProjectUpdateView()
}
