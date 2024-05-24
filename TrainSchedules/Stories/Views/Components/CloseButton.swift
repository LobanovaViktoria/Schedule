//
//  CloseButtonView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 23.05.2024.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }, label: {
           Image("closeButton")
        })
    }
}

#Preview {
    CloseButton(action: {})
}
