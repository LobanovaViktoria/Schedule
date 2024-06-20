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
    @AppStorage("isDarkTheme") private var appTheme: String?
    
    @State private var launcher = AppLauncher()
    @Environment(\.scenePhase)var scenePhase
    @ObservedObject var coordinator = BaseCoordinator()
    @StateObject var schedulesViewModel: SchedulesViewModel = SchedulesViewModel(cities: [])
    @StateObject var storiesViewModel = StoriesViewModel()
    
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
            .preferredColorScheme(
                appTheme == nil
                ? .none
                : appTheme == AppTheme.dark.rawValue
                    ? .dark
                    : .light
            )
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active {
                print("Active")
            } else if newPhase == .background {
                print("Background")
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
            NavigationStack(path: $coordinator.path) {
                ZStack {
                    appContent()
                        .sheet(item: $coordinator.presentSheetItem) { present in
                            ViewFactory.viewForDestination(present)
                        }
                        .fullScreenCover(item: $coordinator.fullCoverItem) { present in
                            ViewFactory.viewForDestination(present)
                        }
                }
                .navigationDestination(for: DestinationFlowPage.self) { destination in
                    ViewFactory.viewForDestination(destination)
                }
            }
            .environmentObject(coordinator)
            .environmentObject(schedulesViewModel)
            .environmentObject(storiesViewModel)
        }
    }
    
    @ViewBuilder func appContent() -> some View {
        ViewFactory.getTabBar()
    }
}
