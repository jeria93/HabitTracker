//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-28.
//
import SwiftUI
import SwiftData

struct HabitListView: View {
    
    @EnvironmentObject private var viewModel: HabitListViewModel
    @Environment(\.modelContext) var context
    
    @State var showFormSheet: Bool = false
    @State var isEditing: Bool = false
    @State var editingTarget: Habit? = nil
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    Text("Small habits. Big changes")
                        .font(.title).fontWeight(.bold)
                        .padding(.top, 30)
                    
                    VStack(alignment: .leading) {
                        TodayView()
                        
                        Text("🔥 1 day streak")
                            .font(.title3)
                    }
                    
                    LazyVStack(spacing: 15) {
                        ForEach(viewModel.habits) { habit in
                            HabitButtonView(habit: habit, openEdit: {
                                editingTarget = habit
                                showFormSheet = true
                            }, isEditing: $isEditing)
                        }
                    }
                }
                .padding()
            }
            .onAppear {viewModel.fetchHabits(context: context) }
            
            if !showFormSheet && !isEditing {
                Button {
                    withAnimation(.spring()) {
                        editingTarget = nil
                        showFormSheet = true
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .background(
                            Circle()
                                .fill(Color.orange)
                                .shadow(color: .black.opacity(0.25),
                                        radius: 6, y: 4)
                        )
                }
                .padding(.trailing, 25)
                .padding(.bottom, 30)
                .accessibilityLabel("Add new habit")
                .transition(.scale)
            }
        }
        .sheet(isPresented: $showFormSheet, content: {
            HabitFormSheet(habit: editingTarget) { e, t, d in
                if let target = editingTarget {
                    viewModel.updateHabit(target, emoji: e, title: t, details: d, context: context)
                } else {
                    viewModel.addHabit(emoji: e, title: t, description: d, context: context)
                }
                withAnimation(.spring()) {
                    showFormSheet = false
                }
            }
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(isEditing ? "Done" : "Delete") {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isEditing.toggle()
                    }
                    
                }
            }
        }
    }
}

#Preview {
    HabitListPreviewWrapper(withMockData: true) {
        HabitListView()
    }
}
