import OpenAPIRuntime
import OpenAPIURLSession
import SwiftUI

typealias StationsList = Components.Schemas.StationsList

protocol StationsListProtocol {
    
    func getStationsList() async throws -> StationsList
}

final class StationsListService: StationsListProtocol {
    
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getStationsList() async throws -> StationsList {
        let response = try await client.getStationsList()
        let httpBody = try response.ok.body.html
                let data = try await Data(collecting: httpBody, upTo: 100 * 1024 * 1024)
                let stationList = try JSONDecoder().decode(StationsList.self, from: data)
                return stationList
    }
}
