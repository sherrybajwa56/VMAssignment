//
//  CustomImageView.swift
//  EmployeeList
//
//  Created by Sherry Bajwa on 1/31/21.
//  Copyright © 2023 None. All rights reserved.
//

import SwiftUI
import Combine

struct CustomImageView: View {

    @ObservedObject private(set) var customImageViewModel: CustomImageViewModel
    
    var body: some View {
        content
            .onAppear(perform: { self.customImageViewModel.update() })
    }

    private var content: Image {
        return Image(uiImage: self.customImageViewModel.image)
                .resizable()
    }
}

struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView(customImageViewModel: .init(imageURL: "https://randomuser.me/api/portraits/women/4.jpg"))
    }
}
