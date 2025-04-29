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
    
    // CREATE
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
    
    // DELETE
    func deleteHabit(habit: Habit, context: ModelContext) {
        context.delete(habit)
        try? context.save()
        fetchHabits(context: context)
    }
}

extension HabitListViewModel {
    static var previews: HabitListViewModel = {
        
        let viewModel = HabitListViewModel()
        let context = PreviewDataProvider().container.mainContext
        viewModel.fetchHabits(context: context)
        return viewModel
        
    }()
}
