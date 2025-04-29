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
    @State var name: String
    
    var body: some View {
       
        Form {
            Section {
                TextField("Start a new habit", text: $name)
            } header: {
                Text("New habits")
            }
            
            Button("Save") {
                viewModel.addHabit(name: name, context: context)
                dismiss()
            }
            .disabled(name.isEmpty)

        }
        .navigationTitle("Add Habit")
    }
}

//#Preview {
//   AddHabitView(viewModel: <#T##HabitListViewModel#>, name: <#T##String#>)
//}
//
