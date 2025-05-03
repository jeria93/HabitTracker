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
    
    init(habit: Habit, context: ModelContext) {
        self.habit = habit
        self.context = context
        refresh()
    }
    
    func refresh() {
        daily = generateStats(component: .day, periodCount: 7)
        weekly = generateStats(component: .weekOfYear, periodCount: 4)
        monthly = generateStats(component: .month, periodCount: 6)
    }

    func generateStats(component: Calendar.Component, periodCount: Int) -> [StreakPoints] {
    
//         If there are no periods to calculate, bail out
        guard periodCount > 0 else { return [] }
        
//      Find the start of the "current" period (today/this week/this month)
        let now = Date.now
        guard let periodStart = calendar.dateInterval(of: component, for: now)?.start else { return [] }
//        If for some reason we cant get a valid date, return an empty list, we cant show/calculate stats
        
        var stats: [StreakPoints] = []
        
//        Loop from oldest period (periodCound -1) to most recent (0)
        for periodIndex in (0..<periodCount).reversed() {
            
//            Calculate the start and end of the specific period -> will be useful in Charts
            let startOfPeriod = calendar.date(byAdding: component, value: -periodIndex, to: periodStart)! // -periodIndex is needed for tracking back, else would track forward +1,+2 etc etc
            let startOfNextPeriod = calendar.date(byAdding: component, value: 1, to: startOfPeriod)!
            
//            Count how many completions happend in [startOfPeriod, startOfNextPeriod], filter all completions that is within the time period
            let count = habit.completions.filter { $0.date >= startOfPeriod && $0.date < startOfNextPeriod }.count
            stats.append(StreakPoints(id: startOfPeriod, count: count))
            
        }
        
        return stats
    }
}
