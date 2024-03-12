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
    
    init(client: Client) {
        self.client = client
    }
    
    func getThread(
        uid: String
    ) async throws -> SingleThread {
        
        let response = try await client.getThread(
            query: .init(uid: uid)
        )
        return try response.ok.body.json
    }
}
