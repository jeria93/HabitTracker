//
//  TimeManager.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-29.
//

import Foundation

struct TimeManager {
    
    static func updateStreaks(for habit: Habit) {
        
        let today = Calendar.current.startOfDay(for: Date())

        guard let lastDate = habit.lastCompleted else {
            habit.streak = 1
            habit.lastCompleted = Date()
            return
        }

        let lastCompletedDay = Calendar.current.startOfDay(for: lastDate)

        if today == lastCompletedDay {
            return
        }
        
        if Calendar.current.isDate(today, inSameDayAs: lastCompletedDay.addingTimeInterval(86400)) {
            habit.streak += 1
        } else {
            habit.streak = 1
        }
        
        habit.lastCompleted = Date()
    }
    
}
