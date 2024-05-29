//
//  CloseButtonView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 23.05.2024.
//

import SwiftUI

struct CloseButton: View {
    
    // MARK: - Properties
    
    let action: () -> Void

    // MARK: - Body
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
           Image("closeButton")
        })
    }
}

// MARK: - Preview

#Preview {
    CloseButton(action: {})
}
