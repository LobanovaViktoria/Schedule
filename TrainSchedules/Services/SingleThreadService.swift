import OpenAPIRuntime
import OpenAPIURLSession

typealias SingleThread = Components.Schemas.SingleThread

protocol SingleThreadServiceProtocol {
    
    func getThread(
        uid: String
    ) async throws -> SingleThread
}

final class SingleThreadService: SingleThreadServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getThread(
        uid: String
    ) async throws -> SingleThread {
        
        let response = try await client.getThread(
            query: .init(
                apikey: apikey,
                uid: uid
            )
        )
        return try response.ok.body.json
    }
}
