//
//  HabitListViewModel.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-29.
//

import Foundation
import SwiftData

@MainActor
final class HabitListViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    
    
    func markHabitAsDone(habit: Habit, context: ModelContext) {
        TimeManager.updateStreaks(for: habit)
        do {
            try context.save()
        } catch {
            errorMessage = "Could not save changes. \(error.localizedDescription)"
        }
    }
    
    func addHabit(name: String, context: ModelContext) {
        let newHabit = Habit(name: name)
        do {
            try context.save()
        } catch {
            errorMessage = "Could not save changes. \(error.localizedDescription)"
        }
    }
    
    //    add habit ()
    
    
}
