//
//  ProfileSummary.swift
//  EmployeeList
//
//  Created by Sherry Bajwa on 3/6/21.
//  Copyright © 2023 None. All rights reserved.
//

import SwiftUI

struct EmployeeProfile: View {
    @Binding var employee: Employee
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                
                CustomImageView(customImageViewModel: .init(imageURL: employee.avatar))
                    .frame(width: 200, height: 200)
                    .cornerRadius(100)
                Text(employee.fullname)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            
            VStack {
                Divider()
                VStack(alignment: .center, spacing: 10) {
                    Text("About")
                        .frame(width: 80, height: 1, alignment: .leading)
                    VStack {
                        Text(employee.jobtitle)
                     
                        Text(employee.email)
                       
                        Text("Favoute Color: \(employee.favouriteColor)")
                        Spacer()
                    }
                    .foregroundColor(.gray)
                    
                }
                .padding()
            }
            .offset(x: 0, y: 80)
        }
        .padding(.bottom)

    }
}

struct EmployeeProfile_Previews: PreviewProvider {
    @State static var employee = testEmployee
    static var previews: some View {
        EmployeeProfile(employee: $employee)
    }
}
