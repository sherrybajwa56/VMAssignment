
//
//  EmployeeListService.swift
//  EmployeeList
//
//  Created by Sherry Bajwa on 4/29/23.
//  Copyright © 2023 None. All rights reserved.
//

import Foundation
import Combine

final class DirectoryAPIService: APIServiceType {

    internal let baseURL: String
    internal let session: URLSession = URLSession.shared
    internal let bgQueue: DispatchQueue = DispatchQueue.main

    init(baseURL: String = VMApi.baseUrl) {
        self.baseURL = baseURL
    }
 
    func call<Request>(from endpoint: Request) -> AnyPublisher<Request.ModelType, Error> where Request : APIRequestType {
        do {
            let request = try endpoint.buildRequest(baseURL: baseURL)
            return session.dataTaskPublisher(for: request)
                .retry(1)
                .tryMap {
                    guard let code = ($0.response as? HTTPURLResponse)?.statusCode else {
                        throw APIServiceError.unexpectedResponse
                    }
                    guard HTTPCodes.success.contains(code) else {
                        throw APIServiceError.httpError(code)
                    }
                    return $0.data  // Pass data to downstream publishers
                }
                .decode(type: Request.ModelType.self, decoder: JSONDecoder())
                .mapError { err in
                    APIServiceError.parseError
                }
                .receive(on: self.bgQueue)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<Request.ModelType, Error>(error: error).eraseToAnyPublisher()
        }
    }
}
