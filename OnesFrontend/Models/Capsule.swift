//
//  Capsule.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import Foundation

struct Capsule: Identifiable, Codable {
    let id: Int
    let title: String
    let date: Date
    let location: String
    let latitude: Double
    let longitude: Double
    let createdAt: Date

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.date, forKey: .date)
        try container.encode(self.location, forKey: .location)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
        try container.encode(self.createdAt, forKey: .createdAt)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case date
        case location
        case latitude
        case longitude
        case createdAt = "created_at"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.date = try container.decode(Date.self, forKey: .date)
        self.location = try container.decode(String.self, forKey: .location)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
    }
}
