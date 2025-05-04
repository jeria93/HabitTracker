//
//  HabitListView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-04-28.
//
import SwiftUI
import SwiftData

struct HabitListView: View {
    
    @EnvironmentObject private var viewModel: HabitListViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Small habits. Big changes")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading) {
                    
                    Text(Date.now.formatted(.dateTime.month().day().year()))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.cyan)
                    
                    //        List Streak
                    Text("🔥 1 day streak")
                        .font(.title3)
                }
                
                /* Habit List, Button */
                
                LazyVStack(spacing: 15) {
                    ForEach(viewModel.habits) { habit in
                        HabitButtonView(habit: habit)
                    }
                }
                
                
                
          
                
                //   Add Habit Button
                HStack {
                    
                    Spacer()
                    
                    Button {
                        print("Tapped")
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(.orange)
                            
                    }

                    
                }
                Spacer()
                
            }
            .padding()
        }
        
    }
}


#Preview {
    HabitListPreviewWrapper(withMockData: true) {
        HabitListView()
    }
}
