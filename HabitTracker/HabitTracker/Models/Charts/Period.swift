//
//  Period.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-08.
//

import Foundation
import SwiftUI

enum Period: String, CaseIterable, Identifiable {
    
    var id: Self { self }
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
    
    func label(for date: Date) -> String {
        
        switch self {
        case .daily:
            return Date.FormatStyle
                .dateTime
                .weekday(.abbreviated)
                .format(date)
            
        case .weekly:
            let week = Calendar.current.component(.weekOfYear, from: date)
            return "w.\(week)"
            
        case .monthly:
            return Date.FormatStyle
                .dateTime
                .month(.abbreviated)
                .format(date)
        }
    }

}
