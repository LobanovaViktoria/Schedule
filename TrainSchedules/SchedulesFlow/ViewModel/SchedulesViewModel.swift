//
//  SchedulesViewModel.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 04.04.2024.
//

import Foundation
import SwiftUI

class SchedulesViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var path = NavigationPath()
    @Published var stories: [Story]
    @Published var cities: [City]
    
    @Published var selectedCityFrom: City?
    @Published var selectedCityTo: City?
    @Published var selectedStationFrom: Station?
    @Published var selectedStationTo: Station?
    
    @Published var titleForListOfCarriers: String = ""
    
    @Published var selectedTimeFilter: [String] = []
    @Published var selectedTransferFilter: [String] = []
    @Published var isApplyFilters: Bool = false
    @Published var selectedStory: Story?
    
    // MARK: - Init
    
    init(
        stories: [Story],
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
            images: ["1"],
            title: "Test Test",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story2 = Story(
            images: ["2", "21", "22"],
            title: "Test Test Test Test",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story3 = Story(
            images: ["3"],
            title: "Test Test Test Test Test Test",
            subTitle: "Test Test Test Test Test Test Test Test"
        )
        let story4 = Story(
            images: ["4"],
            title: "Test Test Test Test Test Test Test Test",
            subTitle: "Test Test Test Test Test Test Test Test")
        
        self.stories = [story1, story2, story3, story4]
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
