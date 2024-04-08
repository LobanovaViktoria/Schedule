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
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    
    var body: some View {
        ZStack{
            
            background
            
            VStack(spacing: 16) {
                closeButton
                Spacer()
                Text(story.title)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(Color.whiteUniversal)
                    .frame(
                        width: UIScreen.main.bounds.width - 16,
                        height: 120,
                        alignment: .leading
                    )
                Text(story.subTitle)
                    .font(.system(size: 20))
                    .foregroundStyle(Color.whiteUniversal)
                    .frame(
                        width: UIScreen.main.bounds.width - 16,
                        height: 72,
                        alignment: .leading
                    )
                    .padding(.bottom, 40)
            }
        }
        .background(Color.blackUniversal)
        .ignoresSafeArea()
    }
}

// MARK: Extension StoriesView

extension StoriesView {
    
    private var background: some View {
        
        Image(story.images.first ?? "")
            .resizable()
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height * 0.9
            )
            .clipShape(RoundedRectangle(cornerRadius: 40))
    }
    
    private var closeButton: some View {
        
        HStack {
            Spacer()
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                ZStack {
                    Image(systemName: "circle.fill")
                        .foregroundStyle(Color.whiteUniversal)
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.blackUniversal)
                        .tint(Color.red)
                }
            }
            )
            .padding(.top, 60)
            .padding(.trailing, 16)
        }
    }
}

// MARK: - Preview

#Preview {
    StoriesView(
        story: Story(
            images: ["1"],
            title: "Test Test",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
    )
}
