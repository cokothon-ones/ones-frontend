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

    func getDDay() -> Int {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = "yyyyMMdd"

        let todayString = formatter.string(from: Date.now)
        let targetString = formatter.string(from: self.date)

        guard let today = formatter.date(from: todayString),
              let target = formatter.date(from: targetString)
        else {
            return -1
        }

        return Int(target.timeIntervalSince(today)) / (60 * 60 * 24)
    }

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

    init(id: Int, title: String, date: Date, location: String, latitude: Double, longitude: Double, createdAt: Date) {
        self.id = id
        self.title = title
        self.date = date
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = createdAt
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
