//
//  TrainSchedulesApp.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 08.03.2024.
//

import SwiftUI

@main
struct TrainSchedulesApp: App {
    
    @AppStorage("shouldShowSplash") var shouldShowSplash: Bool = true
    @State private var launcher = AppLauncher()
    
    var body: some Scene {
        WindowGroup {
            bodyContentView(
                launchState: shouldShowSplash
                ? AppLauncher.LaunchState.splash
                : AppLauncher.LaunchState.loading
            )
            .onAppear {
                shouldShowSplash
                ? launcher.splash()
                : launcher.load()
            }
        }
    }
    
    @ViewBuilder
    private func bodyContentView(
        launchState: AppLauncher.LaunchState
    ) -> some View {
        
        switch launchState {
            
        case .splash:
            SplashScreen(shouldShowSplash: $shouldShowSplash)
            
        case .loading:
            TabBarView()
        }
    }
}
