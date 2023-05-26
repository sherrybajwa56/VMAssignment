//
//  RoomListViewModelTests.swift
//  DirectoryApp
//
//  Created by Sherry on 26/05/23.
//  Copyright © 2023 None. All rights reserved.
//
import Foundation
import XCTest
import Combine
@testable import DirectoryApp

class RoomListViewModelTests: XCTestCase {
    
    func test_updateEmployeeListWhenOnAppear() {
        
        let mockEmployeesService = MockDirectoryService()
        
        mockEmployeesService.stub(for: RoomListRequest.self, response: { _ in
            Result.Publisher(
               [
                .init(id: "1",
                  createdAt: "2022-01-24T20:52:50.765Z",
                  isOccupied: true,
                  maxOccupancy: 53539)
                ]
            ).eraseToAnyPublisher()
            
        })

        let viewModel = RoomListViewModel(service: mockEmployeesService)
        viewModel.update()
        XCTAssertTrue(!viewModel.rooms.isEmpty)
    }
    
    func test_emptyEmployeeListForEmptyJson() {
        let mockService = MockDirectoryService()
        mockService.stub(for: RoomListRequest.self, response: { _ in
            Result.Publisher(
                 []
            ).eraseToAnyPublisher()
            
        })
        let viewModel = RoomListViewModel(service: mockService)
        
        viewModel.update()
        XCTAssertTrue(viewModel.rooms.isEmpty)
    }
    
    func test_throwParseErrorForMalformedJson() {
        let mockService = MockDirectoryService()
        
        let viewModel = RoomListViewModel(service: mockService)
        
        mockService.stub(for: RoomListRequest.self, response: { _ in
            Result.Publisher(
                APIServiceError.parseError
            ).eraseToAnyPublisher()
        })

        viewModel.update()
        XCTAssertEqual(viewModel.errorMessage, APIServiceError.parseError.errorDescription)
    }
}

