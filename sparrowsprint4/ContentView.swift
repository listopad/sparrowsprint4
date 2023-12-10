//
//  ContentView.swift
//  sparrowsprint4
//
//  Created by Artem Dragunov on 10.12.2023.
//

import SwiftUI

struct AnimatedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(configuration.isPressed ? Color(white: 0.5) : .white)
            .foregroundStyle(.black)
            .clipShape(.circle)
            .animation(.linear(duration: 0.22), value: configuration.isPressed)
    }
}

struct ContentView: View {
    @State private var isAnimatingButton = false
    @State private var isSecondaryAnimation = false

    var body: some View {
        Button(action: animateButton) {
            GeometryReader { proxy in
                let width = proxy.size.width / 2
                let systemName = "play.fill"
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: isAnimatingButton ? width : .zero)
                        .opacity(isAnimatingButton ? 1 : .zero)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: isAnimatingButton ? 0.5 : width)
                        .opacity(isAnimatingButton ? .zero : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: 58, maxHeight: 58)
        .buttonStyle(AnimatedButton())
        .scaleEffect(isSecondaryAnimation ? 0.86 : 1)
    }

    private func animateButton() {
        if !isAnimatingButton {
            withAnimation(.interpolatingSpring(stiffness: 300, damping: 30)) {
                isAnimatingButton = true
                isSecondaryAnimation = true
            } completion: {
                withAnimation {
                    isSecondaryAnimation = false
                }
                isAnimatingButton = false
            }
        }
    }
}


#Preview {
    ContentView()
}
