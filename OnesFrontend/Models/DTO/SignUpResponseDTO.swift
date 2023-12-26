//
//  SignUpResponseDTO.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/27/23.
//

import Foundation

struct SignUpResponseDTO: Codable {
    let status: Int
    let message: String
    let data: String
}
