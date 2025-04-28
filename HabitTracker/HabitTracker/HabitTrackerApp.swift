//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-28.
//

import SwiftUI
import SwiftData

@main
struct HabitTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            HabitListView()
        }
        .modelContainer(for: Habit.self)
    }
}
