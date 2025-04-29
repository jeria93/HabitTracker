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
    
}

#Preview {
    NavigationStack {
        HabitListView()
    }
}
