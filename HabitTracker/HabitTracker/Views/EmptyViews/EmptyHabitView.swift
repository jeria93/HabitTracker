//
//  EmptyHabitView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-30.
//

import SwiftUI

struct EmptyHabitView: View {
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Image(systemName: "plus.square.on.square")
                    .font(.system(size: 80))
                    .foregroundStyle(.gray.opacity(0.9))
                    .shadow(radius: 10)
                
                Text("No habits yet!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    
                
                Text("Start adding habits by tapping the plus button in the top right corner.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(.horizontal, 30)
                
            }.padding()
        }
    }
}

#Preview {
    EmptyHabitView()
}
