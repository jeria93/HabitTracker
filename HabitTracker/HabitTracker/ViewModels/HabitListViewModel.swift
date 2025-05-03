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
    
    @Published var habits: [Habit] = []
    @Published var errorMessage: String?

    
    @Published var name: String = ""
    @Published var habitEditing: Habit?
    @Published var draftName: String = ""
    @Published var showEditSheet = false
    
    

    
    
    // MARK: - CRUD OPERATIONS
    func addHabit(name: String, context: ModelContext) {
        let newHabit = Habit(name: name)
        context.insert(newHabit)
        try? context.save()
        fetchHabits(context: context)
    }
    
    // READ
    func fetchHabits(context: ModelContext) {
        let descriptor = FetchDescriptor<Habit>(sortBy: [SortDescriptor(\.name)])
        habits = (try? context.fetch(descriptor)) ?? []
    }
    
    // UPDATE
    func markHabitAsDone(habit: Habit, context: ModelContext) {
        TimeManager.updateStreaks(for: habit)
        
        let completed = HabitCompletion(habit: habit)
        context.insert(completed) // -> Theoretically is now saving a habit with a range of history
        try? context.save()
    }
    
    func renameHabit(habit: Habit, to newName: String, context: ModelContext) {
        habit.name = draftName
        do {
            try context.save()
            fetchHabits(context: context)
        } catch {
            errorMessage = "Could not rename habit: \(error.localizedDescription)"
        }
    }
    
    // MARK: - Delete
    func deleteHabit(habit: Habit, context: ModelContext) {
        context.delete(habit)
        try? context.save()
        fetchHabits(context: context)
    }
    
    func delete(at offsets: IndexSet, context: ModelContext) {
        offsets.map { habits[$0] }.forEach { habit in
            deleteHabit(habit: habit, context: context)
        }
    }
    
    func isDoneToday(habit: Habit) -> Bool {
        guard let last = habit.lastCompleted else { return false }
        return Calendar.current.isDateInToday(last)
    }
    
}
