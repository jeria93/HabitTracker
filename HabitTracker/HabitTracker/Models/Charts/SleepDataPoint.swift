//
//  SleepDataPoint.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-02.
//

import Foundation

struct SleepDataPoint: Identifiable {
    
    let id = UUID().uuidString
    var day: String
    var hours: Int
    var type: String
    
    init(day: String, hours: Int, type: String = "Night") {
        self.day = day
        self.hours = hours
        self.type = type
    }
    
}
