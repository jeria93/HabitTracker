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
    @EnvironmentObject private var viewModel: HabitListViewModel
    
    
    var body: some View {
        
        Form {
            Section {
                TextField("Start a new habit", text: $viewModel.name)
            } header: {
                Text("New habits")
            }
            
            Button("Save") {
                viewModel.addHabit(context: context)
                dismiss()
            }
            .disabled(viewModel.name.isEmpty)
            
        }
        .navigationTitle("Add Habit")
    }
}

#Preview {
    PreviewWrapper {
        HabitListView()
    }
    
}
