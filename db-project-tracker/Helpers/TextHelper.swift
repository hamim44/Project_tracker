//
//  TextHelper.swift
//  db-project-tracker
//
//  Created by Abrar Hamim on 30/10/24.
//

import Foundation

struct TextHelper {
    
    static func convertStat(input: Double) -> String {
        
        switch input {
        case let stat where input > 1000:
            let dividedStat = stat/1000
            return "\(round(dividedStat * 10)/10)k"
            
        default:
            return String(Int(input))
        }
    }
    
    static func limitChar(input: String, limit: Int) -> String {
        if input.count > limit {
            return String(input.prefix(limit))
        }
        
        return input
    }
}
