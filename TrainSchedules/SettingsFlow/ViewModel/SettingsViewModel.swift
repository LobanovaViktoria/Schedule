//
//  SettingsViewModel.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 13.04.2024.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    @Published var isDark: Bool = false
   
    init() {
        self.isDark = UserDefaults.standard.bool(forKey: "isDarkTheme")
    }
    
    func upDateUserDefaults(newValue: Bool){
        UserDefaults.standard.set(newValue, forKey: "isDarkTheme")
    }
}


