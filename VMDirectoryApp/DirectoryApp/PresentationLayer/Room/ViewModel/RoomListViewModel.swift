//
//  RoomListViewModel.swift
//  DirectoryApp
//
//  Created by Sherry on 25/05/23.
//  Copyright © 2023 None. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class RoomListViewModel: ObservableObject {
    private var cancellables: [AnyCancellable] = []
    
    private let onAppearSubject = PassthroughSubject<Void, Error>()
    
    private let roomService: APIServiceType
    
    // Publish values on-demand by calling the send() method
    func update() {
        onAppearSubject.send(())
        //objectWillChange.send()
    }
    
    @Published var rooms: [Room] = []

    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init(service: APIServiceType = DirectoryAPIService()) {
        self.roomService = service
        
        fetchEmployeeList()
        print("------- room list view model init done ---------")
    }
    
    private func fetchEmployeeList() {
        
        let endpoint = RoomListRequest(path: VMApi.roomsEndPoint)
        let publisher = onAppearSubject.flatMap { _ -> AnyPublisher<[Room], Error> in
            return self.roomService.call(from: endpoint)
        }

        let roomStream = publisher
            .map { $0 }
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error): do {
                    self.errorMessage = error.localizedDescription
                    self.isErrorShown = true;
                    }
                case .finished:
                    break
                }
                
            }, receiveValue: { (rooms) in
                self.rooms = rooms
            })
        
        cancellables += [
            roomStream
        ]
    }
}

