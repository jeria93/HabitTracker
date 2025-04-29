//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-28.
//

import SwiftUI
import SwiftData

struct AddHabitView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HabitListViewModel
    
    var body: some View {
       
        Form {
            Section {
                TextField("Start a new habit", text: $viewModel.name)
            } header: {
                Text("New habits")
            }
            
            Button("Save") {
                viewModel.addHabit(name: viewModel.name, context: context)
                dismiss()
            }
            .disabled(viewModel.name.isEmpty)

        }
        .navigationTitle("Add Habit")
    }
}

#Preview {
    let provider = PreviewDataProvider()
    NavigationStack {
        AddHabitView(viewModel: HabitListViewModel())
            .modelContainer(provider.container)
    }
}



//#Preview {
//    let provider = PreviewDataProvider()
//    return NavigationStack {
//        HabitListView()
//            .modelContainer(provider.container)
//    }
