//
//  NetworkingManager.swift
//  CryptoMania
//
//  Created by Julio Collado on 3/11/21.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL, statusCode: Int)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url, statusCode: let code):
                return "[❌] Bad response from \(url.absoluteString), Status code: \(code)"
            case .unknown:
                return "[❌] Unknown error occurred"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleURLResponse(output: $0)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: output.response.url!, statusCode: (output.response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
