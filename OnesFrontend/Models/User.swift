//
//  User.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/27/23.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let password: String

    enum CodingKeys: CodingKey {
        case id
        case email
        case password
    }
}
