//
//  HabitStatsViewModel.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-02.
//

import Foundation
import SwiftData

@MainActor
final class HabitStatsViewModel: ObservableObject {
    
    private let habit: Habit
    private let context: ModelContext
    private let calendar = Calendar.current
    
    init(habit: Habit, context: ModelContext) {
        self.habit = habit
        self.context = context
    }
 
}
