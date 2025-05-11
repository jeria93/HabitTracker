//
//  HabitStatisticsView+AxisContent.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-08.
//

import SwiftUI
import Charts

extension HabitStatisticsView {
    /// Custom X-axis ticks: shows automatically generated values with formatted labels
    @AxisContentBuilder
    var chartXAxisMarks: some AxisContent {
        AxisMarks(values: .automatic) { value in
            AxisGridLine()
            AxisTick()
            AxisValueLabel {
                if let date = value.as(Date.self) {
                    Text(selectedPeriod.label(for: date))
                }
            }
        }
    }
    
    /// Custom Y-axis ticks positioned on the leading edge
    @AxisContentBuilder
    var chartYAxisMarks: some AxisContent {
        AxisMarks(position: .leading)
    }
}
