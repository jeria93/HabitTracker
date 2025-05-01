//
//  HabitCompletion.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-01.
//

import Foundation
import SwiftData


@Model
final class HabitCompletion {
  @Attribute(.unique) var id: UUID
  var date: Date
  var habit: Habit

  init(habit: Habit, date: Date = .now) {
    self.id = UUID()
    self.habit = habit
    self.date = date
  }
}
