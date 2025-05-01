//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-28.
//

import SwiftUI
import SwiftData

struct HabitListView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = HabitListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.habits.isEmpty {
                    EmptyHabitView()
                } else {
                    List {
                        ForEach(viewModel.habits) { habit in
                            HabitRowView(viewModel: viewModel, habit: habit, doneToday: viewModel.isDoneToday(habit: habit)) {
                                viewModel.markHabitAsDone(habit: habit, context: context)
                            }
                        }
                        .onDelete { offsets in
                            viewModel.delete(at: offsets, context: context)
                        }
                    }
                }
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddHabitView(viewModel: viewModel)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                viewModel.fetchHabits(context: context)
            }
        }
    }
}

#Preview {
    Group {
        //Standard-preview med vanor
        NavigationStack {
            HabitListView()
        }
        .modelContainer(PreviewDataProvider().container)
        
        //Preview med tom mock-data
        //        NavigationStack {
        //            HabitListView()
        //        }
        //        .modelContainer(PreviewDataProvider.emptyContainer)
    }
}
