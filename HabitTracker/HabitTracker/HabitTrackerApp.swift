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
    
    @StateObject private var viewModel = HabitListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HabitListView()
                
            }
            .environmentObject(viewModel)
            .modelContainer(for: [Habit.self, HabitCompletion.self])
        }
    }
}
