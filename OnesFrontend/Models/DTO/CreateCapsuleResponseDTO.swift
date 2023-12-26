//
//  CreateCapsuleResponseDTO.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/27/23.
//

import Foundation

struct CreateCapsuleResponseDTO: Codable {
    let status: Int
    let message: String
    let capsuleId: String

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case capsuleId = "data"
    }
}
