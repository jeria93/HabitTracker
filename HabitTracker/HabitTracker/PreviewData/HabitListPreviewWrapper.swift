//
//  HabitListPreviewWrapper.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-01.
//
//
import SwiftUI
import SwiftData

struct HabitListPreviewWrapper<Content: View>: View {
    
    @StateObject private var viewModel = HabitListViewModel()
    private let content: Content
    private let container: ModelContainer
    
    init(withMockData: Bool = true, @ViewBuilder content: () -> Content) {
        
        self.container = withMockData ? PreviewDataProvider.filled : PreviewDataProvider.empty
        self.content = content()
    }
    
    var body: some View {
        NavigationStack {
            content
                .environmentObject(viewModel)
        }
        .modelContainer(container)
        .onAppear {
            viewModel.fetchHabits(context: container.mainContext)
        }
    }
}
/*
 /// if you want to pass several views in the preview -  else use content for one
 init (@ViewBuilder content: () -> Content) {
 self.content = content()
 }
 
 */
//
//#Preview {
//    HabitListPreviewWrapper(withMockData: true) {
//        Text("Hello, World!")
//    }
//}
