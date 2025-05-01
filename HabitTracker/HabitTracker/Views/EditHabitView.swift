//
//  EditHabitView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-30.
//

import SwiftUI
import SwiftData

struct EditHabitView: View {
    
    let habit: Habit
    @EnvironmentObject private var viewModel: HabitListViewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        Form {
            Section {
                TextField("Habit name", text: $viewModel.draftName)
            } header: {
                Text("Edit Habit")
            }
        }
        .navigationTitle("Edit Habit")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    viewModel.renameHabit(habit: habit, to: viewModel.draftName, context: context)
                    dismiss()
                }
                .disabled(viewModel.draftName.isEmpty)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
        }
        .onAppear { viewModel.draftName = habit.name }
    }
}


#Preview {
    EditHabitView(habit: .init(name: "Habit Name")).environmentObject(HabitListViewModel())
}
