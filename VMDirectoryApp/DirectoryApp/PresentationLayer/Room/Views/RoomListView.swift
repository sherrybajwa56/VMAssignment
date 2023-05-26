//
//  RoomListView.swift
//  EmployeeList
//
//  Created by Sherry on 25/05/23.
//  Copyright © 2023 None. All rights reserved.
//


import SwiftUI

struct RoomListView: View {
    @ObservedObject private(set) var roomListViewModel: RoomListViewModel

    var body: some View {
        // We need to return a row wrapped up in a navigation button to allow user to tap on it
        // Then trigger a destination for that button
        NavigationView {
            List {
                ForEach(roomListViewModel.rooms, id: \.id) { room in
                    RoomListRow(room: room)
                }
            }
            .alert(isPresented: $roomListViewModel.isErrorShown, content: { () -> Alert in
                Alert(title: Text("Error"), message: Text(roomListViewModel.errorMessage))
            })
            .navigationBarTitle(Text("Rooms"), displayMode: .inline)
        }
        .onAppear(perform: {self.roomListViewModel.update()})
        //.onAppear(perform: {self.roomListViewModel.objectWillChange.send()})
    }
}

struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomListView(roomListViewModel: .init())
    }
}
