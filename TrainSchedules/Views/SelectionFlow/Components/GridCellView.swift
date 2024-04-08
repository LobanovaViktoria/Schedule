//
//  GridCellView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 04.04.2024.
//

import SwiftUI

struct GridCellView: View {
    
    // MARK: - Properties
    
    private let width: Double = 92
    private let height: Double = 140
    private let widthText: Double = 76
    private let heightText: Double = 45
    let story: Story
    let isNew: Bool
    
    var body: some View {
        ZStack {
            Image(story.images.first ?? "")
                .resizable()
                .frame(
                    width: isNew ? width - 4 : width,
                    height: height
                )
                .opacity(isNew ? 1 : 0.5)
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            Color.blueUniversal,
                            lineWidth: isNew ? 4 : 0
                        )
                )
            VStack {
                Text(story.title)
                    .frame(
                        width: widthText,
                        height: heightText
                    )
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .font(.system(size: 12))
                    .foregroundStyle(
                        Color.whiteUniversal
                    )
                    .padding(.bottom, 12)
                    .padding(.top, 83)
            }
        }
    }
}

    // MARK: - Preview

#Preview {
    ZStack {
        Color.whiteUniversal
        GridCellView(
            story: Story(
                images: ["2", "21", "22"],
                title: "Test Test Test Test Test ", 
                subTitle: "Test Test Test Test Test Test Test Test"
            ),
            isNew: false
        )
    }
}
