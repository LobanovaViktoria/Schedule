//
//  SettingsView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 03.04.2024.
//

import SwiftUI

private let PRIVACY = "https://yandex.ru/legal/practicum_offer/"

struct SettingsView: View {
    
    // MARK: Properties
    @Environment(\.openURL) var openURL
    @StateObject var viewModel = SettingsViewModel()
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            Color.white100Black30
            
            VStack {
                HStack {
                    Text("Тёмная тема")
                        .foregroundStyle(Color.black100White100)
                        .font(.system(size: 17))
                    Spacer()
                    Toggle("", isOn: $viewModel.isDark)
                        .onChange(of: viewModel.isDark) {newValue in
                            newValue == true
                            ? viewModel.upDateUserDefaults(newValue: AppTheme.dark.rawValue)
                            : viewModel.upDateUserDefaults(newValue: AppTheme.light.rawValue)
                        }
                        .toggleStyle(
                            CustomToggleStyle(
                                colorIsOn: Color.blueUniversal,
                                colorIsOff: Color.grayUniversal
                            )
                        )
                       
                        .tint(Color.blueUniversal)
                        .frame(width: 51)
                }
                .padding(.horizontal, 16)
                
                SelectionCell(
                    action: {
                        if let url = URL(string: PRIVACY)  {
                            openURL(url)
                        }
                    },
                    title: "Пользовательское соглашение"
                )
                
                Spacer()
                
                VStack(spacing: 16) {
                    Text("Приложение использует API «Яндекс.Расписания»")
                        .foregroundStyle(Color.black100White100)
                        .font(.system(size: 12))
                    Text("Версия 1.0 (beta)")
                        .foregroundStyle(Color.black100White100)
                        .font(.system(size: 12))
                }
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 24)
        }
        .preferredColorScheme(
            UserDefaults.standard.string(forKey: appTheme) == nil
            ? .none
            : UserDefaults.standard.string(forKey: appTheme) == AppTheme.dark.rawValue
                ? .dark
                : .light
        )
    }
}

// MARK: Preview

#Preview {
    ZStack {
        Color.whiteUniversal
        SettingsView()
    }
}
