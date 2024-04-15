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
    @Published var isDark: Bool = false
   
    init() {
        self.isDark = UserDefaults.standard.string(forKey: appTheme) == nil
        ? false
        : UserDefaults.standard.string(forKey: appTheme) == AppTheme.dark.rawValue
            ? true
            : false
    }
    
    func upDateUserDefaults(newValue: String){
        UserDefaults.standard.set(newValue, forKey: appTheme)
    }
}


