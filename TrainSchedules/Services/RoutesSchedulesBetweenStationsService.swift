import OpenAPIRuntime
import OpenAPIURLSession
import SwiftUI

typealias Routes = Components.Schemas.Routes

protocol RoutesSchedulesBetweenStationsServiceProtocol {
    
    func getRoutesSchedulesBetweenStations(
    from: String,
    to: String,
    date: String,
    limit: Int
  ) async throws -> Routes
}

final class RoutesSchedulesBetweenStationsService: 
    RoutesSchedulesBetweenStationsServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
      self.client = client
      self.apikey = apikey
    }
    
    func getRoutesSchedulesBetweenStations(
        from: String,
        to: String,
        date: String,
        limit: Int) async throws -> Routes {
            let response = try await client.getRoutesSchedulesBetweenStations(
                query: .init(
                    apikey: apikey,
                    from: from,
                    to: to,
                    date: date,
                    limit: limit
                )
            )
        return try response.ok.body.json
    }
}
