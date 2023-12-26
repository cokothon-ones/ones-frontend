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
            ZStack {
                Image(name)
                    .resizable()
                    .frame(width: 186, height: 186)
                    .blur(radius: 5, opaque: true)
            }
        }
    }
}
