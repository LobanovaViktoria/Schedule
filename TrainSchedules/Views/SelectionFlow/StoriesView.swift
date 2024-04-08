//
//  StoriesView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 06.04.2024.
//

import SwiftUI

struct StoriesView: View {
    
    // MARK: - Properties
    let story: Story
    
    var body: some View {
        ZStack{
            Image(story.images.first ?? "")
                .resizable()
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height * 0.8
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 40)
                )
            VStack {
                Text(story.title)
                Text(story.subTitle)
            }
        }
    }
}

#Preview {
    StoriesView(
        story: Story(
        images: ["1"],
        title: "Test Test",
        subTitle: "Test Test Test Test Test Test Test Test"
    )
    )
}
