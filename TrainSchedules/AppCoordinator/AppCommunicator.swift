//
//  AppCommunicator.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 12.04.2024.
//

import Foundation
import SwiftUI

final class BaseCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var presentSheetItem: DestinationFlowPage?
    @Published var fullCoverItem: DestinationFlowPage?
    
    func gotoRoot() {
        path.removeLast(path.count)
    }
    
    func removeLast() {
        path.removeLast()
    }
}

protocol SchedulesNavigator {
    func selectingCityFrom()
    func selectingStationFrom()
    func selectingCityTo()
    func selectingStationTo()
    func listOfCarriers()
    func filters()
    func carrierDetail()
}

extension BaseCoordinator: SchedulesNavigator {
    
    func selectingCityFrom() {
        fullCoverItem = .selectingCityFrom
    }
    
    func selectingStationFrom() {
        fullCoverItem = .selectingStationFrom
    }
    
    func selectingCityTo() {
        fullCoverItem = .selectingCityTo
    }
    
    func selectingStationTo() {
        fullCoverItem = .selectingStationTo
    }
    
    func listOfCarriers() {
        path.append(DestinationFlowPage.listOfCarriers)
    }
    
    func filters() {
        path.append(DestinationFlowPage.filters)
    }
    
    func carrierDetail() {
        path.append(DestinationFlowPage.carrierDetail)
    }
}

enum DestinationFlowPage: Hashable, Identifiable {
    static func == (lhs: DestinationFlowPage, rhs: DestinationFlowPage) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    case tabBar
    case selectingCityFrom
    case selectingStationFrom
    case selectingCityTo
    case selectingStationTo
    case listOfCarriers
    case filters
    case carrierDetail
    
    var id: String {
        String(describing: self)
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .tabBar:
            hasher.combine("tabBar")
        case .selectingCityFrom:
            hasher.combine("selectingCityFrom")
        case .selectingStationFrom:
            hasher.combine("selectingStationFrom")
        case .selectingCityTo:
            hasher.combine("selectingCityTo")
        case .selectingStationTo:
            hasher.combine("selectingStationTo")
        case .listOfCarriers:
            hasher.combine("listOfCarriers")
        case .filters:
            hasher.combine("filters")
        case .carrierDetail:
            hasher.combine("carrierDetail")
        }
    }
}

protocol AnyDataModel {
    var data: Any? { get set }
    var index: Int? { get set }
    var id: String? { get set }
}

