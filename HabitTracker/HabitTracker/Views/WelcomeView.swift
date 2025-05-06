//
//  WelcomeView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-03.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        
        ZStack {
            LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                Spacer()
                
                Image(systemName: "sparkles")
                    .font(.system(size: 60))
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Be the hero of your own story")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                    
                    
                    Text("Habits: A New Hope")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 25)
                
                Spacer()
                
                NavigationLink {
                    HabitListView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Start The Journey")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(Color.orange)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                        )
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    WelcomeView()
}
