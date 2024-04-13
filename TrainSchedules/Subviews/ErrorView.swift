//
//  ErrorView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 12.04.2024.
//

import SwiftUI

enum ErrorType {
    case noInternet
    case backend
}

struct ErrorView: View {
    
    let error: ErrorType
    
    var body: some View {
        VStack {
            switch error {
            case .noInternet:
                VStack {
                    Image("NoInternet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 223, height: 223)
                    Text("Ошибка сервера")
                        .foregroundStyle(Color.blackUniversal)
                        .font(.system(size: 24).bold())
                }
            case .backend:
                VStack {
                    Image("serverError")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 223, height: 223)
                    Text("Нет интернета")
                        .foregroundStyle(Color.blackUniversal)
                        .font(.system(size: 24).bold())
                }
            }
        
        }
    }
}
