//
//  PhotoComponent.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/26/23.
//

import SwiftUI

enum PhotoMode {
    case edit
    case read
}

struct PhotoComponent: View {
    var mode: PhotoMode = .edit
    var name: String

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Image(name)
                    .resizable()
                    .frame(width: 186, height: 186)
                    .blur(radius: mode == .read ? 0 : 5, opaque: true)
            }
        }
    }
}
