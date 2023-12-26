//
//  CapsuleRoomService.swift
//  OnesFrontend
//
//  Created by 이준호 on 12/27/23.
//

import Alamofire
import Foundation

struct CapsuleRoomService {
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = Constants.dateEncodingStrategy
        return encoder
    }()

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        return formatter
    }()

    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Self.formatter)
        return decoder
    }()

    public static func createCapsuleRoom(
        capsuleRoomRequestDTO: CapsuleRoomRequestDTO,
        completion: @escaping (String) -> Void
    ) {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)

        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Set-Cookie": Global.default.sid,
        ]

        AF.request(
            Constants.baseURL + "/capsule",
            method: .post,
            parameters: capsuleRoomRequestDTO,
            encoder: JSONParameterEncoder(encoder: self.encoder),
            headers: headers
        ).responseDecodable(of: CreateCapsuleRoomDTO.self) { response in
            switch response.result {
            case let .success(response):
                completion(response.data)
            case let .failure(error):
                print(error)
            }
        }
    }

    public static func fetchCapsules(
        userId: Int,
        completion: @escaping (Capsules) -> Void
    ) {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)

        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Set-Cookie": Global.default.sid,
        ]

        AF.request(
            Constants.baseURL + "/capsule",
            method: .get,
            headers: headers
        ).responseDecodable(of: FetchCapsuleResponseDTO.self, decoder: self.decoder) { response in
            switch response.result {
            case let .success(response):
                var array: [Capsule] = []
                response.data.forEach { data in
                    array.append(
                        Capsule(
                            id: data.id,
                            title: data.title,
                            date: data.date,
                            location: data.location,
                            code: data.code,
                            latitude: data.latitude,
                            longitude: data.longitude,
                            createdAt: nil
                        )
                    )
                }
                completion(Capsules(items: array))
            case let .failure(error):
                print(error)
            }
        }
    }
}
