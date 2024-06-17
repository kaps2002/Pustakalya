//
//  SplashScreenView.swift
//  Pustakalya
//
//  Created by Roro on 17/06/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = true
    @State private var size = 0.2
    @State private var opacity = 0.2
    var body: some View {
        if isActive {
            ZStack {
                Image("bgImg")
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.opacity = 1.0
                        }
                    }
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.5)) {
                            self.size = 1.2
                            self.opacity = 1.0
                        }
                    }
            }
            .onAppear {
                withAnimation(.snappy(duration: 2.0).delay(2.5)) {
                    self.isActive = false
                }
            }
        } else {
            SignInView()
        }
    }
}

#Preview {
    SplashScreenView()
}
