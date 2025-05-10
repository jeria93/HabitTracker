//
//  HabitStatisticsView+ChartContent.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-08.
//

import SwiftUI
import Charts

extension HabitStatisticsView {
    @ChartContentBuilder
    var zeroBarMarks: some ChartContent {
        ForEach(zeroPoints) { point in
            BarMark(x: .value("Time", point.id, unit: .day),
                    y: .value("Count", point.count))
            .foregroundStyle(.gray.opacity(0.3))
        }
    }
    
    @ChartContentBuilder
    var doneBarMarks: some ChartContent {
        ForEach(donePoints) { point in
            BarMark(x: .value("Time", point.id, unit: .day),
                    y: .value("Count", point.count))
            .foregroundStyle(.orange.gradient)
        }
    }
    
    @ChartContentBuilder
    var averageRuleMark: some ChartContent {
        RuleMark(y: .value("Average", averagePerPeriod))
            .foregroundStyle(.gray)
            .lineStyle(StrokeStyle(dash: [5]))
    }
}
