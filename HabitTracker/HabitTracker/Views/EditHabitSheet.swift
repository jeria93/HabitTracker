//
//  EditHabitSheet.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-30.
//

import SwiftUI
import SwiftData

struct EditHabitSheet: View {
    
    let habit: Habit?
    @Binding var draftName: String
    let onSave: (String) -> Void
    let onCancel: () -> Void
    
    var body: some View {
        
        Form {
            Section(header: Text(habit == nil ? "Add Habit" : "Edit Habit")) {
                TextField("Habit name", text: $draftName)
            }
        }
        
        
        .navigationTitle(habit == nil ? "New Habit" : "Edit Habit")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                HStack {
                    Button("Cancel") {
                        onCancel()
                    }
                    Spacer()
                    
                    
                    Button("Save") {
                        onSave(draftName)
                    }
                    .disabled(draftName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding()
            }
            
        }
    }
}

//
//#Preview {
//    NavigationStack {
//        EditHabitSheet(habit: .init(name: "Preview"), draftName: .constant("Preview"), onSave: {_ in }, onCancel: {}).modelContainer(PreviewDataProvider().container)
//    }
//}
