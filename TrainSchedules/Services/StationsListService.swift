import OpenAPIRuntime
import OpenAPIURLSession
import SwiftUI

typealias StationsList = Components.Schemas.StationsList

protocol StationsListProtocol {
    
    func getStationsList() async throws -> StationsList
}

final class StationsListService: StationsListProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationsList() async throws -> StationsList {
        
        let response = try await client.getStationsList(
            query: .init(
                apikey: apikey
            ))
        return try response.ok.body.json
    }
}

