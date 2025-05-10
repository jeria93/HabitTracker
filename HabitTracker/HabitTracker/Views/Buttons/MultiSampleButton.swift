//
//  MultiSampleButton.swift
//  HabitTracker
//
//  Created by Nicholas Samuelsson Jeria on 2025-05-07.
//

import SwiftUI

struct MultiSampleButton: View {
    
    @State private var colors: [Color] = [
        .red, .blue, .green, .yellow, .cyan, .brown, .purple, .indigo, .mint, .pink
    ]
    
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 15) {
                    ForEach(colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 15)
                            .fill(color.gradient)
                            .frame(height: 200)
                    }
                }
                .padding(15)
            }
            .navigationTitle("Floating Button")
        }
        .overlay(alignment: .bottomTrailing) {
            FloatingButton {
                FloatingAction(symbol: "tray.full.fill") {
                    print("Tray")
                }
                FloatingAction(symbol: "lasso.badge.sparkles") {
                    print("Spark")
                }
                FloatingAction(symbol: "square.and.arrow.up.fill") {
                    print("Share")
                }
            } label: { isExpanded in
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
                    .scaleEffect(1.02)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black, in: .circle)
                    .scaleEffect(isExpanded ? 0.9 : 1) /// Scaling Effect When Expanded
                
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        MultiSampleButton()
    }
}


/// Custom Button
struct FloatingButton<Label: View>: View {
    
    var buttonSize: CGFloat
    var actions: [FloatingAction]
    var label: (Bool) -> Label
    
    init(buttonSize: CGFloat = 50, @FloatingActionBuilder actions: @escaping () -> [FloatingAction], @ViewBuilder label: @escaping (Bool) -> Label) {
        self.buttonSize = buttonSize
        self.actions = actions()
        self.label = label
    }
    
    // View Properties
    @State private var isExpanded: Bool = false
    @State private var dragLocation: CGPoint = .zero
    @State private var selecedAction: FloatingAction?
    @GestureState private var isDragging: Bool = false
    
    var body: some View {
        Button {
            isExpanded.toggle()
        } label: {
            label(isExpanded)
                .frame(width: buttonSize, height: buttonSize)
                .contentShape(.rect)
        }
        .buttonStyle(NoAnimationButtonStyle())
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.3)
                .onEnded { _ in
                    isExpanded = true
                }
                .sequenced(before: DragGesture().updating($isDragging, body: { _, out, _ in
                    out = true
                }).onChanged { value in
                    guard isExpanded else { return }
                    dragLocation = value.location
                }.onEnded { _ in
                    
                    Task {
                        
                        if let selecedAction {
                            isExpanded = false
                            selecedAction.action()
                        }
                        
                        selecedAction = nil
                        dragLocation = .zero
                        
                    }
                })
        )
        .background{
            ZStack {
                ForEach(actions) { action in
                    ActionView(action)
                }
            }
            .frame(width: buttonSize, height: buttonSize)
        }
        .coordinateSpace(name: "FLOATING VIEW")
        .animation(.snappy(duration: 0.4, extraBounce: 0), value: isExpanded)
        
    }
    
    /// Action View
    @ViewBuilder
    func ActionView(_ action: FloatingAction) -> some View {
        
        
        Button {
            print("MultiSampleButton tapped")
            action.action()
            isExpanded = false
        } label: {
            Image(systemName: action.symbol)
                .font(action.font)
                .foregroundColor(action.tint)
                .frame(width: buttonSize, height: buttonSize)
                .background(action.background, in: .circle)
                .contentShape(.circle)
        }
        .buttonStyle(PressableButtonStyle())
        .disabled(!isExpanded)
        .animation(.snappy(duration: 0.3, extraBounce: 0)) { content in
            content
                .scaleEffect(selecedAction?.id == action.id ? 1.15 : 1)
        }
        .background {
            GeometryReader {
                let rect = $0.frame(in: .named("FLOATING VIEW"))
                Color.clear
                    .onChange(of: dragLocation) { oldValue, newValue in
                        if isExpanded && isDragging {
                            ///  Checking if the drag location is inside any action's rect
                            if rect.contains(newValue) {
                                /// User is Pressing on this Action
                                selecedAction = action
                                
                            } else {
                                ///Checking if its gone out of the rect
                                if selecedAction?.id == action.id && !rect.contains(newValue) {
                                    selecedAction = nil
                                }
                            }
                            
                        }
                    }
            }
        }
        .rotationEffect(.init(degrees: progress(action) * -90))
        .offset(x: isExpanded ? -offset / 2 : 0)
        .rotationEffect(.init(degrees: progress(action) * 90))
    }
    
    private var offset: CGFloat {
        let bs = buttonSize + 10
        let count = CGFloat(actions.count)
        switch actions.count {
        case 1:
            return count * bs * 2
        case 2:
            return count * bs * 1.25
        default:
            return count * bs
        }
    }
    
    private func progress(_ action: FloatingAction) -> CGFloat {
        let index = CGFloat(actions.firstIndex { $0.id == action.id } ?? 0)
        let denom = max(CGFloat(actions.count - 1), 1)
        return index / denom
    }
    
}

#Preview("FAB") { MultiSampleButton() }

/// Custom Button Styles
fileprivate struct NoAnimationButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

fileprivate struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.snappy(duration: 0.3, extraBounce: 0), value: configuration.isPressed)
    }
}


/// The model
struct FloatingAction: Identifiable {
    
    private(set) var id: UUID = .init()
    var symbol: String
    var font: Font = .title3
    var tint: Color = .white
    var background: Color = .black
    var action: () -> Void
}

@resultBuilder
struct FloatingActionBuilder {
    
    static func buildBlock(_ components: FloatingAction...) -> [FloatingAction] {
        components.compactMap ({ $0 })
    }
    
}
