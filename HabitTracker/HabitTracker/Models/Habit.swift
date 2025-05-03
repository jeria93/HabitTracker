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
    var name: String
    var streak: Int
    var lastCompleted: Date?

    @Relationship(deleteRule: .cascade, inverse: \HabitCompletion.habit)
    var completions: [HabitCompletion]

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.streak = 0
        self.lastCompleted = nil
        self.completions = []
    }
}
