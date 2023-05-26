//
//  RoomListViewRow.swift
//  EmployeeList
//
//  Created by Sherry on 25/05/23.
//  Copyright © 2023 None. All rights reserved.
//

import SwiftUI
import UIKit

struct RoomListRow: View {
    @State var room: Room

    var body: some View {
        HStack {
            VStack {
                Text(room.roomName)
                Text(room.maxOccupancyVal).multilineTextAlignment(.trailing)
            }
            Spacer()
            if room.isOccupied {
                Text(room.status)
                    .foregroundColor(.red)
            }
            else {
                Text(room.status)
                    .foregroundColor(.green)
            }
        }
    }
}

struct RoomListRow_Previews: PreviewProvider {
    static var previews: some View {
        RoomListRow(room: testRoom)
    }
}
