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
        container = Self.makeContainer()
        addMockHabits(into: container.mainContext)
    }
    
    init(empty _: Void) {
        container = Self.makeContainer()
    }
        
    static var empty: ModelContainer {
        let provider = PreviewDataProvider()
        return provider.container
    }
    
    private static func makeContainer() -> ModelContainer {
        do {
            return try ModelContainer(for: Habit.self, configurations: .init(isStoredInMemoryOnly: true))
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
         
         Funkar med Habit(name: "Go gym") också
         
         Habit(name: "Go gym"),
         Habit(name: "Go gym")
         etc
         */
    ]
    
    static var emptyContainer: ModelContainer {
        PreviewDataProvider(empty: ()).container
    }
    
    
}
