//
//  StoriesView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 23.05.2024.
//

import SwiftUI

struct StoriesView: View {
   
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: SchedulesViewModel
    private var timerConfiguration: TimerConfiguration {
        .init(storiesCount: viewModel.stories.count)
    }
    @State var currentStoryIndex: Int = 0
    @State var currentProgress: CGFloat = 0

    var body: some View {
        switch viewModel.state {
        case .failed(let error):
            ErrorView(error: error)
        case .success:
            successView
        }
    }

    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }

    private func didChangeCurrentProgress(newProgress: CGFloat) {
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
}

// MARK: Extension StoriesView

extension StoriesView {
    private var successView: some View {
        ZStack(alignment: .topTrailing) {
            if let selectedStory = viewModel.selectedStory {
                if #available(iOS 17.0, *) {
                    StoriesTabView(
                        stories: selectedStory,
                        currentStoryIndex: $currentStoryIndex
                    )
                    .onChange(of: currentStoryIndex) { oldValue, newValue in
                        didChangeCurrentIndex(oldIndex: oldValue, newIndex: newValue)
                    }
                } else {
                    // Fallback on earlier versions
                }
                
                if #available(iOS 17.0, *) {
                    StoriesProgressBar(
                        storiesCount: selectedStory.items.count,
                        timerConfiguration: timerConfiguration,
                        currentProgress: $currentProgress
                    )
                    .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
                    .onChange(of: currentProgress) { _, newValue in
                        didChangeCurrentProgress(newProgress: newValue)
                    }
                } else {
                    // Fallback on earlier versions
                }
                closeButton
            }
                
            
        }
    }
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button(action: {
              presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("closeButton")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            )
            .padding(.top, 50)
            .padding(.trailing, 12)
        }
    }
}

// MARK: Preview

#Preview {
    StoriesView()
    .environmentObject(SchedulesViewModel(stories: [], cities: []))
}
