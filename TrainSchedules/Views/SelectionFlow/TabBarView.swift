//
//  ContentView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 08.03.2024.
//

import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct TabBarView: View {
    
    private let apiKey = "e7010142-c5c6-4200-b85c-deb1ffb7dedb"
    
    @State private var selectedTab = 0
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.black100White100
        UITabBar.appearance().backgroundColor = UIColor.white100Black30
    }
    
    var body: some View {
        
        VStack {
            
            TabView(selection: $selectedTab) {
                ZStack {
                    VStack(spacing: 0) {
                        MainView()
                        dividerForTabBar
                    }
                }
                .tabItem {
                    Image(systemName: "arrow.up.message.fill")
                }
                .tag(0)
                .edgesIgnoringSafeArea(.top)
                
                ZStack {
                    VStack(spacing: 0) {
                        SettingsView()
                        dividerForTabBar
                    }
                }
                
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
                .tag(1)
                .edgesIgnoringSafeArea(.top)
            }
            .accentColor(Color.black100White100)
        }
    }
}

extension TabBarView {
    
    private var dividerForTabBar: some View {
        Divider()
            .background(Color.black30Black100)
            .frame(height: 1)
    }
    
    private func getCopyright() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [
                AuthenticationMiddleware(authorizationHeaderFieldValue: apiKey)
            ]
        )
        
        let service = CopyrightService(
            client: client
        )
        
        Task {
            do {
                let copy = try await service.getCopyright(format: .json)
                print(copy)
            } catch {
                print("Error fetching copyright: \(error)")
            }
        }
    }
    
    private func getStationList() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [
                AuthenticationMiddleware(authorizationHeaderFieldValue: apiKey)
            ]
        )
        
        let service = StationsListService(
            client: client
        )
        
        Task {
            do {
                let stations = try await service.getStationsList()
                print("All stations: \(stations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    private func getCarriers() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = CarriersService(
            client: client,
            apikey: self.apiKey
        )
        
        Task {
            do {
                let carrier = try await service.getInfoAboutCarrier(
                    code: "112"
                )
                print(carrier)
            } catch {
                print("Error fetching carrier: \(error)")
            }
        }
    }
    
    private func getNearestSettlement() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [
                AuthenticationMiddleware(authorizationHeaderFieldValue: apiKey)
            ]
        )
        
        let service = NearestSettlementService(
            client: client
        )
        
        Task {
            do {
                let stations = try await service.getNearestSettlement(
                    lat: 51.714968,
                    lng: 39.268510
                )
                print(stations)
            } catch {
                print("Error fetching nearest settlement: \(error)")
            }
        }
    }
    
    private func getThread() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [
                AuthenticationMiddleware(authorizationHeaderFieldValue: apiKey)
            ]
        )
        
        let service = SingleThreadService(
            client: client
        )
        
        Task {
            do {
                let routes = try await service.getThread(
                    uid: "382S_0_2"
                )
                print(routes)
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    
    private func getScheduleForStation() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [
                AuthenticationMiddleware(authorizationHeaderFieldValue: apiKey)
            ]
        )
        
        let service = RoutesScheduleForStationService(
            client: client
        )
        
        Task {
            do {
                let routes = try await service.getRoutesScheduleForStation(
                    station: "s2014001",
                    date: "2024-03-03"
                )
                print(routes)
            } catch {
                print("Error fetching schedule for station: \(error)")
            }
        }
    }
    
    private func routes() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [
                AuthenticationMiddleware(authorizationHeaderFieldValue: apiKey)
            ]
        )
        
        let service = RoutesSchedulesBetweenStationsService(
            client: client
        )
        Task {
            do {
                let routes = try await service.getRoutesSchedulesBetweenStations(
                    from: "s2014001",
                    to: "s9600816",
                    date: "2024-04-03",
                    limit: 20)
                print(routes)
            } catch {
                print("Error fetching routes: \(error)")
            }
        }
    }
    
    private func stations() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [
                AuthenticationMiddleware(authorizationHeaderFieldValue: apiKey)
            ]
        )
        
        let service = NearestStationsService(
            client: client
        )
        
        Task {
            do {
                let stations = try await service.getNearestStations(
                    lat: 51.714968,
                    lng: 39.268510,
                    distance: 50
                )
                print(stations)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
}

#Preview {
    TabBarView()
}
