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
            ContentView()
        }
        .modelContainer(for: Habit.self)
    }
}

/*
 feat: integration(SwiftData) and folder structure MVVM
 
 - Added Auth + Firestore support
 - Organized project into MVVM-style folders
 
 
 
 
 */
