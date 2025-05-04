//
//  StatsView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-02.
//

import SwiftUI
import Charts

struct StatsView: View {
    
    @StateObject var statsViewModel: HabitStatsViewModel
    
    var body: some View {
        Chart {
            ForEach(statsViewModel.daily) { point in
                BarMark(
                    x: .value("Day", point.id, unit: .day),
                    y: .value("Completions", point.count)
                )
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.weekday(.abbreviated))
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .padding()
        .navigationTitle("7 Days of Habit Completions")
    }
  }
//
//#Preview {
//    StatsPreviewWrapper()
//}
