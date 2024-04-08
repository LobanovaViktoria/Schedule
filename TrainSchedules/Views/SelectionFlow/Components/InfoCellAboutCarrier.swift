//
//  InfoCellAboutCarrier.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 08.04.2024.
//

import SwiftUI

struct InfoCellAboutCarrier: View {
    
    // MARK: - Properties
    
    let title: String
    let subTitle: String
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            VStack {
                Text(title)
                    .font(.system(size: 17))
                    .foregroundStyle(Color.black100White100)
                    .frame(
                        width: UIScreen.main.bounds.width - 60,
                        alignment: .leading
                    )
                Text(subTitle)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.blueUniversal)
                    .frame(
                        width: UIScreen.main.bounds.width - 60,
                        alignment: .leading
                    )
            }
            Image(systemName: "checkmark.square.fill")
                .foregroundStyle(Color.black100White100)
        }
    }
}

// MARK: Preview

#Preview {
    InfoCellAboutCarrier(
        title: "title",
        subTitle: "subTitle")
}
