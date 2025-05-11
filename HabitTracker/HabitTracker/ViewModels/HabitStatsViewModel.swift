//
//  HabitStatsViewModel.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-02.
//

import Foundation
import SwiftData

@MainActor
final class HabitStatsViewModel: ObservableObject {
    
    @Published var daily: [StreakPoints] = []
    @Published var weekly: [StreakPoints] = []
    @Published var monthly: [StreakPoints] = []
    
    private let habit: Habit
    private let context: ModelContext // Keep for now, else move to view keep it "SwiftData"
    private let calendar = Calendar.current
    
    
    /// - Parameters:
    ///   - habit: the Habit to gather stats for
    ///   - context: SwiftData context
    ///   - calendar: calendar used for date calculations (default `.current`)
    init(habit: Habit, context: ModelContext, calendar: Calendar = .current) {
        self.habit = habit
        self.context = context
        refresh()
    }
    
    func refresh() {
        daily = generateStats(component: .day, periodCount: 7)
        weekly = generateStats(component: .weekOfYear, periodCount: 4)
        monthly = generateStats(component: .month, periodCount: 6)
    }
    /// Builds an array of `StreakPoints` over the given `component` and `periodCount`.
    /// - If `periodCount <= 0`, returns `[]`
    func generateStats(component: Calendar.Component, periodCount: Int) -> [StreakPoints] {
        
        guard periodCount > 0 else { return [] }
        let now = Date.now
        guard let periodStart = calendar.dateInterval(of: component, for: now)?.start else { return [] }
        // Gather unique completion days
        let allDayStarts = Set(habit.completions.map { calendar.startOfDay(for: $0.date) })
        
        var stats: [StreakPoints] = []
        
        for periodIndex in (0..<periodCount).reversed() {
            
            let startOfPeriod = calendar.date(byAdding: component, value: -periodIndex, to: periodStart)!
            let startOfNextPeriod = calendar.date(byAdding: component, value: 1, to: startOfPeriod)!
            
            let count = allDayStarts.filter { $0 >= startOfPeriod && $0 < startOfNextPeriod }.count
            
            stats.append(StreakPoints(id: startOfPeriod, count: count))
        }
        
        return stats
    }
}
