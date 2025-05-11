//
//  TextFieldWithLimitView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-06.
//

import SwiftUI

struct TextFieldWithLimitView: View {
    
    @Binding var text: String
    let characterLimit: Int
    let placeholder: String
    let flashColor: Color
    let textColor: Color
    let counterColor: Color
    let clearButtonColor: Color
    let showCounter: Bool
    let showClearButton: Bool
    
    
    @State private var didReachLimit = false
    @State private var backgroundFlash = Color.clear
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(textColor.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            
            TextField("", text: $text)
                .textFieldStyle(.plain)
                .foregroundColor(textColor)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(backgroundFlash))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(counterColor.opacity(0.4)))
                .onChange(of: text) {
                    if characterLimit == 1 {
                        let onlyEmoji = text.onlyEmojis
                        text = String(onlyEmoji.prefix(1))
                    } else if text.count > characterLimit {
                        text = String(text.prefix(characterLimit))
                    }
                    
                    if text.count == characterLimit && !didReachLimit {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            backgroundFlash = flashColor
                        }
                        
                        Task { @MainActor in
                            try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 sec
                            withAnimation(.easeInOut(duration: 0.2)) {
                                backgroundFlash = .clear
                            }
                        }
                        
                        didReachLimit = true
                        
                    } else if text.count < characterLimit {
                        didReachLimit = false
                    }
                }
            
            HStack(spacing: 5) {
                
                if showClearButton && !text.isEmpty {
                    Button(action: { text = "" }) {
                        
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(clearButtonColor)
                            .transition(.scale.combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.2), value: text)
                    }
                }
                
                if showCounter && !text.isEmpty {
                    Text("\(text.count)/\(characterLimit)")
                        .font(.caption)
                        .foregroundColor(counterColor)
                }
            }
            .padding(.trailing, 8)
        }
    }
}

#Preview {
    TextFieldWithLimitPreviewWrapper()
}

private struct TextFieldWithLimitPreviewWrapper: View {
    
    @State private var sampleText = ""
    
    var body: some View {
        
        ZStack {
            LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                
                TextFieldWithLimitView(
                    text: $sampleText,
                    characterLimit: 10,
                    placeholder: "Preview...",
                    flashColor: .white.opacity(0.2),
                    textColor: .white,
                    counterColor: .white.opacity(0.2),
                    clearButtonColor: .white,
                    showCounter: true,
                    showClearButton: true
                )
                
                
                Text("You wrote: \(sampleText)")
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding(.horizontal,20)
        }
    }
}
