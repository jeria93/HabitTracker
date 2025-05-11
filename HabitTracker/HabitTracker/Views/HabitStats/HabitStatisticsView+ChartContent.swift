//
//  HabitStatisticsView+ChartContent.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-08.
//

import SwiftUI
import Charts

extension HabitStatisticsView {

    /// Draws bars for days/weeks/months with zero completions
    @ChartContentBuilder
    var zeroBarMarks: some ChartContent {
        ForEach(zeroPoints) { point in
            BarMark(x: .value("Time", point.id, unit: .day),
                    y: .value("Count", point.count))
            .foregroundStyle(.gray.opacity(0.3))
        }
    }
    
    /// Draws bars for periods with completions using the app’s accent gradient
    @ChartContentBuilder
    var doneBarMarks: some ChartContent {
        ForEach(donePoints) { point in
            BarMark(x: .value("Time", point.id, unit: .day),
                    y: .value("Count", point.count))
            .foregroundStyle(.orange.gradient)
        }
    }
    
    /// Adds a horizontal rule at the average completion count.
    @ChartContentBuilder
    var averageRuleMark: some ChartContent {
        RuleMark(y: .value("Average", averagePerPeriod))
            .foregroundStyle(.gray)
            .lineStyle(StrokeStyle(dash: [5]))
    }
}
