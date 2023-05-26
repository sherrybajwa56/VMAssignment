//
//  EmployeeListViewModelTests.swift
//  EmployeeListTests
//
//  Created by Sherry Bajwa on 2/3/23.
//  Copyright © 2023 None. All rights reserved.
//
import Foundation
import XCTest
import Combine
@testable import DirectoryApp

class EmployeeListViewModelTests: XCTestCase {
    
    func test_updateEmployeeListWhenOnAppear() {
        
        let mockEmployeesService = MockDirectoryService()
        
        mockEmployeesService.stub(for: EmployeeListRequest.self, response: { _ in
            Result.Publisher(
               [
                    .init(id: "1",
                          createdAt: "2022-01-24T17:02:23.729Z",
                          firstName: "sherry",
                          lastName: "bajwa",
                          avatar: "https://randomuser.me/api/portraits/women/21.jpg",
                          email: "sherrybajwa56@gmail.com",
                          jobtitle: "Software Engineer",
                          favouriteColor: "blue")
                ]
            ).eraseToAnyPublisher()
            
        })

        let viewModel = EmployeeListViewModel(employeesService: mockEmployeesService)
        viewModel.update()
        XCTAssertTrue(!viewModel.employees.isEmpty)
    }
    
    func test_emptyEmployeeListForEmptyJson() {
        let mockEmployeesService = MockDirectoryService()
        mockEmployeesService.stub(for: EmployeeListRequest.self, response: { _ in
            Result.Publisher(
                 []
            ).eraseToAnyPublisher()
            
        })
        let viewModel = EmployeeListViewModel(employeesService: mockEmployeesService)
        
        viewModel.update()
        XCTAssertTrue(viewModel.employees.isEmpty)
    }
    
    func test_throwParseErrorForMalformedJson() {
        let mockEmployeesService = MockDirectoryService()
        
        let viewModel = EmployeeListViewModel(employeesService: mockEmployeesService)
        
        mockEmployeesService.stub(for: EmployeeListRequest.self, response: { _ in
            Result.Publisher(
                APIServiceError.parseError
            ).eraseToAnyPublisher()
        })

        viewModel.update()
        XCTAssertEqual(viewModel.errorMessage, APIServiceError.parseError.errorDescription)
    }
}
