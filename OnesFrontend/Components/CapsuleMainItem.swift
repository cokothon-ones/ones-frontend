//
//  CapsuleMainItem.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import SwiftUI

struct CapsuleMainItem: View {
    var capsule: Capsule

    var body: some View {
        HStack(spacing: 0) {
            Text(capsule.title)
            Spacer()
        }
        .frame(height: 50)
        .foregroundColor(Color(0x646464))
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(LinearGradient(colors: [Color(0xFDFDFD)], startPoint: .leading, endPoint: .trailing))
        .cornerRadius(10)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    LinearGradient(
                        colors: [Color(0xD2D7FF), Color(0xAAD7FF)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        })
        .padding(.vertical, 1)
    }
}
