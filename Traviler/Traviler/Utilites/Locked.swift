//
//  Locked.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 22/12/2020.
//

import Foundation

class Locked<T> {
    private var content: T
    private let semaphore = DispatchSemaphore(value: 1)
    
    init(_ content: T) {
        self.content = content
    }
    
    func withLock<R>(_ workItem: (inout T) throws -> R) rethrows -> R {
        semaphore.wait()
        
        defer {
            semaphore.signal()
        }
        
        return try workItem(&content)
    }
}
