//
//  PracticalExtensions.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-07.
//

import Foundation
import SwiftUI
import UIKit

/// Returns a new `Binding<String>` that sets a maximum character count
///
/// - Parameters:
///   - limit: The maximum number of characters allowed.
///   - didReachLimit: A `Binding<Bool>` that is set to `true` the first time the limit is reached (and back to `false` if you fall below it).
///
/// When the user types beyond `limit`, the new value is truncated

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

extension Date {
    
    func dayMonth() -> String {
        formatted(.dateTime.day().month())
    }
    
    func dayMonthYear() -> String {
        formatted(.dateTime.day().month().year())
    }
    
    /// “2025-05-06”
       func isoDate() -> String {
           formatted(.iso8601.year().month().day())
       }
    
    /// “14:30”
    func hourMinute() -> String {
        formatted(.dateTime.hour(.twoDigits(amPM: .omitted))
                   .minute(.twoDigits))
    }
    
}

extension Color {
    
//    use this to apply everywhere later.
    
    
}
