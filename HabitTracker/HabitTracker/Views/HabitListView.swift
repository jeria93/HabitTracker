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
//                            .onTapGesture {
//                                viewModel.habitEditing = habit
//                                viewModel.draftName = habit.name
//                                viewModel.showEditSheet = true
//                            }
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
                Button {
                    // "Add new"
                    viewModel.habitEditing = nil
                    viewModel.draftName = ""
                    viewModel.showEditSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            viewModel.fetchHabits(context: context)
        }
        .sheet(isPresented: $viewModel.showEditSheet) {
            EditHabitSheet(
                habit: viewModel.habitEditing,
                draftName: $viewModel.draftName,
                onSave: { name in
                    if let h = viewModel.habitEditing {
                        viewModel.renameHabit(habit: h, to: name, context: context)
                    } else {
                        viewModel.addHabit(name: name, context: context)
                    }
                    viewModel.showEditSheet = false
                },
                onCancel: {
                    viewModel.showEditSheet = false
                }
            )
            .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    PreviewWrapper {
        HabitListView()
    }
}
