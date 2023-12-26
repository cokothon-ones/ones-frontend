//
//  PhotoComponent.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/26/23.
//

import SwiftUI

struct PhotoComponent: View {
    var name: String
    var body: some View {
        VStack(spacing: 0) {
            Image(name)
                .resizable()
                .frame(width: 150, height: 250)
                .cornerRadius(10)
        }
    }
}

#Preview {
    PhotoComponent(name: "dummyphoto2")
}
