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
    @State private var showEditFAB = false
    
    var body: some View {
        
        ZStack {
            
            cardContent
                .opacity(showEditFAB ? 0.5 : 1)
                .animation(.easeInOut, value: showEditFAB)
                .onTapGesture { viewModel.markHabitAsDone(habit: habit, context: context) }
                .simultaneousGesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .onEnded({ _ in
                            withAnimation(.spring()) { showEditFAB.toggle() }
                        })
                )
                .contentShape(Rectangle())
            
            if showEditFAB {
                
                Button {
                    showEditFAB = false
                    openEdit()
                } label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(
                            Circle()
                                .fill(.blue)
                                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                        )
                }
                .transition(.scale.combined(with: .opacity))
                .zIndex(1)
            }
            
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
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .layoutPriority(1)
//                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(habit.habitDescription)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                    .layoutPriority(1)
                
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
