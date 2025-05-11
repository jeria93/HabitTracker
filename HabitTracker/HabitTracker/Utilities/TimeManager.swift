//
//  TimeManager.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-29.
//

import Foundation

struct TimeManager {
    
    /// Returns the next streak count and normalized "last completed" date
    static func nextStreak(current: Int?, lastCompleted: Date?, calendar: Calendar = .current) -> (streak: Int, lastCompleted: Date) {
        
        let todayStart = calendar.startOfDay(for: Date())
        
        guard let last = lastCompleted else {
            return (1, todayStart)
        }
        
        let lastDayStart = calendar.startOfDay(for: last)
        
        if calendar.isDate(lastDayStart, inSameDayAs: todayStart) {
            return (current ?? 0, lastDayStart)
        }
        
        let yesterday = calendar.date(byAdding: .day, value: -1, to: todayStart)!
        
        if calendar.isDate(lastDayStart, inSameDayAs: yesterday) {
            return ((current ?? 0) + 1, todayStart)
        } else {
            return (1, todayStart)
        }
    }
    
    
}


