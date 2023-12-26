//
//  Capsules.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/26/23.
//

import Foundation
import NMapsMap

class Capsules {
    private var items: [Capsule] = []

    init(items: [Capsule]) {
        self.items = items
    }

    func getCapsules(locked: Bool) -> Capsules {
        return Capsules(items: items.filter { item in
            if Date.now < item.date {
                if locked {
                    return true
                } else {
                    return false
                }
            }

            if locked {
                return false
            } else {
                return true
            }
        })
    }

    func getTodayCapsule() -> Capsules {
        return Capsules(items: items.filter { item in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"

            if dateFormatter.string(from: .now) == dateFormatter.string(from: item.date) {
                return true
            }
            return false
        })
    }

    func getLatLng() -> [NMGLatLng] {
        return items.map { item in
            NMGLatLng(lat: item.latitude, lng: item.longitude)
        }
    }
}
