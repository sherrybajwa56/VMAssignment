//
//  Room.swift
//  EmployeeList
//
//  Created by Sherry on 25/05/23.
//  Copyright © 2023 None. All rights reserved.
//

import Foundation
import UIKit

struct Room: Codable, Identifiable {
    var id: String
    var createdAt: String
    var isOccupied: Bool
    var maxOccupancy: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case isOccupied
        case maxOccupancy
    }
    var status: String {
        return isOccupied ? "Occupied" : "Free"
    }
    var maxOccupancyVal: String {
        return "MaxOccupancy: \(maxOccupancy)"
    }
    var roomName: String {
        return "Room ID: \(id)"
    }
}

let testRoom = Room(id: "1",
                    createdAt: "2022-01-24T20:52:50.765Z",
                    isOccupied: true,
                    maxOccupancy: 53539)
