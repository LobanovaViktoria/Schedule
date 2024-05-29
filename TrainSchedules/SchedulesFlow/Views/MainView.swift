//
//  StationSelectionView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 03.04.2024.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    @EnvironmentObject var coordinator: BaseCoordinator
    @EnvironmentObject var viewModel: SchedulesViewModel
    @EnvironmentObject var storiesViewModel: StoriesViewModel
    
    @State var from: String = "Откуда"
    @State var to: String = "Куда"
   
    private let rows = [GridItem()]
    
    // MARK: - Body
    
    var body: some View {
        switch viewModel.state {
        case .failed(let error):
            ErrorView(error: error)
        case .success:
            successView
        }
    }
}

// MARK: - Extension MainView

extension MainView {
    
    private var successView: some View {
        ZStack {
            
            Color.white100Black30
            
            ScrollView {
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
            .scrollIndicators(.hidden)
        }
        .toolbar(.hidden, for: .navigationBar)
        .environmentObject(storiesViewModel)
    }
    
    private var scrollWithStories: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, alignment: .center, spacing: 12) {
                ForEach(storiesViewModel.stories.indices, id: \.self ) { index in
                    GridCellView(story: storiesViewModel.stories[index].items[0], isItShown: storiesViewModel.stories[index].isItShown)
                        .onTapGesture {
                            storiesViewModel.selectedStoriesIndex = index
                            coordinator.stories()
                        }
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
            .frame(height: 128)
    }
    
    private var whiteRectangle: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.whiteUniversal)
            .frame(height: 96)
            .overlay(
                VStack(alignment: .leading, spacing: 28) {
                    selectionCityFromButton
                    selectingCityToButton
                }
            )
    }
    
    private var selectionCityFromButton: some View {
        
        Button {
            coordinator.selectingCityFrom()
        } label: {
            Text(viewModel.selectedStationFrom?.name == nil
                 ? from
                 : viewModel.selectedStationFrom?.name ?? ""
            )
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .font(.system(size: 17))
            .foregroundStyle(
                viewModel.selectedStationFrom?.name == nil
                ? Color.grayUniversal
                : Color.blackUniversal
            )
            .lineLimit(1)
            .padding(.leading, 16)
            .padding(.trailing, 13)
        }
    }
    
    private var selectingCityToButton: some View {
        
        Button {
            coordinator.selectingCityTo()
        } label: {
            Text(viewModel.selectedStationTo?.name == nil
                 ? to
                 : viewModel.selectedStationTo?.name ?? ""
            )
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .font(.system(size: 17))
            .foregroundStyle(
                viewModel.selectedStationTo?.name == nil
                ? Color.grayUniversal
                : Color.blackUniversal
            )
            .lineLimit(1)
            .padding(.leading, 16)
            .padding(.trailing, 13)
        }
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
        Button {
            coordinator.listOfCarriers()
        } label: {
            CustomButton(
                title: "Найти",
                isRedDot: false
            )
            .padding(.horizontal, 112)
        }
    }
}

// MARK: - Preview

#Preview {
    MainView()
        .environmentObject(SchedulesViewModel(cities: []))
}
