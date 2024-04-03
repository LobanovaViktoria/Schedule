import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestSettlement = Components.Schemas.NearestSettlement

protocol NearestSettlementsServiceProtocol {
    
    func getNearestSettlement(
        lat: Double,
        lng: Double
    ) async throws -> NearestSettlement
}

final class NearestSettlementService: NearestSettlementsServiceProtocol {
    
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getNearestSettlement(
        lat: Double,
        lng: Double
    ) async throws -> NearestSettlement {
        
        let response = try await client.getNearestSettlement(
            query: .init(
                lat: lat,
                lng: lng
            )
        )
        return try response.ok.body.json
    }
}
