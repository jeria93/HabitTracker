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
    @EnvironmentObject private var viewModel: HabitListViewModel
    
    var body: some View {
        Group {
            if viewModel.habits.isEmpty {
                EmptyHabitView()
            } else {
                List {
                    ForEach(viewModel.habits) { habit in
                        HabitRowView(habit: habit)
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
                    AddHabitView()
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

#Preview {
    PreviewWrapper {
        HabitListView()
    }
}

