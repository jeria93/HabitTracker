//
//  StatsPreviewWrapper.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-02.
//
//
//import SwiftUI
//import SwiftData
//
//
//struct StatsPreviewWrapper: View {
//    
//    var body: some View {
//        
//        let previewProvider = PreviewDataProvider()
//        let previewContext = previewProvider.container.mainContext
//        
//        let habit = Habit(title: "Mock Habit")
//        previewContext.insert(habit)
//        
//        for i in 0..<7 {
//            
//            let date = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
//            previewContext.insert(HabitCompletion(habit: habit, date: date))
//            
//        }
//        try? previewContext.save()
//        
//        let assignedViewModel = HabitStatsViewModel(habit: habit, context: previewContext)
//        return NavigationStack {
//            StatsView(statsViewModel: assignedViewModel)
//        }
//        .modelContainer(previewProvider.container)
//    }
//}
