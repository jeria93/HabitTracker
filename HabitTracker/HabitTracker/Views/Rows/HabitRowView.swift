//
//  HabitRowView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-01.
//

import SwiftUI

struct HabitRowView: View {
    
    @EnvironmentObject private var viewModel: HabitListViewModel
    @Environment(\.modelContext) private var context
    let habit: Habit
    
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                Text(habit.name)
                    .font(.headline)
                
                Text("Streak: \(habit.streak)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.habitEditing = habit
                viewModel.draftName = habit.name
                viewModel.showEditSheet = true
            }

            Spacer()
            
            Button {
                viewModel.markHabitAsDone(habit: habit, context: context)
            } label: {
                Image(systemName: viewModel.isDoneToday(habit: habit) ? "checkmark.circle.fill" : "circlebadge")
                    .foregroundStyle(viewModel.isDoneToday(habit: habit) ? .green : .primary)
            }
            .buttonStyle(.borderless)
            .disabled(viewModel.isDoneToday(habit: habit))
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    HabitRowView(habit: .init(name: "First Habit")).environmentObject(HabitListViewModel())
}

//#Preview {
//    PreviewWrapper {
//        HabitRowView(habit: .init(name: "Walk the dog 🐕"))
//    }
//}
