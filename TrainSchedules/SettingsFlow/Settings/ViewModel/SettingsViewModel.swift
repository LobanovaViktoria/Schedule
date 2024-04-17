//
//  SettingsViewModel.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 13.04.2024.
//

import SwiftUI

let appTheme = "appTheme"

enum AppTheme: String {
    case light = "light"
    case dark = "dark"
}

final class SettingsViewModel: ObservableObject {
    
    @AppStorage("isDarkTheme") private var appTheme: String?
    @Published var isDark: Bool = false
    @Published var state = AppState.success
    
    init() {
        self.isDark = appTheme == nil
        ? false
        : appTheme == AppTheme.dark.rawValue
            ? true
            : false
    }
    
    func upDateUserDefaults(newValue: String){
        appTheme = newValue
    }
}


