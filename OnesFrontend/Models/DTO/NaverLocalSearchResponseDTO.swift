//
//  NaverLocalSearchResponseDTO.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import Foundation

struct NaverLocalSearchResponseDTO: Codable, Identifiable {
    struct Item: Codable, Identifiable {
        let id: String =  UUID().uuidString
        let title: String
        let link: String
        let category: String
        let description: String
        let telephone: String
        let address: String
        let roadAddress: String
        let mapx: String
        let mapy: String

        enum CodingKeys: CodingKey {
            case title
            case link
            case category
            case description
            case telephone
            case address
            case roadAddress
            case mapx
            case mapy
        }
    }

    let id: String = UUID().uuidString
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [Item]

    enum CodingKeys: CodingKey {
        case lastBuildDate
        case total
        case start
        case display
        case items
    }
}
