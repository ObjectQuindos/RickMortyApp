//
//  NetworkElements.swift
//  RickAndMorty
//
//  Created by David López on 22/10/23.
//

import Foundation

typealias HTTPResponse = (data: Data?, response: URLResponse?, error: Error?)

protocol Task {
    var method: String { get }
    var path: String { get }
    var headers: [String : String] { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Task {
    
    func request(with baseURL: URL) -> URLRequest {
        let url = setURL(with: baseURL)
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
    
    private func setURL(with baseURL: URL) -> URL {
        let url = baseURL.appendingPathComponent(path)
        
        if queryItems != nil {
            var urlComponents = URLComponents(string: url.absoluteString)
            urlComponents?.queryItems = queryItems
            let url = urlComponents?.url
            return url ?? baseURL.appendingPathComponent(path)
        }
        
        return url
    }
}

struct Response {
    let request: Request
    let status: Int?
    let header: [String : String]?
    let data: Data?
    
    init(with request: Request, response: URLResponse?, data: Data?) {
        
        let response = response as? HTTPURLResponse
        let header = response?.allHeaderFields as? [String : String]
        
        self.status = response?.statusCode
        self.request = request
        self.header = header
        self.data = data
    }
}

final class Request {
    
    private let request: URLRequest
    private weak var session: Session?
    private var task: URLSessionTask?
    
    init(request: URLRequest, session: Session) {
        self.request = request
        self.session = session
    }
    
    func execute() async throws -> HTTPResponse {
        
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<HTTPResponse, Error>) in
            
            task = session?.task(with: request, completion: { taskResponse in
                
                if let error = taskResponse.error {
                    continuation.resume(throwing: error)
                    
                } else {
                    continuation.resume(returning: taskResponse)
                }
            })
            
            task?.resume()
        })
    }
}

final class Session {
    
    private let baseURL: URL
    private let session: URLSession
    
    init(with url: URL, session: URLSession) {
        self.baseURL = url
        self.session = session
    }
    
    convenience init(with url: URL) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        self.init(with: url, session: session)
    }
    
    func request<T: Task>(with task: T) -> URLRequest {
        return task.request(with: baseURL)
    }
    
    func task(with request: URLRequest, completion: @escaping (HTTPResponse) -> Void) -> URLSessionDataTask {
        return session.dataTask(with: request) { data, response, error in
            completion((data: data, response: response, error: error))
        }
    }
}
