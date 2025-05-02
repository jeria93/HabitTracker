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
    private let context: ModelContext // Flytta till vy om det är enklare. Men testa först
    private let calendar = Calendar.current
    
    init(habit: Habit, context: ModelContext) {
        self.habit = habit
        self.context = context
    }
    
    
    func generateStats(component: Calendar.Component, periodCount: Int) -> [StreakPoints] {
        
        guard periodCount > 0 else { return [] }
        
        let now = Date.now
        
        
        guard let periodStart = calendar.dateInterval(of: component, for: now)?.start else { return [] }
        
        //        var stats: [StreakPoints] = []
        
        fatalError()
    }
}
