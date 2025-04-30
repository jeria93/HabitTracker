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
    @StateObject var viewmodel = HabitListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewmodel.habits.isEmpty {
                    EmptyHabitView()
                } else {
                    List {
                        ForEach(viewmodel.habits) { habit in
                            
                            let doneToday = viewmodel.isDoneToday(habit: habit)
                            
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
                                    viewmodel.markHabitAsDone(habit: habit, context: context)
                                } label: {
                                    
                                    Image(systemName: doneToday ? "checkmark.circle.fill" : "circlebadge")
                                        .foregroundStyle(doneToday ? .green : .primary)
                                }
                                .disabled(doneToday)
                                
                                
                            }
                        }
                        .onDelete { offset in
                            viewmodel.delete(at: offset, context: context)
                        }
                        
                    }
                }
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: AddHabitView(viewModel: viewmodel)) {
                        Image(systemName: "plus")
                    }
                }
                
            }.onAppear {
                viewmodel.fetchHabits(context: context)
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
