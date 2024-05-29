//
//  StoriesTabView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 23.05.2024.
//

import SwiftUI
import Combine

struct TabStoriesView: View {
    
    // MARK: - Properties
    
    let storiesForOneUser: [Story]
    
    private let configuration: TimerConfiguration
    private var currentStory: Story {
        storiesForOneUser[currentStoryIndex]
    }
    private var currentStoryIndex: Int {
        Int(progress * CGFloat(storiesForOneUser.count))
    }
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    
    let actionForFinishStories: () -> ()
    let actionForCloseButton: () -> ()
    
    // MARK: - Init
    
    init(storiesForOneUser: [Story],
         actionForFinishStories: @escaping () -> (),
         actionForCloseButton: @escaping () -> ()
    ) {
        self.storiesForOneUser = storiesForOneUser
        configuration = TimerConfiguration(storiesCount: storiesForOneUser.count)
        timer = Self.createTimer(configuration: configuration)
        self.actionForFinishStories = actionForFinishStories
        self.actionForCloseButton = actionForCloseButton
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: currentStory)
            ProgressBar(numberOfSections: storiesForOneUser.count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            CloseButton(action: {
                actionForCloseButton()
            }
            )
            .padding(.top, 57)
            .padding(.trailing, 12)
        }
        .onAppear {
            timer = Self.createTimer(configuration: configuration)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) { _ in
            timerTick()
        }
        .onTapGesture {
            if storiesForOneUser.count > 1 && currentStoryIndex < storiesForOneUser.count - 1 {
                nextStory()
                resetTimer()
            }
        }
    }
}

extension TabStoriesView {
    
   private func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
            actionForFinishStories()
        }
        withAnimation {
            progress = nextProgress
        }
    }
    
    private func nextStory() {
        let storiesCount = storiesForOneUser.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : 0
        withAnimation {
            progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    private static func createTimer(
        configuration: TimerConfiguration
    ) -> Timer.TimerPublisher {
        Timer.publish(
            every: configuration.timerTickInternal,
            on: .main,
            in: .common
        )
    }
}

// MARK: - Preview

#Preview {
    TabStoriesView(
        storiesForOneUser: [
            Story(
                image: "4",
                title: "Test4 Test4 Test4 Test4 Test Test Test Test",
                subTitle: "Test Test Test Test Test Test Test Test"
            ),
            Story(
                image: "3",
                title: "Test3 Test3 Test3 Test3 Test Test",
                subTitle: "Test Test Test Test Test Test Test Test"
            )
        ],
        actionForFinishStories: {},
        actionForCloseButton: {})
}

