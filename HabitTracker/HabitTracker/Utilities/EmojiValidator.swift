//
//  EmojiValidator.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-06.
//

import Foundation


/// Helpers for validating and filtering emoji text input.
extension String {
    
    /// True if the string is exactly one emoji
    var isSingleEmoji: Bool { return self.count == 1 && self.containsEmoji }

    /// True if the string contains at least one emoji
    var containsEmoji: Bool { return unicodeScalars.contains { $0.properties.isEmoji }}

    /// Returns only the emoji characters in the string
    var onlyEmojis: String { return self.filter { $0.isEmoji } }
}

extension Character {
    
    /// True if the character is an emoji
    var isEmoji: Bool { return unicodeScalars.first?.properties.isEmoji == true }
    
}
