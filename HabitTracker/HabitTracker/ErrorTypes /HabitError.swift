//
//  HabitError.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-06.
//

import Foundation

enum HabitError: LocalizedError, Equatable {
    
    case creationFailed(String)
    case updateFailed(String)
    case deletionFailed(String)
    case fetchFailed
    case custom(message: String)
    
    var errorDescription: String? {
        
        switch self {
        case .creationFailed(let title):
            return "Failed to create habit: \(title)"
        case .updateFailed(let title):
            return "Could not update habit: \(title)"
        case .deletionFailed(let title):
            return "Could not delete habit: \(title)"
        case .fetchFailed:
            return "Failed to fetch habits."
        case .custom(message: let message):
            return message
        }
    }
}
