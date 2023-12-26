//
//  CapsuleRoomRequestDTO.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/27/23.
//

import Foundation

struct CapsuleRoomRequestDTO: Codable {
    let title: String
    let date: Date
    let location: String
    let latitude: Double
    let longitude: Double
}
