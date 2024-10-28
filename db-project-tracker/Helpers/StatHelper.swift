//
//  StatHelper.swift
//  db-project-tracker
//
//  Created by Abrar Hamim on 29/10/24.
//

import Foundation
import SwiftUI

struct StatHelper {
    

    static func updateAdded(project: Project, update: ProjectUpdate) {
        // change hours
        project.hours += update.hours
        // changes wins
        if update.updateType == .milestone {
            project.wins += 1
        }
        // change session
        
        let sortedUpdates = project.updates.sorted { u1, u2 in
            u1.date > u2.date
        }
        
        if sortedUpdates.count >= 2 {
            // check if the leatest two updates have the same date
            let date1 = sortedUpdates[0].date
            let date2 = sortedUpdates[1].date
            if !Calendar.current.isDate(date1, inSameDayAs: date2){
                // if not the same day, then thats means leatest update is first of the
                project.sessions += 1
            }
        } else {
            project.sessions += 1
        }
        
    }
    
    
    static func updateDeleted(project: Project, update: ProjectUpdate) {
        // change hours
        project.hours -= update.hours
        // changes wins
        if update.updateType == .milestone {
            project.wins -= 1
        }
        // Change sessions
        let sameDayUpdates = project.updates.filter({ u in
            Calendar.current.isDate(u.date, inSameDayAs: update.date)
        })
        if sameDayUpdates.count == 0 {
            project.sessions -= 1
        }
        
    }

    static func updateEdited(project: Project, hoursDifferents: Double) {
        project.hours += hoursDifferents
        
    }

}
