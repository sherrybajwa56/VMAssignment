//
//  EmployeeListRow.swift
//  EmployeeList
//
//  Created by Sherry Bajwa on 4/29/23.
//  Copyright © 2023 None. All rights reserved.
//

import SwiftUI
import UIKit

struct EmployeeListRow: View {
    @State var employee: Employee
    
    var body: some View {
        NavigationLink(destination: EmployeeDetailView(employee: employee)) {
            HStack {
                CustomImageView(customImageViewModel: .init(imageURL: employee.avatar))
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                Text(employee.firstName)
                Spacer()
            }
            .padding()
        }
    }
}

struct EmployeeListRow_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListRow(employee: testEmployee)
    }
}
