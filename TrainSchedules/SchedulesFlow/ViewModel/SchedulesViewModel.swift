//
//  SchedulesViewModel.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 04.04.2024.
//

import SwiftUI

final class SchedulesViewModel: ObservableObject {
    
    // MARK: - Properties

    @Published var state = AppState.success
    
    @Published var cities: [City]
    
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
        cities: [City]
    ) {
        self.cities = cities
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
