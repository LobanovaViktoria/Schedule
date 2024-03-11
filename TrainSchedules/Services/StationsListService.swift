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
        let response = try await client.getStationsList(query: .init(apikey: apikey))
        let httpBody = try response.ok.body.html
                let data = try await Data(collecting: httpBody, upTo: 100 * 1024 * 1024)
                let stationList = try JSONDecoder().decode(StationsList.self, from: data)
//                 решение покрасивее
//                  let stationList = try await JSONDecoder().decode(from: httpBody, to: StationsList.self)
                return stationList
    }
}

extension  JSONDecoder {
    func decode<T: Decodable>(from httpBody: HTTPBody, to type: T.Type, upTo maxBytes: Int = 100 * 1024 * 1024) async throws -> T {
        let data = try await Data(collecting: httpBody, upTo: maxBytes)
        return try self.decode(T.self, from: data)
    }
}
