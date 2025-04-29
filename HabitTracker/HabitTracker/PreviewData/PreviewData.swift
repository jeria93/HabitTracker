//
//  PreviewData.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-29.
//

import Foundation
import SwiftUI
import SwiftData

struct PreviewData {
    
    static var habits: [Habit] {
        [
            Habit(name: "Swim"),
            Habit(name: "Drink Water"),
            Habit(name: "Read 10 pages"),
            Habit(name: "Go for a walk"),
            Habit(name: "Go to the gym"),
            Habit(name: "Medidate 10 minutes"),
            Habit(name: "Cook dinner"),
            Habit(name: "Walk the dog")
        ]
    }
    @MainActor
    static var previewContainer: ModelContainer {
        let container = try! ModelContainer(for: Habit.self, configurations: .init(isStoredInMemoryOnly: true))
        
        for habit in habits {
            container.mainContext.insert(habit)
        }
        
        return container
    }
    
    
}
