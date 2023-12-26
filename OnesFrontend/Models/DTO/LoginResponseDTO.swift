//
//  LoginResponseDTO.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/27/23.
//

import Foundation

struct LoginResponseDTO: Codable {
    struct Data: Codable {
        let id: Int
        let email: String
        let password: String
        let createdAt: Date
        let updatedAt: Date
        let deletedAt: Date?
    }

    let status: Int
    let message: String
    let data: Data
}
