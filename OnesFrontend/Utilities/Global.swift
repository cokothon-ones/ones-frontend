//
//  Global.swift
//  OnesFrontend
//
//  Created by 최정민 on 12/27/23.
//

import Foundation
import NMapsMap

final class Global {
    static let `default`: Global = .init()
    private init() {}

    var mapView: NMFNaverMapView = .init()

    static let baseUrl = "https://localhost"
}
