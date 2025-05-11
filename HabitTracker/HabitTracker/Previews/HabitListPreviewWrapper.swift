//
//  HabitListPreviewWrapper.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-01.
//
//
import SwiftUI
import SwiftData


/// Wrapper for SwiftUI previews that:
/// 1. Instantiates a HabitListViewModel
/// 2. Provides an in-memory SwiftData ModelContainer (mock or empty)
/// 3. Embeds your content in a NavigationStack
/// 4. Automatically fetches habits on appear
struct HabitListPreviewWrapper<Content: View>: View {
    
    @StateObject private var viewModel = HabitListViewModel()
    private let content: Content
    private let container: ModelContainer
    
    /// - Parameter withMockData: if true, seeds the container with sample habits
    /// - Parameter content: the preview view to display
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
