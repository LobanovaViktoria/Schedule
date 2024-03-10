//
//  CustomButton.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 10.03.2024.
//

import SwiftUI

struct CustomButton: View {
    
    //MARK: - Properties
    
    let title: String
    let action: () -> Void
    
    //MARK: - Init
    
    init(
        title: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
    }
    
    //MARK: - View
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.blue)
                    .frame(
                        width: UIScreen.main.bounds.width * 0.9,
                        height: UIScreen.main.bounds.height * 0.06
                    )
                    .cornerRadius(15)
                
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.white)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    CustomButton(title: "Button") {
    }
}
