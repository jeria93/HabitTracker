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
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.habitEditing = habit
                                viewModel.draftName = habit.name
                                viewModel.showEditAlert = true
                            }
                        }
                        .onDelete { offset in
                            viewModel.delete(at: offset, context: context)
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
            .sheet(isPresented: $viewModel.showEditAlert) {
                EditHabitView(viewModel: viewModel)
                    .presentationDetents([.medium, .large])
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
