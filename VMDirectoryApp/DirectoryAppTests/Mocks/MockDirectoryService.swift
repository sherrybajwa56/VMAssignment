//
//  MockDirectoryService.swift
//  EmployeeListTests
//
//  Created by Sherry Bajwa on 2/3/23.
//  Copyright © 2023 None. All rights reserved.
//

import Foundation
import Combine
@testable import DirectoryApp

final class MockDirectoryService: APIServiceType {
    var stubs: [Any] = []
    internal let baseURL: String = ""
    internal let session: URLSession = URLSession.shared
    internal let bgQueue: DispatchQueue = DispatchQueue(label: "test")
    
    func stub<Request>(for type: Request.Type, response: @escaping ((Request) -> AnyPublisher<Request.ModelType, Error>)) where Request: APIRequestType {
        stubs.append(response)
    }
    
    func call<Request>(from request: Request) -> AnyPublisher<Request.ModelType, Error> where Request: APIRequestType {
        
        let response = stubs.compactMap { stub -> AnyPublisher<Request.ModelType, Error>? in
            let stub = stub as? ((Request) -> AnyPublisher<Request.ModelType, Error>)
            return stub?(request)
        }.last
        
        return response ?? Empty<Request.ModelType, Error>()
            .eraseToAnyPublisher()
    }
}


