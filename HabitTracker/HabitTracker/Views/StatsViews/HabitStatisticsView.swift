//
//  HabitStatisticsView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-02.
//

import SwiftUI
import Charts

enum Period: String, CaseIterable, Identifiable {
    
    var id: Self { self }
    
    case daily = "Daily"
    case weekly = "Weekly"
    case montly = "Montly"
    
}

struct HabitStatisticsView: View {
    
    @StateObject var statsViewModel: HabitStatsViewModel
    @State private var selectedPeriod: Period = .weekly
   
    var selectedData: [StreakPoints] {
        switch selectedPeriod {
            
        case .daily:
            return statsViewModel.daily
        case .weekly:
            return statsViewModel.weekly
        case .montly:
            return statsViewModel.monthly
        }
    }
    
    var body: some View {
        VStack {
            
            Picker("Period", selection: $selectedPeriod) {
                ForEach(Period.allCases) { periods in
                    Text(periods.rawValue).tag(periods)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Chart {
                ForEach(selectedData) { point in
                    BarMark(
                        x: .value("Time", point.id, unit: .day),
                        y: .value("Count", point.count)
                    )
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic) { value in
                AxisGridLine()
                AxisTick()
                    AxisValueLabel {
                        
                        if let date = value.as(Date.self) {
                            switch selectedPeriod {
                            case .daily:
                                Text(date.formatted(.dateTime.weekday(.abbreviated)))
                            case .weekly:
                                Text("w. \(Calendar.current.component(.weekOfYear, from: date))")
                            case .montly:
                                Text(date.formatted(.dateTime.month(.abbreviated)))
                            }
                        }
                    }
                }
            }
            .chartYAxis { AxisMarks(position: .leading) }
            .padding()
            
        }
        .navigationTitle("Habit statistics")
    }
  }

#Preview {
    StatsPreviewWrapper()
}


