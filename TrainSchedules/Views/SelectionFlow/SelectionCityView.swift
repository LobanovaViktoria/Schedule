//
//  SelectionView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 04.04.2024.
//

import SwiftUI

// MARK: - Enum

enum TypeOfFromTo {
    case from
    case to
}

struct SelectionCityView: View {
    
    // MARK: - Properties
    
    var typeOfFromTo: TypeOfFromTo
    
    @State private var searchString = ""
    @State private var isPresentingStationFrom = false
    @State private var isPresentingStationTo = false
    @State private var selectedCity: City? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: SchedulesViewModel
    
    var searchResultCity: [City] {
        if searchString.isEmpty {
            return viewModel.cities
        } else {
            return viewModel.cities.filter {
                $0.name.lowercased().contains(searchString.lowercased())
            }
        }
    }
    
    init(typeOfFromTo: TypeOfFromTo, searchString: String = "", isPresentingStationFrom: Bool = false, isPresentingStationTo: Bool = false, viewModel: SchedulesViewModel) {
        self.typeOfFromTo = typeOfFromTo
        self.searchString = searchString
        self.isPresentingStationFrom = isPresentingStationFrom
        self.isPresentingStationTo = isPresentingStationTo
        self.viewModel = viewModel
        print("init SelectionCity")
    }
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            if searchResultCity == [] {
                Text("Город не найден")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.black100White100)
            }
        
        VStack {
            CustomNavBar(
                actionForLeftButton: {
                    presentationMode.wrappedValue.dismiss()
                    
                },
                title: "Выбор города"
            )
            .padding(.top, 11)
            
            SearchBar(searchText: $searchString)
            
            LazyVStack {
                
                switch typeOfFromTo {
                    
                case .from:
                    
                    ForEach(searchResultCity) { city in
                        SelectionCell(
                            action: {
                                viewModel.selectedCityFrom = city
                                isPresentingStationFrom = true
                            },
                            title: city.name
                        )
                        .fullScreenCover(
                            isPresented: $isPresentingStationFrom) {
                                SelectionStationView(
                                    typeOfFromTo: .from,
                                    viewModel: viewModel
                                )
                            }
                    }
                case .to:
                    
                    ForEach(searchResultCity) { city in
                        SelectionCell(
                            action: {
                                viewModel.selectedCityTo = city
                                isPresentingStationTo = true
                            },
                            title: city.name
                        )
                        .fullScreenCover(
                            isPresented: $isPresentingStationTo) {
                                SelectionStationView(
                                    typeOfFromTo: .to,
                                    viewModel: viewModel
                                )
                            }
                    }
                }
                
                
            }
            Spacer()
        }
                .navigationBarBackButtonHidden()
        }
    }
}
