//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-28.
//
import SwiftUI
import SwiftData
import Charts

struct HabitListView: View {
    
    @EnvironmentObject private var viewModel: HabitListViewModel
    @Environment(\.modelContext) var context
    
    @State private var showNoHabitAlert = false
    @State var showFormSheet: Bool = false
    @State var isEditing: Bool = false
    @State private var editingTarget: Habit? = nil
    
    //    MARK: Navigation
    @State private var showStats = false
    @State private var showSettings = false
    @State private var selectedStatsHabit: Habit? = nil
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
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
                            HabitButtonView(
                                habit: habit,
                                openEdit: { editingTarget = habit },
                                openStats: { selectedStatsHabit = $0 },
                                isEditing: $isEditing
                            )
                        }
                    }
                }
                .padding()
            }
            .onAppear { viewModel.fetchHabits(context: context) }
            
            FloatingButton {
                FloatingAction(symbol: "chart.bar.fill") {
                    
                    if let first = viewModel.habits.first {
                        selectedStatsHabit = first
                    } else {
                        
                        showNoHabitAlert = true
                    }
                }
                FloatingAction(symbol: "gearshape.fill") {
                    showSettings = true
                }
                FloatingAction(symbol: "plus") {
                    editingTarget = Habit(title: "")
                    showFormSheet = true
                }
            } label: { isExpanded in
                Image(systemName: "ellipsis")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .rotationEffect(.degrees(isExpanded ? 90 : 0))
                    .frame(width: 50, height: 50)
                    .background(.orange, in: .circle)
            }
            .padding()
        }
        .alert("No Habits", isPresented: $showNoHabitAlert, actions: {
            Button("OK", role: .cancel) {}
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isEditing.toggle()
                    }
                } label: {
                    Image(systemName: isEditing ? "checkmark" : "trash")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(.orange)
                                .shadow(color: .black.opacity(0.25), radius: 6, y: 4)
                        )
                }
                .padding(.horizontal)
            }
        }
        .sheet(item: $editingTarget, onDismiss: {
            editingTarget = nil
        }) { habit in
            HabitFormSheet(habit: habit) { emoji, title, details in
                if viewModel.habits.contains(where: { $0.id == habit.id }) {
                    viewModel.updateHabit(habit,
                                          emoji: emoji,
                                          title: title,
                                          details: details,
                                          context: context)
                } else {
                    viewModel.addHabit(emoji: emoji,
                                       title: title,
                                       description: details,
                                       context: context)
                }
                editingTarget = nil
            }
        }
        .navigationDestination(item: $selectedStatsHabit, destination: { habit in
            HabitStatisticsView(habit: habit, statsViewModel: HabitStatsViewModel(habit: habit, context: context))
        })
        .navigationDestination(isPresented: $showSettings) {
            SettingsView()
        }
        
    }
}
#Preview {
    HabitListPreviewWrapper(withMockData: true) {
        HabitListView()
    }
}
