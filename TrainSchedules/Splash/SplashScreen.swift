//
//  SplashScreen.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 11.04.2024.
//

import SwiftUI

struct SplashScreen: View {
    
    @Binding var shouldShowSplash: Bool
    
    var body: some View {
        ZStack {
            Color.blueUniversal
            Image("splash")
                .resizable()
                .ignoresSafeArea()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(
                deadline: .now() + 2) {
                    withAnimation {
                        self.shouldShowSplash = false
                    }
                }
        }
    }
}

#Preview {
    SplashScreen(shouldShowSplash: .constant(true))
}
