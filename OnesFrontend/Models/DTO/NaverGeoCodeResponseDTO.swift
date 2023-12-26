//
//  NaverGeoCodeResponseDTO.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import Foundation

struct NaverGeoCodeResponseDTO: Codable {
    struct Meta: Codable {
        let totalCount: Int
        let page: Int
        let count: Int

        enum CodingKeys: CodingKey {
            case totalCount
            case page
            case count
        }
    }

    struct AddressElement: Codable {
        let types: [String]
        let longName: String
        let shortName: String
        let code: String
    }

    struct Address: Codable {
        let roadAddress: String
        let jibunAddress: String
        let englishAddress: String
        let x: String
        let y: String
        let distance: Double
        let addressElements: [AddressElement]
    }

    let status: String
    let errorMessage: String
    let meta: Meta
    let addresses: [Address]
}
