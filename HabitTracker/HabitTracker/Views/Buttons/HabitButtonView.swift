//
//  HabitButtonView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-04.
//

import SwiftUI

struct HabitButtonView: View {
    
    @EnvironmentObject private var viewModel: HabitListViewModel
    @Environment(\.modelContext) private var context
    let habit: Habit
    
    var body: some View {
        
        Button {
            viewModel.markHabitAsDone(habit: habit, context: context)
        } label: {
            HStack(alignment: .center, spacing: 15) {
                
                Text(habit.emoji)
                    .font(.system(size: 60))
                    .padding(.leading)
                
                
                VStack(alignment: .leading) {
                    
                    Text(habit.name)
                        .foregroundStyle(.orange)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(habit.habitDescription)
                        .foregroundStyle(Color(.label))
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    
                    Text("\(habit.streak) day streak")
                        .foregroundStyle(Color(.label))
                        .font(.subheadline)
                    
                    
                }
                Spacer()
                if viewModel.isDoneToday(habit: habit) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.orange)
                        .padding(.trailing)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color(.systemGray), radius: 2)
        }
    }
}

#Preview {
    HabitListPreviewWrapper {
        HabitButtonView(habit: DeveloperPreview.habits[0])
    }
}

final class DeveloperPreview {
    
    static var habits: [Habit] {
        let previewHabit = Habit(name: "Preview Habit")
        previewHabit.emoji = "🐻"
        previewHabit.habitDescription = "This is a preview habit."
        previewHabit.streak = 7
        return [previewHabit]
    }
}
