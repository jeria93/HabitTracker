//
//  PreviewWrapper.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-01.
//

import SwiftUI
import SwiftData

struct PreviewWrapper<Content: View>: View {
    
    let content: Content
    
    init(content: () -> Content) {
        self.content = content()
    }
    
    
    /*
     /// if you want to pass several views in the preview -  else use content for one
     init (@ViewBuilder content: () -> Content) {
     self.content = content()
     }
     
     */
    
    
    var body: some View {
        let provider = PreviewDataProvider()
        let viewModel = HabitListViewModel()
        viewModel.fetchHabits(context: provider.container.mainContext)
        return NavigationStack {
            content
                .environmentObject(viewModel)
        }
        .modelContainer(provider.container)
    }
}
