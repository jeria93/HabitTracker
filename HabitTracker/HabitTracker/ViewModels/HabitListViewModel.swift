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
    
    //PROPERTIES
    @Published var name: String = ""
    
    // MARK: - CRUD OPERATIONS
    func addHabit(name: String, context: ModelContext) {
        let newHabit = Habit(name: name)
        context.insert(newHabit)
        try? context.save()
    }
    
    // READ
    func fetchHabits(context: ModelContext) {
        let descriptor = FetchDescriptor<Habit>(sortBy: [SortDescriptor(\.name)])
        habits = (try? context.fetch(descriptor)) ?? []
    }
    
    // UPDATE
    func markHabitAsDone(habit: Habit, context: ModelContext) {
        TimeManager.updateStreaks(for: habit)
        try? context.save()
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
