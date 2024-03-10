import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleForStation = Components.Schemas.ScheduleForStation

protocol RoutesScheduleForStationServiceProtocol {
    
    func getRoutesScheduleForStation(
        station: String,
        date: String
    ) async throws -> ScheduleForStation
}

final class RoutesScheduleForStationService: 
    RoutesScheduleForStationServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRoutesScheduleForStation(
        station: String,
        date: String
    ) async throws -> ScheduleForStation {
        let response = try await client.getRoutesScheduleForStation(
            query: .init(
                apikey: apikey,
                station: station,
                date: date
            )
        )
        return try response.ok.body.json
    }
}
