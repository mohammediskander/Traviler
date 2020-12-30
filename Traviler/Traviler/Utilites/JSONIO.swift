//
//  JSONIO.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 28/12/2020.
//

import Foundation

class JSONIO {
    
    /// GDC queue with `.userInitiated` Quality of Service
    private let counterQueue = DispatchQueue.global(qos: .userInitiated)
    
    struct State {
        var url: URL? = nil
    }
    private var lockedState = Locked(State())
    
    var currentState: State {
        return self.lockedState.withLock { $0 }
    }
    
    func read<T: Decodable>(from url: URL, decodeType type: T.Type, complection handler: @escaping (Result<T, Error>) -> Void) {
        
        do {
            let rawData = try Data(contentsOf: url)
            let decodedData = try JSON.decoder().decode(T.self, from: rawData)
            
            handler(.success(decodedData))
        } catch {
            handler(.failure(error))
        }
        
    }
    
    func write<T: Encodable>(_ data: T, to url: URL, completion handler: @escaping () -> Void = { }) throws {
        let encodedData = try JSON.encoder().encode(data)
        try encodedData.write(to: url)
        
        handler()
    }
    
}
