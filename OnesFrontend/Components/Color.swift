//
//  Color.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import Foundation
import SwiftUI

extension Color {
    init(_ hex: Int, opacity: Double = 1) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            opacity: opacity
        )
    }
}
