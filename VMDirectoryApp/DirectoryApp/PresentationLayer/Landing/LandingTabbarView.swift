//
//  LandingTabbarView.swift
//  EmployeeList
//
//  Created by Sherry on 25/05/23.
//  Copyright © 2023 None. All rights reserved.
//

import Foundation
import SwiftUI

struct TabBarView: View {

    var body: some View {

        TabView {
            NavigationView{
                EmployeeListView(employeeListViewModel: .init())
            }
            .tabItem {
                Image(systemName: AppTheme.personTabImage)
                Text(AppTheme.employeeListTitle)
               
            }

            NavigationView{
                RoomListView(roomListViewModel: .init())
            }
            .tabItem {
                Image(systemName: AppTheme.roomTabImage)
                Text(AppTheme.roomListTitle)
            }
        }.accentColor(Color(AppTheme.themeColour))
    }
}
