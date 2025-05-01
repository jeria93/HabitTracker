//
//  EditHabitView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-30.
//

import SwiftUI
import SwiftData

struct EditHabitView: View {
    
    @Environment(\.modelContext) private var context
    @ObservedObject var viewModel: HabitListViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Edit Habit")) {
                    TextField("Habit name", text: $viewModel.draftName)
                }
            }
            .navigationTitle("Edit Habit")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.renameHabit(context: context)
                    }
                    .disabled(viewModel.draftName.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.showEditAlert = false
                    }
                }
            }
        }
    }
}


#Preview {
    NavigationStack {
        EditHabitView(viewModel: HabitListViewModel())
    }
}
