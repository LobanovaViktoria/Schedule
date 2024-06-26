//
//  ProgressBar.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 23.05.2024.
//

import SwiftUI

struct ProgressBar: View {
    
    // MARK: - Properties
    
    let numberOfSections: Int
    let progress: CGFloat

    // MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(
                    cornerRadius: .progressBarCornerRadius
                )
                    .frame(
                        width: geometry.size.width,
                        height: .progressBarHeight
                    )
                    .foregroundColor(Color.whiteUniversal)

                RoundedRectangle(
                    cornerRadius: .progressBarCornerRadius
                )
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: .progressBarHeight
                    )
                    .foregroundColor(Color.blueUniversal)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

// MARK: - Private structs

private struct MaskView: View {
    let numberOfSections: Int

    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

private struct MaskFragmentView: View {
    var body: some View {
        RoundedRectangle(
            cornerRadius: .progressBarCornerRadius
        )
            .frame(height: .progressBarHeight)
            .foregroundStyle(.white)
    }
}

// MARK: - Preview

#Preview {
    Color.grayUniversal
        .ignoresSafeArea()
        .overlay(
            ProgressBar(
                numberOfSections: 5,
                progress: 0.5
            )
                .padding()
        )
}
