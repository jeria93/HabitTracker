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
    
    static var filled: ModelContainer { PreviewDataProvider(fill: true).container }
    
    static var empty: ModelContainer { PreviewDataProvider(fill: false).container }
    
    init(fill: Bool) {
        container = Self.makeContainer()
        if fill {
            let previewContext = container.mainContext
            addMockHabits(into: previewContext)
            try? previewContext.save()
            
        }
    }
    
    private static func makeContainer() -> ModelContainer {
        do {
            return try ModelContainer(for: Habit.self, HabitCompletion.self, configurations: .init(isStoredInMemoryOnly: true))
        } catch {
            fatalError("Failed to create preview container/data: \(error)")
        }
    }
    
    private func addMockHabits(into context: ModelContext) {
        Self.mockHabits.forEach { context.insert($0) }
    }
    
    //    Contains mockdata
    private static let mockHabits: [Habit] = {
        
        var previewData: [Habit] = []
        
        let meditation = Habit(title: "Meditation")
        meditation.emoji = "🧘‍♂️"
        meditation.habitDescription = "Meditate for 10 minutes each day."
        meditation.streak = 5
        previewData.append(meditation)
        
        
        let workout = Habit(title: "Workout")
        workout.emoji = "💪"
        workout.habitDescription = "Go to the gym for at least 30 minutes"
        workout.streak = 3
        previewData.append(workout)
        
        let reading = Habit(title: "Read 10 Pages")
        reading.emoji = "📖"
        reading.habitDescription = "Read at least 10 pages of a book"
        reading.streak = 5
        previewData.append(reading)
        
        let water = Habit(title: "Drink Water")
        water.emoji = "💧"
        water.habitDescription = "Drink at least 8 glasses of water"
        water.streak = 10
        previewData.append(water)
        
        let walkDog = Habit(title: "Walk the Dog")
        walkDog.emoji = "🐕"
        walkDog.habitDescription = "Take the dog for a 30-minute walk"
        walkDog.streak = 4
        previewData.append(walkDog)
        
        let journaling = Habit(title: "Journaling")
        journaling.emoji = "📝"
        journaling.habitDescription = "Write one paragraph about your day"
        journaling.streak = 2
        previewData.append(journaling)
        
        return previewData
        
    }()
    
}
