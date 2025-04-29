//
//  PreviewDataProvider.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-29.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
final class PreviewDataProvider {
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Habit.self, configurations: .init(isStoredInMemoryOnly: true))
            addMockHabits()
        } catch {
            fatalError("Failde to create preview container/data: \(error)")
        }
    }
    
    private func addMockHabits() {
        let habits =   [
            Habit(name: "Swim"),
            Habit(name: "Drink Water"),
            Habit(name: "Read 10 pages"),
            Habit(name: "Go for a walk"),
            Habit(name: "Go to the gym"),
            Habit(name: "Medidate 10 minutes"),
            Habit(name: "Cook dinner"),
            Habit(name: "Walk the dog")
        ]
        
        for habit in habits {
            container.mainContext.insert(habit)
        }
    }
    
    static var empty: ModelContainer {
        let provider = PreviewDataProvider()
        return provider.container
    }
    
}

