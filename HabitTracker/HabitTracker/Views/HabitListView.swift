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
    @StateObject var viewmodel = HabitListViewModel()
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(habits) { habit in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(habit.name)
                                .font(.headline)
                            
                            Text("Streak: \(habit.streak)")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
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
            .modelContainer(PreviewData.previewContainer)
    }
}
