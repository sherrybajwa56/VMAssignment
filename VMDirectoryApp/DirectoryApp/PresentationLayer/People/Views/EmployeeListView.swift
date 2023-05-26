//
//  EmployeeListView.swift
//  EmployeeList
//
//  Created by sherry bajwa on 5/23/23.
//  Copyright © 2023 None. All rights reserved.
//

import SwiftUI

struct EmployeeListView: View {
    @ObservedObject private(set) var employeeListViewModel: EmployeeListViewModel

    var body: some View {
    
        NavigationView {
            List {
                ForEach(employeeListViewModel.employees, id: \.id) { employee in
                    EmployeeListRow(employee: employee)
                }
            }
            .alert(isPresented: $employeeListViewModel.isErrorShown, content: { () -> Alert in
                Alert(title: Text("Error"), message: Text(employeeListViewModel.errorMessage))
            })
            .navigationBarTitle(Text("Employees"), displayMode: .inline)
        }
        .onAppear(perform: {self.employeeListViewModel.update()})
    }
}

struct EmployeeListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListView(employeeListViewModel: .init())
    }
}
