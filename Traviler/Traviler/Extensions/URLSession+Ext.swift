//
//  URLSession+Ext.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 19/12/2020.
//

import Foundation

extension URLSession {
    
    enum Error: Swift.Error {
        case unexpectedError
    }
    
    func fetch<T: Decodable>(_ endpoint: Router, decode: T.Type, completion handler: @escaping (Result<T, Swift.Error>) -> Void) {
        do {
            let urlRequest = try endpoint.asURLRequest()
            self.dataTask(with: urlRequest) {
                data, _, error in
                
                guard let data = data else {
                    guard let error = error else {
                        handler(.failure(URLSession.Error.unexpectedError))
                        return
                    }
                    
                    handler(.failure(error))
                    return
                }
                
                do {
                    let result = try JSON.decoder().decode(T.self, from: data)
                    handler(.success(result))
                } catch {
                    handler(.failure(error))
                }
            }.resume()
            
        } catch {
            handler(.failure(error))
        }
    }
    
}
