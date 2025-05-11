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
    @State var isEditing: Bool = false
    
    @State private var showCreateSheet: Bool = false
    @State private var showEditingSheet: Habit? = nil
    
    //    MARK: - UX: Track wich card has its FAB open
    @State private var activeFABfor: Habit.ID? = nil
    
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
            
            if viewModel.habits.isEmpty {
                EmptyHabitView()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        
                        Text("Small habits. Big changes")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 30)
                        
                        VStack(alignment: .leading) {
                            TodayView()

                        }
                        
                        let undone = viewModel.habits.filter { !viewModel.isDoneToday(habit: $0)}
                        let done = viewModel.habits.filter { viewModel.isDoneToday(habit: $0)}
                        
                        Group {
                            
                            if !undone.isEmpty {
                                Text("Pending Habits")
                                    .foregroundStyle(Color.orange.opacity(0.8))
                                    .font(.headline)
                                    .padding(.vertical, 5)
                                
                                ForEach(viewModel.habits) { habit in
                                    HabitButtonView(
                                        habit: habit,
                                        openEdit: { showEditingSheet = habit },
                                        openStats: { selectedStatsHabit = $0 },
                                        isEditing: $isEditing,
                                        activeFABfor: $activeFABfor
                                    )
                                }
                            }
                            
                            if !done.isEmpty {
                                Divider()
                                    .background(Color.white.opacity(0.2))
                                    .padding(.vertical, 10)
                                
                                Text("Completed Today")
                                    .foregroundStyle(Color.orange.opacity(0.8))
                                    .font(.headline)
                                    .padding(.vertical, 5)
                                
                                ForEach(done) { habit in
                                    HabitButtonView(
                                        habit: habit,
                                        openEdit: { showEditingSheet = habit },
                                        openStats: { selectedStatsHabit = $0 },
                                        isEditing: $isEditing,
                                        activeFABfor: $activeFABfor
                                    )
                                    .opacity(0.6) // Dim completed habits
                                }
                            }
                            
                        }
                    }
                    .padding()
                }
                //                .disabled(activeFABfor != nil)
            }
            
            
            
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
                    showCreateSheet = true
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
        .onAppear { viewModel.fetchHabits(context: context) }
        .alert("No Habits", isPresented: $showNoHabitAlert, actions: { // När triggas denna? om den ens gör det?
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
        .sheet(isPresented: $showCreateSheet) {
            HabitFormSheet(habit: nil) { emoji, title, details in
                viewModel.addHabit(emoji: emoji, title: title, description: details, context: context)
            }
        }
        .sheet(item: $showEditingSheet) { habit in
            HabitFormSheet(habit: habit) { emoji, title, details in
                viewModel.updateHabit(
                    habit,
                    emoji: emoji,
                    title: title,
                    details: details,
                    context: context
                )
                showEditingSheet = nil
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
#Preview("Empty List") {
    HabitListPreviewWrapper(withMockData: false) {
        HabitListView()
    }
}
