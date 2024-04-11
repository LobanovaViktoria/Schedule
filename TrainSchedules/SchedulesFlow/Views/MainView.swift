//
//  StationSelectionView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 03.04.2024.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel = SchedulesViewModel(stories: [], cities: [])
    
    @State var from: String = "Откуда"
    @State var to: String = "Куда"
    
    @State private var isPresentingCityFrom = false
    @State private var isPresentingCityTo = false
    @State private var isShowingStory = false
    @State private var selectedStory: Story?
    
    private let rows = [GridItem()]
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack {
                
                Color.white100Black30
                
                VStack {
                    scrollWithStories
                        .padding(.top, 24)
                    fromTo
                        .frame(height: 128)
                        .padding(.top, 44)
                    
                    if viewModel.selectedStationTo != nil
                        && viewModel.selectedStationFrom != nil {
                        
                        searchButton
                            .onTapGesture {
                                print("Показать список")
                            }
                            .padding(.top, 16)
                    }
                    Spacer()
                       
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

// MARK: - Extension MainView

extension MainView {
    
    private var scrollWithStories: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, alignment: .center, spacing: 12) {
                ForEach(viewModel.stories) { story in
                    GridCellView(story: story, isNew: true)
                        .onTapGesture {
                            viewModel.selectedStory = story
                            isShowingStory = true
                        }
                        .fullScreenCover(
                            isPresented: $isShowingStory,
                            content: {
                                if let story = viewModel.selectedStory {
                                    StoriesView(story: story).environmentObject(viewModel)
                                }
                            }
                        )
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 144)
            .frame(maxWidth: .infinity)
        }
    }
    
    private var fromTo: some View {
        ZStack {
            blueRectangle
                .padding(.horizontal, 16)
            
            HStack {
                whiteRectangle
                    .padding(.leading, 32)
                replaceView
                    .padding(.trailing, 32)
            }
        }
    }
    
    private var blueRectangle: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.blueUniversal)
            .frame(
                width: UIScreen.main.bounds.width - 32,
                height: 128
            )
    }
    
    private var whiteRectangle: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.whiteUniversal)
            .frame(
                width: UIScreen.main.bounds.width - 100,
                height: 96
            )
            .overlay(
                VStack(alignment: .leading, spacing: 28) {
                    Button {
                        isPresentingCityFrom = true
                        viewModel.path.append("CityFrom")
                    } label: {
                        Text(viewModel.selectedStationFrom?.name == nil
                             ? from
                             : viewModel.selectedStationFrom?.name ?? ""
                        )
                        .frame(
                            width: UIScreen.main.bounds.width - 132,
                            alignment: .leading
                        )
                        .font(.system(size: 17))
                        .foregroundStyle(
                            viewModel.selectedStationFrom?.name == nil
                            ? Color.grayUniversal
                            : Color.blackUniversal
                        )
                        .lineLimit(1)
                    }
                    .fullScreenCover(
                        isPresented: $isPresentingCityFrom) {
                            SelectionCityView(
                                typeOfFromTo: .from, 
                                showingSelectionCity: $isPresentingCityFrom,
                                viewModel: viewModel
                            )
                        }
                    
                    Button {
                        isPresentingCityTo = true
                        viewModel.path.append("CityTo")
                    } label: {
                        Text(viewModel.selectedStationTo?.name == nil
                             ? to
                             : viewModel.selectedStationTo?.name ?? ""
                        )
                        .frame(
                            width: UIScreen.main.bounds.width - 132,
                            alignment: .leading
                        )
                        .font(.system(size: 17))
                        .foregroundStyle(
                            viewModel.selectedStationTo?.name == nil
                            ? Color.grayUniversal
                            : Color.blackUniversal
                        )
                        .lineLimit(1)
                    }
                    .fullScreenCover(
                        isPresented: $isPresentingCityTo) {
                            SelectionCityView(
                                typeOfFromTo: .to, 
                                showingSelectionCity: $isPresentingCityTo,
                                viewModel: viewModel
                            )
                        }
                }
            )
    }
    
    private var replaceView: some View {
        Circle()
            .fill(Color.whiteUniversal)
            .frame(width: 36)
            .overlay(
                Image(systemName: "arrow.2.squarepath")
                    .foregroundStyle(Color.blueUniversal)
                    .onTapGesture {
                        viewModel.replaceStations()
                    }
            )
    }
    
    private var searchButton: some View {
        NavigationLink {
            ListOfCarriersView(viewModel: viewModel)
        } label: {
            CustomButton(
                title: "Найти",
                width: 150,
                isRedDot: false
            )
        }
    }
}

// MARK: - Preview

#Preview {
    MainView()
}
