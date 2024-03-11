//
//  ContentView.swift
//  TrainSchedules
//
//  Created by Viktoria Lobanova on 08.03.2024.
//

import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    let client: Client
    let apiKey = "e7010142-c5c6-4200-b85c-deb1ffb7dedb"
    
    init() {
        self.client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport())
    }
    
    var body: some View {
        
        ScrollView {
            
            Text("API Яндекс Расписаний")
                .font(.title)
                .padding(.vertical, 30)
            
            CustomButton(
                title: "Расписание рейсов между станциями") {
                    routes()
                }
            
            CustomButton(
                title: "Расписание рейсов по станции") {
                    getScheduleForStation()
                }
            
            CustomButton(
                title: "Список станций следования") {
                    getThread()
                }
            
            CustomButton(
                title: "Список ближайших станций") {
                    stations()
                }
            
            CustomButton(
                title: "Ближайший город") {
                    getNearestSettlement()
                }
            
            CustomButton(
                title: "Информация о перевозчике") {
                    getCarriers()
                }
            
            CustomButton(
                title: "Список всех доступных станций") {
                    getStationList()
                }
            
            CustomButton(
                title: "Копирайт Яндекс Расписаний") {
                    getCopyright()
                }
        }
    }
}

extension ContentView {
    
    private func getCopyright() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = CopyrightService(
            client: client,
            apikey: self.apiKey
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
            transport: URLSessionTransport()
        )
        
        let service = StationsListService(
            client: client,
            apikey: self.apiKey
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
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apikey: self.apiKey
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
            transport: URLSessionTransport()
        )
        
        let service = SingleThreadService(
            client: client,
            apikey: self.apiKey)
        
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
            transport: URLSessionTransport()
        )
        
        let service = RoutesScheduleForStationService(
            client: client,
            apikey: self.apiKey)
        
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
            transport: URLSessionTransport()
        )
        
        let service = RoutesSchedulesBetweenStationsService(
            client: client,
            apikey: self.apiKey
        )
        Task {
            do {
                let routes = try await service.getRoutesSchedulesBetweenStations(
                    from: "s2014001",
                    to: "s9600816",
                    date: "2024-03-03",
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
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
            client: client,
            apikey: self.apiKey
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
    ContentView()
}
