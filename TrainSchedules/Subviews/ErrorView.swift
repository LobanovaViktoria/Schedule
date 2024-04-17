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
                        Spacer()
                        Image("NoInternet")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 223, height: 223)
                        Text("Ошибка сервера")
                            .foregroundStyle(Color.black100White100)
                            .font(.system(size: 24).bold())
                        Spacer()
                    }
                case .backend:
                    VStack {
                        Spacer()
                        Image("serverError")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 223, height: 223)
                        Text("Нет интернета")
                            .foregroundStyle(Color.black100White100)
                            .font(.system(size: 24).bold())
                        Spacer()
                    }
            }
        }
            
    }
}
