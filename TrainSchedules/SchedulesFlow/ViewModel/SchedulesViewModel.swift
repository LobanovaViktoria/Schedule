//
//  SchedulesViewModel.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 04.04.2024.
//

import Foundation
import SwiftUI

final class SchedulesViewModel: ObservableObject {
    
    // MARK: - Properties

    @Published var state = AppState.success
    
    @Published var stories: [Stories]
    @Published var cities: [City]
    
    @Published var selectedStory: Stories?
    
    @Published var selectedCityFrom: City?
    @Published var selectedCityTo: City?
    @Published var selectedStationFrom: Station?
    @Published var selectedStationTo: Station?
    
    @Published var titleForListOfCarriers: String = ""
    
    @Published var selectedTimeFilter: [String] = []
    @Published var selectedTransferFilter: [String] = []
    @Published var isApplyFilters: Bool = false
    
    // MARK: - Init
    
    init(
        stories: [Stories],
        cities: [City]
    ) {
        self.stories = stories
        self.cities = cities
        getStories()
        getCities()
    }
    
    // MARK: - Methods
    
    func getTitleForListOfCarriers() {
        if let cityFrom = selectedCityFrom,
           let cityTo = selectedCityTo,
           let stationFrom = selectedStationFrom,
           let stationTo = selectedStationTo {
            self.titleForListOfCarriers =  cityFrom.name
            + "("
            + stationFrom.name
            + ") -> "
            + cityTo.name
                 + "("
                 + stationTo.name
                 + ")"
        }
    }
    
    func replaceStations() {
        if selectedStationTo?.name != nil && selectedStationFrom?.name != nil {
            let newStationTo = selectedStationFrom
            selectedStationFrom = selectedStationTo
            selectedStationTo = newStationTo
        }
    }
    
    private func getStories() {
        let story1 = Story(
            image: "1",
            title: "Test1 Test1",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story2 = Story(
            image: "2",
            title: "Test2 Test2 Test2 Test2",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story21 = Story(
            image: "21",
            title: "Test21 Test21 Test21 Test21",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story22 = Story(
            image: "22",
            title: "Test22 Test22 Test22 Test22",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story3 = Story(
            image: "3",
            title: "Test3 Test3 Test3 Test3 Test Test",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story4 = Story(
            image: "4",
            title: "Test4 Test4 Test4 Test4 Test Test Test Test",
            subTitle: "Test Test Test Test Test Test Test Test")
        
        self.stories = [
            Stories(items: [story1]),
            Stories(items: [story2, story21, story22]),
            Stories(items: [story3]),
            Stories(items: [story4])
        ]
    }
    
    private func getCities() {
        let city1 = City(
            name: "City1",
            stations: [
                Station(name: "Station1"),
                Station(name: "Station2"),
                Station(name: "Station3"),
            ]
        )
        let city2 = City(
            name: "City2",
            stations: [
                Station(name: "Station1"),
                Station(name: "Station2"),
                Station(name: "Station3"),
                Station(name: "Station4"),
                Station(name: "Station5"),
            ]
        )
        let city3 = City(
            name: "City3",
            stations: [
                Station(name: "Station1"),
                Station(name: "Station2"),
                Station(name: "Station3"),
                Station(name: "Station4"),
                Station(name: "Station5"),
            ]
        )
        let city4 = City(
            name: "City4",
            stations: [
                Station(name: "Station1"),
                Station(name: "Station2")
            ]
        )
        
        self.cities = [city1, city2, city3, city4]
    }
    
    func updateSelectedTime(time: String) {
        if selectedTimeFilter.contains(time) {
            selectedTimeFilter = selectedTimeFilter.filter {$0 != time}
        } else {
            selectedTimeFilter.append(time)
        }
    }
    
    func updateSelectedTransfer(transfer: String) {
        if selectedTransferFilter.isEmpty {
            selectedTransferFilter.append(transfer)
        } else {
            if selectedTransferFilter.contains(transfer) {
                selectedTransferFilter = []
            } else {
                selectedTransferFilter = []
                selectedTransferFilter.append(transfer)
            }
        }
    }
}
