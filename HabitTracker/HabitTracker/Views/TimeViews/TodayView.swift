//
//  TodayView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-05.
//

import SwiftUI

struct TodayView: View {
    
    var body: some View {
        
        TimelineView(PeriodicTimelineSchedule(from: .now, by: 60*60)) { context in
            
            Text(context.date.formatted(.dateTime.month().day().year()))
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.cyan)
        }
    }
}

#Preview {
    TodayView()
}
