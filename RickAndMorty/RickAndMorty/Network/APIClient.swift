//
//  APIClient.swift
//  RickAndMorty
//
//  Created by David López on 22/10/23.
//

import Foundation

public typealias JSON = [String: Any]

class Assembly {
    
    static let client = APIClient(httpClient: Edge(with: Constants.baseURL))
    
    class var characterService: CharactersService {
        return CharactersService(client: client)
    }
}

final class Edge {
    
    private let session: Session
    
    public convenience init(with baseURL: String) {
        guard let url = URL(string: baseURL) else { fatalError() }
        let session = Session(with: url)
        self.init(with: session)
    }
    
    init(with session: Session) {
        self.session = session
    }
    
    public func request<T: Task>(_ task: T) async throws -> Response {
        let url = session.request(with: task)
        let request = Request(request: url, session: session)
        let response = try await request.execute()
        
        do {
            let response = try process(httpResponse: response, with: request)
            return response
            
        } catch let error {
            throw error
        }
    }
    
    private func process(httpResponse response: HTTPResponse, with request: Request) throws -> Response {
        
        let httpResponse = Response(with: request, response: response.response, data: response.data)
        
        if 200 ..< 300 ~= httpResponse.status! {
            return httpResponse
            
        } else {
            let error = HTTPError(status: httpResponse.status, message: nil)
            throw error
        }
    }
}

final class APIClient {
    
    private let httpClient: Edge
    
    init(httpClient: Edge) {
        self.httpClient = httpClient
    }
    
    func requestCodableAsyncAwait<T: Task>(_ task: T) async throws -> Response {
        let data = try await httpClient.request(task)
        return data
    }
}
