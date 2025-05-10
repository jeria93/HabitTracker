//
//  HabitStatisticsView+AxisContent.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-08.
//

import SwiftUI
import Charts

extension HabitStatisticsView {
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
    
    @AxisContentBuilder
    var chartYAxisMarks: some AxisContent {
        AxisMarks(position: .leading)
    }
}
