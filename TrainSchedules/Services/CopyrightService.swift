import OpenAPIRuntime
import OpenAPIURLSession
import SwiftUI

typealias Copyright = Components.Schemas.Copyright

protocol CopyrightServiceProtocol {
    
    func getCopyright(
        format: Operations.getCopyright.Input.Query.formatPayload
    ) async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    
    func getCopyright(format: Operations.getCopyright.Input.Query.formatPayload) async throws -> Copyright {
        let response = try await client.getCopyright(
            query: .init(
                apikey: apikey,
                format: format
            ))
        return try response.ok.body.json
    }
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
}


