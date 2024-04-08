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
          Spacer()
                .navigationBarBackButtonHidden()
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
