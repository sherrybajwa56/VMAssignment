//
//  EmployeeDetailView.swift
//  EmployeeList
//
//  Created by Sherry Bajwa on 3/6/21.
//  Copyright © 2023 None. All rights reserved.
//

import SwiftUI

struct EmployeeDetailView: View {
    @State var employee: Employee
    @State var draftProfile  = testEmployee
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            EmployeeProfile(employee: $employee)
            
        }
        .padding()
    }
}

struct EmployeeDetailView_Previews: PreviewProvider {
    //@State static var employee = testEmployee
    static var previews: some View {
        EmployeeDetailView(employee: testEmployee)
    }
}
