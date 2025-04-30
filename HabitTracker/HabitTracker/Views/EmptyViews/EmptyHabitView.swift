//
//  EmptyHabitView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-30.
//

import SwiftUI

struct EmptyHabitView: View {
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image(systemName: "plus.square.on.square")
                .font(.system(size: 60))
                .foregroundStyle(.gray.opacity(0.5))
            
            Text("No habits yet!")
                .font(.headline)
            
            Text("Start adding habits by tapping the plus button in the top right corner.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
            
        }.padding()
    }
}

#Preview {
    EmptyHabitView()
}
