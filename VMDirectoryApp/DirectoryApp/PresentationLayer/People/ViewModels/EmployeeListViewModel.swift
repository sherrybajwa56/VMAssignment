//
//  EmployeeListViewModel.swift
//  EmployeeList
//
//  Created by Sherry Bajwa on 4/29/23.
//  Copyright © 2023 None. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class EmployeeListViewModel: ObservableObject {
    private var cancellables: [AnyCancellable] = []
    
    private let onAppearSubject = PassthroughSubject<Void, Error>()
    
    private let employeesService: APIServiceType
    
    // Publish values on-demand by calling the send() method
    func update() {
        onAppearSubject.send(())
        //objectWillChange.send()
    }
    
    @Published var employees: [Employee] = []

    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init(employeesService: APIServiceType = DirectoryAPIService()) {
        self.employeesService = employeesService
        
        fetchEmployeeList()
        print("------- employee list view model init done ---------")
    }
    
    private func fetchEmployeeList() {
        
        let endpoint = EmployeeListRequest(path: VMApi.peopleEndPoint)
        let publisher = onAppearSubject.flatMap { _ -> AnyPublisher<[Employee], Error> in
            return self.employeesService.call(from: endpoint)
        }
        
        let employeesStream = publisher
            .map {
                $0
            }
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error): do {
                    self.errorMessage = error.localizedDescription
                    self.isErrorShown = true;
                    }
                case .finished:
                    break
                }
                
            }, receiveValue: { (employees) in
                self.employees = employees
            })
        
        cancellables += [
            employeesStream
        ]
    }
}
