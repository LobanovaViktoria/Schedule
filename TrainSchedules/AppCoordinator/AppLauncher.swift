//
//  AppLauncher.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 11.04.2024.
//

import SwiftUI

class AppLauncher: Observable {
    enum LaunchState {
        case splash
        case loading
    }
    
    var launchState = LaunchState.splash
    
    func splash() {
        launchState = .splash
    }
    
    func load() {
        launchState = .loading
    }
}
