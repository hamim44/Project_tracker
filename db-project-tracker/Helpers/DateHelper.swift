//
//  DateHelper.swift
//  db-project-tracker
//
//  Created by Abrar Hamim on 28/10/24.
//

import Foundation

struct DateHelper {
    static func dateFormatterString(inputDate: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMMM d, yyyy"
        return df.string(from: inputDate)
    }
    
}
