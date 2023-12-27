//
//  Global.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/27/23.
//

import Foundation
import NMapsMap

final class Global: ObservableObject {
    static let `default`: Global = .init()
    private init() {}

    var mapView: NMFNaverMapView = .init()

    static let baseUrl = "http://10.223.116.154:3000"

    var user: User = .init(id: 1234, email: "test1@test.com", password: "1234")
    var capsules: Capsules = .init(items: [])

    var sid: String = ""
}
