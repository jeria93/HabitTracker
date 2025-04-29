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
    @State var name: String
    
    var body: some View {
       
        Form {
            Section {
                TextField("Start a new habit", text: $name)
            } header: {
                Text("New habits")
            }
            
            Button("Save") {
                let newHabit = Habit(name: name)
                context.insert(newHabit)
                try? context.save()
                dismiss()
            }
            .disabled(name.isEmpty)

        }
        .navigationTitle("Add Habit")
    }
}

#Preview {
    NavigationStack {
        AddHabitView(name: "Must go to the bank")
    }
}
