//
//  DemoStatsView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-02.
//



import SwiftUI
import Charts

struct DemoStatsView: View {
    
    var weeklyData = [
        SleepDataPoint(day: "Monday", hours: 6),
        SleepDataPoint(day: "Monday", hours: 12, type: "Nap"),
        SleepDataPoint(day: "Tuesday", hours: 7),
        SleepDataPoint(day: "Wednesday", hours: 8),
        SleepDataPoint(day: "Thursday", hours: 9),
        SleepDataPoint(day: "Friday", hours: 10),
        SleepDataPoint(day: "Friday", hours: 6, type: "Studies"),
        SleepDataPoint(day: "Saturday", hours: 11),
        SleepDataPoint(day: "Sunday", hours: 12),
    ]
    
    
    let data = [
        (name: "Cachapa", sales: 9631),
        (name: "Crêpe", sales: 6959),
        (name: "Injera", sales: 4891),
        (name: "Jian Bing", sales: 2506),
        (name: "American", sales: 1777),
        (name: "Dosa", sales: 625)
    ]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Sleep & Activity Overview")
                .font(.title2)
                .bold()
                .padding(.bottom, 10)
            
            Chart {
                ForEach(weeklyData) { d in
                    
                    BarMark(
                        x: .value("Day", d.day),
                        y: .value("Hours", d.hours)
                    )
                    .foregroundStyle(by: .value("Type", d.type))
                    .position(by: .value("Type", d.type))
                    .annotation(position: .overlay) {
                        Text("\(d.hours)")
                            .foregroundStyle(.white)
                            
                    }
                    
                }
            
            }
            .chartYScale(domain: 0...14)
            .chartLegend(.visible)
            .frame(height: 300)
            
        }
        .padding()
    }
}

#Preview {
    DemoStatsView()
}

// MARK: - Pollen Demo
struct Pollen: Identifiable {
    let id = UUID()
    var source: String
    var startDate: Date
    var endDate: Date
    
    
    init(startMonth: Int, numMonths: Int, source: String) {
        self.source = source
        let calendar = Calendar.autoupdatingCurrent
        self.startDate = calendar
            .date(from: DateComponents(year: 2020, month: startMonth, day: 1))!
        self.endDate = calendar
            .date(byAdding: .month, value: numMonths, to: startDate)!
    }
}

var pollenData: [Pollen] = [
    Pollen(startMonth: 1, numMonths: 9, source: "Trees"),
    Pollen(startMonth: 12, numMonths: 1, source: "Trees"),
    Pollen(startMonth: 3, numMonths: 8, source: "Grass"),
    Pollen(startMonth: 4, numMonths: 8, source: "Weeds")
]

