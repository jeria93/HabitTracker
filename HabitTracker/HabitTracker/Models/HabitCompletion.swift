//
//  HabitCompletion.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-01.
//

import SwiftUI
import SwiftData

@Model
final class HabitCompletion {
    @Attribute(.unique) var id: UUID
    var date: Date
    var habit: Habit
    
    init(habit: Habit, date: Date = .now) {
        self.id = UUID()
        self.date = date
        self.habit = habit
    }
}
