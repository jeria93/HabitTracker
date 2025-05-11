//
//  TextEditorView.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-10.
//

import SwiftUI

struct TextEditorView: View {
    
    @Binding var text: String
    let placeholder: String
    let characterLimit: Int
    let flashColor: Color
    let textColor: Color
    let borderColor: Color
    let counterColor: Color
    let clearButtonColor: Color
    let showClearButton: Bool
    
    
    @State private var didReachLimit = false
    @State private var backgroundFlash = Color.clear
    
    
    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(textColor.opacity(0.5))
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
            }
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .foregroundStyle(textColor)
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(backgroundFlash.opacity(0.2)))
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(borderColor.opacity(0.4), lineWidth: 1)
                }
                .frame(minHeight: 100)
                .simultaneousGesture(TapGesture().onEnded { _ in print("TextEditor has been tapped")})
                .onChange(of: text) { _,newValue in
                    
                    if newValue.count > characterLimit {
                        text = String(newValue.prefix(characterLimit))
                    }
                    if text.count == characterLimit && !didReachLimit {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            backgroundFlash = flashColor
                        }
                        Task { @MainActor in
                            try? await Task.sleep(nanoseconds: 200_000_000)
                            withAnimation(.easeInOut(duration: 0.2)) {
                                backgroundFlash = .clear
                            }
                        }
                        didReachLimit = true
                        
                    } else if text.count < characterLimit {
                        didReachLimit = false
                    }
                    
                }
            if !text.isEmpty {
                HStack {
                    Spacer()
                    if showClearButton && !text.isEmpty {
                        Button {
                            text = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(clearButtonColor)
                        }
                        .transition(.opacity)
                    }
                    
                    Text("\(text.count)/\(characterLimit)")
                        .font(.caption)
                        .foregroundStyle(counterColor)
                }
                .padding()
                .transition(.opacity)
            }
        }
    }
}


#Preview("TextEditorView") {
    ZStack {
        LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomLeading).ignoresSafeArea()
        
        
        VStack(alignment: .leading, spacing: 15) {
            Text("Description")
                .font(.headline)
                .foregroundStyle(.white.opacity(0.7))
            
            TextEditorView(
                text: .constant("Preview sample text"),
                placeholder: "Description",
                characterLimit: 70,
                flashColor: .white,
                textColor: .white,
                borderColor: .white,
                counterColor: .white.opacity(0.7),
                clearButtonColor: .white,
                showClearButton: true
            )
            .padding()
        }
        
    }
}
