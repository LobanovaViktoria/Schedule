//
//  StoriesTabView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 23.05.2024.
//

import SwiftUI

struct StoriesTabView: View {
    let stories: Stories
    @Binding var currentStoryIndex: Int

    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(stories.items) { story in
                StoryView(story: story)
                    .onTapGesture {
                        didTapStory()
                    }
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }

    func didTapStory() {
        currentStoryIndex = min(currentStoryIndex + 1, stories.items.count - 1)
    }
}


#Preview {
    StoriesTabView(
        stories:
            Stories(
                items: [
                    Story(
                        image: "2",
                        title: "Test Test",
                        subTitle: "Test Test Test Test Test Test Test Test"
                    ),
                    Story(
                        image: "21",
                        title: "Test Test",
                        subTitle: "Test Test Test Test Test Test Test Test"
                    )
                ]
            ),
        currentStoryIndex: .constant(0)
    )
}
