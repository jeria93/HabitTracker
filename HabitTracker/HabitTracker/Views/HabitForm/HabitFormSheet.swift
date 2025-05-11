//
//  HabitFormSheet.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-30.
//

import SwiftUI
import SwiftData

/// A modal sheet for creating or editing a Habit.
///
/// - Presents fields for emoji, title, and description, each with character limits.
/// - Validates that the title is non‐empty before saving.
/// - Calls `onSave` closure with the entered values when saving.
/// - Dismisses itself on successful save or “Cancel”.
struct HabitFormSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    var habit: Habit?
    let onSave: (String, String, String) -> Void
    
    @State private var emoji: String
    @State private var title: String
    @State private var details: String
    @State private var showValidationWarning: Bool = false
    
    private let titleLimit = 20
    private let detailsLimit = 70
    private var isNew: Bool { habit == nil }
    
    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// Initializes the form sheet.
    /// - Parameters:
    ///   - habit: the Habit to edit, or `nil` to create a new one
    ///   - onSave: callback invoked with the entered emoji, title, and details
    init(habit: Habit? = nil,
         onSave: @escaping (String,String,String) -> Void = {_,_,_ in}
    ) {
        self.habit  = habit
        self.onSave = onSave
        _emoji = State(initialValue: habit?.emoji ?? "")
        _title = State(initialValue: habit?.title ?? "")
        _details = State(initialValue: habit?.habitDescription ?? "")
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                LinearGradient(
                    colors: [Color.blue, Color.purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(spacing: 30) {
                        
                        TextFieldWithLimitView(
                            text: $emoji,
                            characterLimit: 1,
                            placeholder: "Emoji",
                            flashColor: Color.white.opacity(0.2),
                            textColor: .white,
                            counterColor: .white.opacity(0.7),
                            clearButtonColor: .clear,
                            showCounter: false,
                            showClearButton: false
                        )
                        .font(.system(size: 80))
                        .multilineTextAlignment(.center)
                        .frame(height: 100)
                        
                        TextFieldWithLimitView(
                            text: $title,
                            characterLimit: titleLimit,
                            placeholder: "Title",
                            flashColor: .white.opacity(0.2),
                            textColor: .white,
                            counterColor: .white.opacity(0.7),
                            clearButtonColor: .white,
                            showCounter: true,
                            showClearButton: true
                        )
                        
                        TextEditorView(
                            text: $details,
                            placeholder: "Description",
                            characterLimit: detailsLimit,
                            flashColor: .white.opacity(0.2),
                            textColor: .white,
                            borderColor: .white,
                            counterColor: .white.opacity(0.7),
                            clearButtonColor: .white,
                            showClearButton: true
                        )
                        
                        if !isFormValid && showValidationWarning {
                            Text("All fields are required")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.8))
                        }
                        
                        Button(isNew ? "Save Habit" : "Update Habit") {
                            
                            if isFormValid {
                                print("Save / Habit Tapped")
                                onSave(emoji, title, details)
                                dismiss()
                            } else {
                                withAnimation {
                                    showValidationWarning = true
                                }
                            }
                        }
                        .font(.headline.bold())
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(Color.orange)
                                .shadow(color: .black.opacity(0.3),radius: 5, y: 5)
                        )
                        .disabled(false)
                        
                        Button("Cancel", role: .cancel) {
                            print("Tapped Cancel")
                            dismiss()
                        }
                        .font(.headline.bold())
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(Color.orange)
                                .shadow(color: .black.opacity(0.3),radius: 5, y: 5)
                        )
                    }
                    .padding(30)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .hideKeyboardOnTap()
        }
    }
    
    /// Returns a color for the counter: red when at limit, otherwise semi‐transparent white
    private func counterColor(_ used: Int, _ limit: Int) -> Color {
        used == limit ? .red : .white.opacity(0.7)
    }
}

#Preview("Add") {
    HabitFormSheet()
}

#Preview("Edit") {
    let mock = Habit(title: "Read 10 pages")
    mock.emoji = "📚"
    mock.habitDescription = "Before bedtime"
    return HabitFormSheet(habit: mock)
}
