//
//  CapsuleMainItem.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import SwiftUI

struct CapsuleMainItem: View {
    var title: String

    var body: some View {
        ZStack {
            Text(title)
                .foregroundColor(Color(0xFDFDFD))
                .frame(
                    width: (UIScreen.main.bounds.size.width - 50) / 2,
                    height: (UIScreen.main.bounds.size.width - 50) / 2
                )
        }
        .background {
            Color.random
        }
        .cornerRadius(10)
    }
}

#Preview {
    CapsuleMainItem(title: "TEST CAPSULE")
}
