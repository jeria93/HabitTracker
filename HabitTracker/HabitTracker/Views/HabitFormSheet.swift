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
    
    private var isFormValid: Bool { !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    
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
                        
                        
                        Button(habit == nil ? "Save Habit" : "Update Habit") {
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
                        
                        if habit == nil {
                            Button("Cancel", role: .cancel) {
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
                    }
                    .padding(30)
                }
            }
            .navigationTitle(habit == nil ? "New Habit" : "Edit Habit")
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


/// Limits the bound String to a specified maximum number of characters.
///
/// if the input exceeds the limit, the value will be trimmed automatically.
/// for possible future implementations, it suppports haptic feedback when the limit is reached. e.g. vibration
/// - Parameters:
///     - limit:    The maximum number of characters allowed.
///     - didReachLimit:    A binding used to track whether the limit has just been reached, which can be used to trigger optional feedback.
///     - Returns:  A Binding<String> that never surpasses the specified character limit
///
///     Ideal for use in form fields (textfields) or input areas where you want to force character limits.
///     Haptic feedback may be added in future versions.
extension Binding where Value == String {
    func limited(to limit: Int, didReachLimit: Binding<Bool>) -> Binding<String> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                let limitedValue = String(newValue.prefix(limit))
                self.wrappedValue = limitedValue
                
                if limitedValue.count == limit && !didReachLimit.wrappedValue {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    didReachLimit.wrappedValue = true
                } else if limitedValue.count < limit {
                    didReachLimit.wrappedValue = false
                }
            }
        )
    }
}


/// Hides the keyboard when tapping anywhere outside in the view
///
/// - Returns: The original view itself after a tap gesture
///
/// ideal for forms and sheets
extension View {
    
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
