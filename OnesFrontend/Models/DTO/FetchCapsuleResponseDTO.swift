//
//  FetchCapsuleResponseDTO.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/27/23.
//

import Foundation

struct FetchCapsuleResponseDTO: Codable {
    let status: Int
    let message: String
    let data: Data

    struct Data: Codable {
        let id: Int
        let title: String
        let date: Date
        let auth_time: Date?
        let location: String
        let latitude: Double
        let longitude: Double
        let code: String
    }
}
