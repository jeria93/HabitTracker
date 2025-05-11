//
//  Habit.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-28.
//

import Foundation
import SwiftData


@Model
final class Habit {
    @Attribute(.unique) var id: UUID
    var title: String
    var streak: Int
    var lastCompleted: Date?
    var habitDescription: String
    var emoji: String
    
    @Relationship(deleteRule: .cascade, inverse: \HabitCompletion.habit)
    var completions: [HabitCompletion]
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.streak = 0
        self.lastCompleted = nil
        self.completions = []
        self.habitDescription = ""
        self.emoji = ""
    }
}
