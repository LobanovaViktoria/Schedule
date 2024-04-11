//
//  CarrierDetailView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 06.04.2024.
//

import SwiftUI

struct CarrierDetailView: View {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            navBar
            VStack {
                Image("brandIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: 104
                    )
                Text("OAO \"РЖД\"")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.black100White100)
                    .frame(
                        width: UIScreen.main.bounds.width - 32,
                        alignment: .leading
                    )
                    .padding(.bottom, 16)
                VStack(spacing: 24) {
                    InfoCellAboutCarrier(
                        title: "E-mail",
                        subTitle: "lozgkina@yandex.ru"
                    )
                    InfoCellAboutCarrier(
                        title: "Телефон",
                        subTitle: "+7(904)329-34-23"
                    )
                }
            }
            .padding(.horizontal, 16)
            Spacer()
                .navigationBarHidden(true)
        }
    }
}

// MARK: - Extension CarrierDetailView

extension CarrierDetailView {
    
    private var navBar: some View {
        CustomNavBar(
            actionForLeftButton: {
                presentationMode.wrappedValue.dismiss()
            },
            title: "Информация о перевозчике"
        )
        .padding(.top, 11)
    }
}

// MARK: - Preview

#Preview {
    CarrierDetailView()
}
