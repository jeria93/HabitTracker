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
    
    
    @Published var showAddHabitSheet: Bool = false
    @Published var isEditing: Bool = false
    
    @Published var habits: [Habit] = []
    @Published var errorMessage: HabitError?
    @Published var name: String = ""
    
    // MARK: - CRUD OPERATIONS
    
    func addHabit(emoji: String, title: String, description: String, context: ModelContext) {
        print("addhabit called with:", emoji, title, description)
        let newHabit = Habit(title: title)
        newHabit.emoji = emoji
        newHabit.habitDescription = description
        context.insert(newHabit)
        do {
            try context.save()
            fetchHabits(context: context)
        } catch {
            errorMessage = .creationFailed(title)
        }
    }
    
    // READ
    func fetchHabits(context: ModelContext) {
        let descriptor = FetchDescriptor<Habit>(sortBy: [ SortDescriptor(\.title) ])
        do {
            var all = try context.fetch(descriptor)
            all.sort {
                let done0 = isDoneToday(habit: $0)
                let done1 = isDoneToday(habit: $1)
                if done0 == done1 { return $0.title < $1.title }
                return (!done0 && done1)
            }
            habits = all
        } catch {
            errorMessage = .fetchFailed
        }
    }
    
    // UPDATE
    func markHabitAsDone(habit: Habit, context: ModelContext) {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        
        if let last = habit.lastCompleted,
           calendar.isDate(last, inSameDayAs: todayStart) {
            return
        }
        
        let (newStreak, newDate) = TimeManager.nextStreak(
            current: habit.streak,
            lastCompleted: habit.lastCompleted,
            calendar: calendar
        )
        habit.streak = newStreak
        habit.lastCompleted = newDate
        
        let completion = HabitCompletion(habit: habit, date: Date())
        context.insert(completion)
        
        do {
            try context.save()
        } catch {
            errorMessage = .updateFailed(habit.title)
        }
    }
    
    func updateHabit(_ habit: Habit, emoji: String, title:String, details: String, context: ModelContext) {
        habit.emoji = emoji
        habit.title = title
        habit.habitDescription = details
        do {
            try context.save()
            fetchHabits(context: context)
        } catch {
            errorMessage = .updateFailed(title)
        }
    }
    
    func renameHabit(habit: Habit, to newName: String, context: ModelContext) {
        habit.title = newName
        do {
            try context.save()
            fetchHabits(context: context)
        } catch {
            errorMessage = .updateFailed(newName)
        }
    }
    
    // MARK: - Delete
    
    func deleteHabit(habit: Habit, context: ModelContext) {
        habit.completions.forEach { context.delete($0) }
        context.delete(habit)
        do {
            try context.save()
            fetchHabits(context: context)
        } catch {
            errorMessage = .deletionFailed(habit.title)
        }
    }
    
    func isDoneToday(habit: Habit) -> Bool {
        guard let last = habit.lastCompleted else { return false }
        return Calendar.current.isDateInToday(last)
    }
    
}
