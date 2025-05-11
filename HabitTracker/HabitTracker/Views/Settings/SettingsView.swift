//
//  SettingsView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-07.
//
import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var context
    @State private var showResetConfirm = false
    
    var body: some View {
        
        ZStack {
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Form {
                Section("Danger Zone") {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            .background(Color.white.opacity(0.1).clipShape(RoundedRectangle(cornerRadius: 10)))
                        
                        Button(role: .destructive) {
                            showResetConfirm = true
                        } label: {
                            HStack {
                                Image(systemName: "trash.fill")
                                    .font(.title2)
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(.white)
                                    .frame(width: 30)
                                
                                Text("Delete All Data")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                        }
                        .confirmationDialog(
                            "This will permanently delete all your habits and completions. Are you sure?",
                            isPresented: $showResetConfirm
                        ) {
                            Button("Yes, delete everything", role: .destructive, action: resetAllData)
                            Button("Cancel", role: .cancel) {}
                        }
                    }
                    .listRowBackground(Color.clear)
                    .padding(.vertical, 4)
                }
            }
            .scrollContentBackground(.hidden)
            .background(.clear)
            .listStyle(.plain)
            .navigationTitle("Settings")
        }
    }
    private func resetAllData() {
        if let completions: [HabitCompletion] = try? context.fetch(FetchDescriptor()) {
            completions.forEach(context.delete)
        }
        if let habits: [Habit] = try? context.fetch(FetchDescriptor()) {
            habits.forEach(context.delete)
        }
        try? context.save()
    }
}

#Preview {
    let container: ModelContainer = {
        do {
            return try ModelContainer(
                for: Habit.self,
                HabitCompletion.self,
                configurations: .init(isStoredInMemoryOnly: true)
            )
        } catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }()
    
    NavigationStack {
        SettingsView()
    }
    .modelContainer(container)
    .environment(\.modelContext, container.mainContext)
}
