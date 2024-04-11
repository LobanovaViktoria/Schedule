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
    let width: CGFloat
    let isRedDot: Bool
    
    //MARK: - Init
    
    init(
        title: String,
        width: CGFloat,
        isRedDot: Bool
    ) {
        self.title = title
        self.width = width
        self.isRedDot = isRedDot
    }
    
    //MARK: - View
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color.blueUniversal)
            .frame(
                width: width,
                height: 60
            )
            .cornerRadius(15)
            .overlay {
                HStack {
                    Text(title)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color.whiteUniversal)
                    if isRedDot {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.redUniversal)
                            .frame(
                                width: 8,
                                height: 8
                            )
                    }
                }
            }
    }
}

#Preview {
    CustomButton(
        title: "Button",
        width: 300, 
        isRedDot: true
    )
}
