//
//  HabitStatisticsView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-02.
//
import SwiftUI
import Charts
import SwiftData

struct HabitStatisticsView: View {
    
    let habit: Habit
    @StateObject var statsViewModel: HabitStatsViewModel
    @State var selectedPeriod: Period = .weekly
    
    var selectedData: [StreakPoints] {
        switch selectedPeriod {
        case .daily:  return statsViewModel.daily
        case .weekly: return statsViewModel.weekly
        case .monthly: return statsViewModel.monthly
        }
    }
    
    var maxCount: Int { (selectedData.map(\.count).max() ?? 0) + 1 }
    var zeroPoints: [StreakPoints] { selectedData.filter { $0.count == 0 } }
    var donePoints: [StreakPoints] { selectedData.filter { $0.count > 0 } }
    
    var averagePerPeriod: Double {
        guard !selectedData.isEmpty else { return 0 }
        let total = selectedData.reduce(0) { $0 + $1.count }
        return Double(total) / Double(selectedData.count)
    }
    
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            HStack(spacing: 5) {
                Text(habit.emoji)
                    .font(.largeTitle)
                
                Text(habit.title)
                    .font(.title2.bold())
                
            }
            .padding(.top)
            
            
            Picker("Period", selection: $selectedPeriod) {
                ForEach(Period.allCases) { periodTime in
                    Text(periodTime.rawValue).tag(periodTime)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            StatsSummaryView(data: selectedData)
            
            if selectedData.isEmpty {
                Text("No data to display")
                    .foregroundStyle(.secondary)
                    .padding()
            } else {
                
                Chart {
                    zeroBarMarks
                    doneBarMarks
                    averageRuleMark
                }
                .mask(RoundedRectangle(cornerRadius: 12))
                .chartYScale(domain: 0...Double(maxCount))
                .chartXAxis { chartXAxisMarks }
                .chartYAxis { chartYAxisMarks }
                .chartXAxisLabel("Time")
                .chartYAxisLabel("Days Completed")
                .padding()
            }
        }
        .navigationTitle("Habit statistics")
    }
}

private struct DemoHabitStatisticsView: View {
    
    @StateObject private var vm: HabitStatsViewModel
    private let container: ModelContainer
    private let previewHabit: Habit
    
    init() {
        let container = try! ModelContainer(for: Habit.self, HabitCompletion.self)
        let context = container.mainContext
        let habit = Habit(title: "Read Books")
        habit.emoji = "📚"
        let dates = (0..<5).map { Date().addingTimeInterval(-Double($0) * 86400) }
        for date in dates {
            let comp = HabitCompletion(habit: habit, date: date)
            context.insert(comp)
        }
        try? context.save()
        let viewModel = HabitStatsViewModel(habit: habit, context: context)
        
        _vm = StateObject(wrappedValue: viewModel)
        self.container = container
        previewHabit = habit
    }
    
    var body: some View {
        NavigationStack {
            HabitStatisticsView(habit: previewHabit, statsViewModel: vm)
        }
        .modelContainer(container)
    }
}
private struct EmptyHabitStatisticsView: View {
    
    @StateObject private var vm: HabitStatsViewModel
    private let container: ModelContainer
    private let previewHabit: Habit
    
    init() {

        let previewContainer = try! ModelContainer(for: Habit.self, HabitCompletion.self)
        let previewContext = previewContainer.mainContext
        
        let habit = Habit(title: "No Data")
        habit.emoji = "❓"

        let viewModel = HabitStatsViewModel(habit: habit, context: previewContext)
        viewModel.daily = []
        viewModel.weekly = []
        viewModel.monthly = []
        
        _vm = StateObject(wrappedValue: viewModel)
        self.container = previewContainer
        previewHabit = habit
    }
    
    var body: some View {
        NavigationStack {
            HabitStatisticsView(habit: previewHabit, statsViewModel: vm)
        }
        .modelContainer(container)
    }
}

#Preview("Empty Statistics") {
    EmptyHabitStatisticsView()
}

#Preview("Sample Statistics") {
    DemoHabitStatisticsView()
}
