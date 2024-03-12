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
   
    init(client: Client) {
        self.client = client
    }
    
    func getRoutesScheduleForStation(
        station: String,
        date: String
    ) async throws -> ScheduleForStation {
        let response = try await client.getRoutesScheduleForStation(
            query: .init(
                station: station,
                date: date
            )
        )
        return try response.ok.body.json
    }
}
