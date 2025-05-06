//
//  EmojiValidator.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-06.
//

import Foundation

extension String {
    
    var isSingleEmoji: Bool { return self.count == 1 && self.containsEmoji }

    var containsEmoji: Bool { return unicodeScalars.contains { $0.properties.isEmoji }}

    var onlyEmojis: String { return self.filter { $0.isEmoji } }
}

extension Character {
    
    var isEmoji: Bool { return unicodeScalars.first?.properties.isEmoji == true }
    
}
