//
//  HabitRowView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-01.
//

import SwiftUI

struct HabitRowView: View {
    
    @ObservedObject var viewModel: HabitListViewModel
    let habit: Habit
    let doneToday: Bool
    let onDone: () -> Void
    
    
    var body: some View {
        
        HStack {
            NavigationLink {
                EditHabitView(habit: habit, viewModel: viewModel)
            } label: {
                VStack(alignment: .leading) {
                    Text(habit.name)
                        .font(.headline)
                    
                    Text("Streak: \(habit.streak)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            .buttonStyle(.plain)
            
            Button(action: onDone) {
                Image(systemName: doneToday
                      ? "checkmark.circle.fill"
                      : "circle")
                .foregroundStyle(doneToday ? .green : .primary)
            }
            .buttonStyle(.borderless)
            .disabled(doneToday)
        }
        .padding(.vertical, 4)
    }
}

#Preview {

            NavigationStack {
                HabitRowView(viewModel: HabitListViewModel(), habit: .init(name: "My Habit"), doneToday: true, onDone: {})
            }
}
