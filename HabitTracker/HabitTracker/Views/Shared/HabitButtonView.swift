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
    let openStats: (Habit) -> Void
    @Binding var isEditing: Bool
    @Binding var activeFABfor: UUID?
    private var isActive: Bool { activeFABfor == habit.id }
    
    var body: some View {
        
        ZStack {
            cardContent
                .simultaneousGesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .onChanged { _ in
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                        .onEnded { _ in
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                activeFABfor = isActive ? nil : habit.id
                            }
                        }
                )
                .onTapGesture {
                    guard activeFABfor == nil else { return }
                    
                    withAnimation(.easeInOut) {
                        viewModel.markHabitAsDone(habit: habit, context: context)
                    }
                }
            if isActive {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { activeFABfor = nil }
                    }
                    .zIndex(1)
            }
            
            // MARK: – FAB-knapparna
            if isActive {
                HStack(spacing: 20) {
                    Button {
                        activeFABfor = nil
                        openEdit()
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .font(.title)
                            .foregroundStyle(.white, .blue)
                    }
                    
                    Button {
                        activeFABfor = nil
                        openStats(habit)
                    } label: {
                        Image(systemName: "chart.bar.fill")
                            .font(.title)
                            .foregroundStyle(.white, .green)
                    }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(2)
            }
            
        }
        .animation(.easeInOut,value: isActive)
        
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
                
                Text(habit.habitDescription)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                    .layoutPriority(1)
                
                Text("\(habit.streak) day streak")
                    .font(.subheadline)
            }
            
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
                    withAnimation(.spring()) {
                        viewModel.deleteHabit(habit: habit, context: context)
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.red)
                        .padding(.trailing)
                }
            }
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.4)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.2), lineWidth: 1)
        })
        .shadow(radius: 2)
    }
}

//#Preview {
//    HabitButtonView(habit: DeveloperPreview.habits[0], openEdit: {}, openStats: {_ in }, isEditing: .constant(true), activeFABfor: .constant(.add)).environmentObject(HabitListViewModel())
//}

final class DeveloperPreview {
    
    static var habits: [Habit] {
        let previewHabit = Habit(title: "Preview Habit")
        previewHabit.emoji = "🐻"
        previewHabit.habitDescription = "This is a very long description for the preview habit."
        previewHabit.streak = 123
        return [previewHabit]
    }
}
