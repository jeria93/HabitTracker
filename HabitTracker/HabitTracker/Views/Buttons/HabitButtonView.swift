//
//  HabitButtonView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-04.
//

import SwiftUI
import SwiftData

struct HabitButtonView: View {
    
    @EnvironmentObject private var viewModel: HabitListViewModel
    @Environment(\.modelContext) private var context
    
    let habit: Habit
    let openEdit: () -> Void
    @Binding var isEditing: Bool
    
    var body: some View {
        
        Button { viewModel.markHabitAsDone(habit: habit, context: context) } label: {
            cardContent
        }
        .contextMenu {
            Button("Edit") { openEdit() }
        }
    }
    
    private var cardContent: some View {
        
        HStack(spacing: 15) {
            
            Text(habit.emoji)
                .font(.system(size: 60))
                .padding(.leading)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(habit.title)
                    .font(.title2.bold())
                    .foregroundStyle(.orange)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(habit.habitDescription)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                
                Text("\(habit.streak) day streak")
                    .font(.subheadline)
            }
            .fixedSize(horizontal: false, vertical: false)
            
            Spacer()
            
            if viewModel.isDoneToday(habit: habit) && !isEditing {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.orange)
                    .padding(.trailing)
            }
            
            if isEditing {
                Button {
                    print("Tapped delete for \(habit.title)")
                    viewModel.deleteHabit(habit: habit, context: context)
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.red)
                        .padding(.trailing)
                        .opacity(1.0)
                }
                
            }
            
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray, radius: 2)
    }
}

#Preview {
    HabitButtonView(habit: DeveloperPreview.habits[0], openEdit: {}, isEditing: .constant(true)).environmentObject(HabitListViewModel())
}

final class DeveloperPreview {
    
    static var habits: [Habit] {
        let previewHabit = Habit(title: "Preview Habit")
        previewHabit.emoji = "🐻"
        previewHabit.habitDescription = "This is a very long description for the preview habit."
        previewHabit.streak = 123
        return [previewHabit]
    }
}
