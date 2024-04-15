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
    @Environment(\.scenePhase)var scenePhase
    @ObservedObject var coordinator = BaseCoordinator()
    @StateObject var schedulesViewModel: SchedulesViewModel = SchedulesViewModel(stories: [], cities: [])
    
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
                UserDefaults.standard.string(forKey: appTheme) == nil
                ? .none
                : UserDefaults.standard.string(forKey: appTheme) == AppTheme.dark.rawValue
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
        }
    }
    
    @ViewBuilder func appContent() -> some View {
        ViewFactory.getTabBar()
    }
}
