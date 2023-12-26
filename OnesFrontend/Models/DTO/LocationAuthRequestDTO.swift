//
//  LocationAuthRequestDTO.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/27/23.
//

import Alamofire
import Foundation

struct LocationAuthRequestDTO: Codable {
    let userId: Int
    let capsule_id: Int
    let auth_time: Double
}
