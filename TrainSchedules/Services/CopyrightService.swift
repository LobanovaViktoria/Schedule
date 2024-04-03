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
    
    private let client: Client

    init(client: Client) {
        self.client = client
    }
    
    func getCopyright(format: Operations.getCopyright.Input.Query.formatPayload) async throws -> Copyright {
        let response = try await client.getCopyright(
            query: .init(
                format: format
            )
        )
        return try response.ok.body.json
    }
}


