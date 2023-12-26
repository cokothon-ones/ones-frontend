//
//  LocationService.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/27/23.
//

import Alamofire
import Foundation

final class LocationService {
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = Constants.dateEncodingStrategy
        return encoder
    }()

    public static func authLocation(
        locationAuthRequestDTO: LocationAuthRequestDTO,
        completion: @escaping (Bool) -> Void
    ) {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)

        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Set-Cookie": Global.default.sid
        ]

        AF.request(
            Global.baseUrl + "/capsule/auth",
            method: .patch,
            parameters: locationAuthRequestDTO,
            encoder: JSONParameterEncoder(),
            headers: headers
        ).response { result in
            switch result.result {
            case .success(let success):
                completion(true)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
