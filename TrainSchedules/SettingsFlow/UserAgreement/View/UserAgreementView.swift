//
//  UserAgreementView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 16.04.2024.
//

import SwiftUI
import WebKit

private let PRIVACY = "https://yandex.ru/legal/practicum_offer/"

struct WebView: UIViewRepresentable {
    
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}


struct UserAgreementView: View {
    
    // MARK: Properties
    
    @EnvironmentObject var coordinator: BaseCoordinator
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = UserAgreementViewModel()
    
    // MARK: Body
    
    var body: some View {
        switch viewModel.state {
        case .failed(let error):
            ErrorView(error: error)
        case .success:
            successView
        }
    }
}

// MARK: - Extension

extension UserAgreementView {
    private var successView: some View {
        ZStack {
            Color.white100Black30
            
            VStack {
                CustomNavBar(
                    actionForLeftButton: {
                        dismiss()
                    },
                    title: "Пользовательское соглашение"
                )
                
                if let url = URL(string: PRIVACY) {
                    WebView(url: url)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

// MARK: Preview

#Preview {
    UserAgreementView()
}
