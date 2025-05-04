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
    
    private init(fill: Bool) {
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
    private static let mockHabits: [Habit] = [
        
        .init(name: "Swim"),
        .init(name: "Drink Water"),
        .init(name: "Read 10 pages"),
        .init(name: "Go for a walk"),
        .init(name: "Go to the gym"),
        .init(name: "Medidate 10 minutes"),
        .init(name: "Cook dinner"),
        .init(name: "Walk the dog"),
        .init(name: "Go to bed early"),
        
        /*
         you can either do .init or Habit(name: "Nicholas")
         Also works with:
         
         Habit(name: "Go gym"),
         Habit(name: "Go gym")
         etc
         */
    ]
}
