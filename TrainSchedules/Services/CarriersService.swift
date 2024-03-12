import OpenAPIRuntime
import OpenAPIURLSession
import SwiftUI

typealias Carriers = Components.Schemas.InfoAboutCarrier

protocol CarriersServiceProtocol {
    
    func getInfoAboutCarrier(
        code: String,
        system: Operations.getInfoAboutCarrier.Input.Query.systemPayload
    ) async throws -> Carriers
}

final class CarriersService: CarriersServiceProtocol {
    
    private let client: Client
  
    init(client: Client, apikey: String) {
        self.client = client
    }
    
    func getInfoAboutCarrier(
        code: String,
        system: Operations.getInfoAboutCarrier.Input.Query.systemPayload = .yandex
    ) async throws -> Carriers {
        
        let response = try await client.getInfoAboutCarrier(
            query: .init(
                code: code,
                system: system
            )
        )
        return try response.ok.body.json
    }
}
