//
//  StatsSummaryView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-08.
//

import SwiftUI
import Charts

struct StatsSummaryView: View {
    
    let data: [StreakPoints]
    
    private var totalCompletions: Int { data.reduce(0) { $0 + $1.count } }
    
    private var averagePerPeriod: Double {
        guard !data.isEmpty else { return 0 }
        return Double(totalCompletions) / Double(data.count)
    }
    
    private var longestStreak: Int { data.map(\.count).max() ?? 0 }
    
    var body: some View {
        
        HStack(spacing: 20) {
            
            StatItemView(label: "Total Completions", value: "\(totalCompletions)")
            
            StatItemView(label: "Average", value: String(format: "%.1f", averagePerPeriod))
            
            StatItemView(label: "Max", value: "\(longestStreak)")
            
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

#Preview {
    Group {
        StatItemView(label: "Total Completions", value: "42")
        StatItemView(label: "Average", value: "1.5")
        StatItemView(label: "Max", value: "8")
    }
    .padding()
}

struct StatItemView: View {
    
    let label: String
    let value: String
    
    var body: some View {
        VStack {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.title2.bold())
                .foregroundColor(.orange)
        }
    }
}
