//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-28.
//

import SwiftUI
import SwiftData

struct HabitListView: View {
    
    @Environment(\.modelContext) var modelContext
    @StateObject var viewmodel = HabitListViewModel()
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(viewmodel.habits) { habit in
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
                            
                            viewmodel.markHabitAsDone(habit: habit, context: modelContext)
                        } label: {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                }
                .onDelete { offset in
                    viewmodel.delete(at: offset, context: modelContext)
                }
                
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: AddHabitView(viewModel: viewmodel)) {
                        Image(systemName: "plus")
                    }
                }
                
            }
            .onAppear {
                viewmodel.fetchHabits(context: modelContext)
            }
        }
    }
    
}

#Preview {
    let provider = PreviewDataProvider()
    return NavigationStack {
        HabitListView()
            .modelContainer(provider.container)
    }
}
