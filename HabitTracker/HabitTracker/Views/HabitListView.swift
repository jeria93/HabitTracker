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
    @StateObject var viewModel = HabitListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.habits.isEmpty {
                    EmptyHabitView()
                } else {
                    List {
                        ForEach(viewModel.habits) { habit in
                            
                            let doneToday = viewModel.isDoneToday(habit: habit)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(habit.name)
                                        .font(.headline)
                                    
                                    Text("Streak: \(habit.streak)")
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)
                                }
                                Spacer()
                                
                                Button {
                                    viewModel.markHabitAsDone(habit: habit, context: context)
                                } label: {
                                    
                                    Image(systemName: doneToday ? "checkmark.circle.fill" : "circlebadge")
                                        .foregroundStyle(doneToday ? .green : .primary)
                                }
                                .disabled(doneToday)
                                
                                
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                
                                Button(role: .destructive) {
                                    viewModel.deleteHabit(habit: habit, context: context)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                                Button {
                                    viewModel.habitEditing = habit
                                    viewModel.draftName = habit.name
                                    viewModel.showEditAlert = true
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: AddHabitView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                    }
                }
                
            }.onAppear {
                viewModel.fetchHabits(context: context)
            }
            .alert("Edit Habit",
                   isPresented: $viewModel.showEditAlert,
                   presenting: viewModel.habitEditing) { habit in
                TextField("Name", text: $viewModel.draftName)
                Button("Save") {
                    // Anropa metod utan habit-argument
                    viewModel.renameHabit(context: context)
                }
                Button("Cancel", role: .cancel) {
                    viewModel.showEditAlert = false
                }
            } message: { _ in
                Text("Change the habit’s name")
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
