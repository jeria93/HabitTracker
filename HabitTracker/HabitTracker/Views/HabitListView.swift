//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-28.
//

import SwiftUI
import SwiftData

struct HabitListView: View {
    
    @Query var habits: [Habit]
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(habits) { habit in
                    HStack {
                        VStack {
                            Text(habit.name)
                                .font(.headline)
                        }
                    }
                }
                
            }

        }
    }
    
    func markHabitAsDone(_ habit: Habit) {
        let today = Calendar.current.startOfDay(for: Date())
        
        if let lastDate = habit.lastCompleted {
            let lastCompletedDay = Calendar.current.startOfDay(for: lastDate)
            if today == lastCompletedDay {
                return
            } else if Calendar.current.isDate(today, inSameDayAs: lastCompletedDay).addingTimeInterval(86400)) {
                habit.streak += 1
            } else {
                habit.streak = 1
            }
        }
    }
}

#Preview {
    NavigationStack {
        HabitListView()
    }
}

/*
 
2. Lista av vanor (HabitListView)
 
 */
