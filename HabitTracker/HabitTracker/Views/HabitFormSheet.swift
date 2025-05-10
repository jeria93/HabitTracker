//
//  HabitFormSheet.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-30.
//

import SwiftUI
import SwiftData

struct HabitFormSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    var habit: Habit?
    
    @State private var emoji: String
    @State private var title: String
    @State private var details: String
    
    private let titleLimit = 20
    private let detailsLimit = 70
    
    let onSave: (String, String, String) -> Void
    
    private var isNew: Bool {
        habit == nil || title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
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
                        
                        TextFieldWithLimitView(
                            text: $details,
                            characterLimit: detailsLimit,
                            placeholder: "Description",
                            flashColor: .white.opacity(0.2),
                            textColor: .white,
                            counterColor: .white.opacity(0.7),
                            clearButtonColor: .white,
                            showCounter: true,
                            showClearButton: true
                        )
                        
                        Button(isNew ? "Save Habit" : "Update Habit") {
                            print("Save / Habit Tapped")
                            onSave(emoji, title, details)
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
                        .disabled(!isFormValid)
                        
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
            .navigationTitle(isNew ? "New Habit" : "Edit Habit")
            .toolbar(.hidden, for: .navigationBar)
            .hideKeyboardOnTap()
        }
    }
    
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
