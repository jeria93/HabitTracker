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
            
            LazyVStack {
                ForEach(viewModel.habits) { habit in
                    Text(habit.name)
                }
            }
            
            
             
             Button {
                 print("tapped")
             } label: {
                 HStack(alignment: .center, spacing: 15) {
     //                Emoji PlaceHolder
                     Text("🏌🏻‍♂️")
                         .font(.system(size: 60))
                         .padding(.leading)
                     
                     
                     VStack(alignment: .leading) {
     //                    Habit Description (Title, description, streak)
                         Text("Habit Title")
                             .foregroundStyle(.orange)
                             .font(.title2)
                             .fontWeight(.semibold)
                         
                         Text("Habit Description")
                             .foregroundStyle(Color(.label))
                             .font(.subheadline)
                             
                         Text("1 day streak")
                             .foregroundStyle(Color(.label))
                             .font(.subheadline)
                     }
                     Spacer()
                     Image(systemName: "checkmark.circle.fill")
                         .font(.system(size: 50))
                         .foregroundStyle(.orange)
                         .padding(.trailing)
                 }
                 .padding()
                 .background(Color(.systemBackground))
                 .cornerRadius(10)
                 .shadow(color: Color(.systemGray), radius: 2)
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


#Preview {
    PreviewWrapper(withMockData: true) {
        HabitListView()
    }
}
